//
//  JGAvailableCalendar.m
//  EmpTraRent
//
//  Created by spring on 2019/11/27.
//  Copyright © 2019 spring. All rights reserved.
//

#import "JGAvailableCalendar.h"
#import "JGAvailableCalendarCH.h"
#import "JGAvailableCalendarCCell.h"
#import "NSDate+JGCalendar.h"
#import "JGCalendarDayModel.h"



#import "JGAvailableTimeChooseActionSheet.h" //时间选取

#define MonthCount 5 //5个月

@interface JGAvailableCalendar () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *CollectionView;

@property (nonatomic, strong) NSMutableArray<NSMutableArray <JGCalendarDayModel *> *> *calendarMonth;

//选中的 左侧 日期模型
@property (nonatomic, strong) JGCalendarDayModel *LeftModel;
//选中的 右侧 日期模型
@property (nonatomic, strong) JGCalendarDayModel *RightModel;

@end

static NSString * const JGAvailableCalendarCHId = @"JGAvailableCalendarCHId";
static NSString * const JGAvailableCalendarCCellId = @"JGAvailableCalendarCCellId";

@implementation JGAvailableCalendar

- (NSMutableArray *)calendarMonth {
    if (!_calendarMonth) {
        _calendarMonth = [NSMutableArray array];
        
        NSDate *date = [NSDate date];
        
        for (int i = 0; i < MonthCount; i ++) {
            
            NSMutableArray *DayArrM = [NSMutableArray array];
            //N月后的日期
            NSDate *Date = [date dayInTheFollowingMonth:i];
            //对象对应的月份的总天数
            NSInteger totalDaysInMonth = Date.totalDaysInMonth;
            //对象对应月份当月第一天的所属星期 就是空视图
            NSInteger firstWeekDayInMonth = Date.firstWeekDayInMonth == 0 ? 6 : Date.firstWeekDayInMonth-1 ;
            
            NSInteger TotalCount = totalDaysInMonth + firstWeekDayInMonth;
            NSInteger itemCount = TotalCount > 35 ? 42 : 35;
            
            for (int j = 1; j <= itemCount; j++) {

                JGCalendarDayModel *Model;

                if (j > firstWeekDayInMonth && j <= TotalCount) {
                    
                    Model = [JGCalendarDayModel calendarDayWithYear:Date.dateYear month:Date.dateMonth day:j - firstWeekDayInMonth];
        
                    if (Model.date.isItPassday) {
                        
                        Model.style = CellDayTypePast;
                    }else {
                        
                        NSString *dateStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld",Model.year, Model.month,Model.day];
                       
                        Model.style = CellDayTypeAllCanDay;

                        for (JGCarCalendarItemsModel *mo in self.items) {
                            if ([mo.date isEqualToString:dateStr]) {
                                // 1 全天不可租 2 半天不可租
                                if (mo.type == 1) {
                                    
                                    Model.style = CellDayTypeAllDay;
                                }else if (mo.type == 2){
                                    
                                    Model.style = CellDayTypePartDay;
                                }
                            }
                        }
                    }
                }else {
                    
                    Model = [[JGCalendarDayModel alloc] init];
                    Model.style = CellDayTypeEmpty;
                }
                
                [DayArrM addObject:Model];
            }

            [_calendarMonth addObject:DayArrM];
        }
    }
    return _calendarMonth;
}


- (UICollectionView *)CollectionView {
    if (!_CollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        _CollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _CollectionView.backgroundColor = [UIColor whiteColor];
        _CollectionView.delegate = self;
        _CollectionView.dataSource = self;
        //        _CollectionView.scrollsToTop = NO;
        _CollectionView.showsVerticalScrollIndicator = NO;
        _CollectionView.showsHorizontalScrollIndicator = NO;
        
        
        [_CollectionView registerClass:[JGAvailableCalendarCH class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:JGAvailableCalendarCHId];
        
        [_CollectionView registerClass:[JGAvailableCalendarCCell class]
            forCellWithReuseIdentifier:JGAvailableCalendarCCellId];
    }
    return _CollectionView;
}


- (void)setTimeArr:(NSArray *)timeArr {
    _timeArr = timeArr;
    
    if (!timeArr.count) return;
    
    self.LeftModel = [timeArr firstObject];
    self.RightModel = [timeArr lastObject];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.LeftDateInfo) {
            self.LeftDateInfo(self.LeftModel);
        }
        
        if (self.RightDateInfo) {
            self.RightDateInfo(self.RightModel);
        }
    });
    
    [self AvailableTimeLogic];
    
    //滚动到 选中日期
    NSDate *CurDate = [NSDate date];
    NSInteger Section = self.LeftModel.month - CurDate.dateMonth + 1;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
          [self.CollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:Section] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
    });
}


- (void)configUI {
    
    [self addSubview:self.CollectionView];
    
    [_CollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.calendarMonth.count;
}

//指定有多少个子视图
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.calendarMonth objectAtIndex:section].count; //5*7
}

// 显示表头的数据
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader){ //头部视图
        
        JGAvailableCalendarCH *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:JGAvailableCalendarCHId forIndexPath:indexPath];
        JGCalendarDayModel *Model = [[self.calendarMonth objectAtIndex:indexPath.section] objectAtIndex:10];
        header.TitleLbl.text = [NSString stringWithFormat:@"%ld年%ld月",Model.date.dateYear, Model.date.dateMonth];
        return header;
    } else {  //尾部视图
        return  nil;
    }
}


//指定子视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JGAvailableCalendarCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JGAvailableCalendarCCellId forIndexPath:indexPath];
    JGCalendarDayModel *Model = [[self.calendarMonth objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.Model = Model;
    return cell;
}

#pragma mark - 详情 -
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    JGLog(@"%d - %d", self.isLeftCanSel, self.isRightCanSel);
    
    JGCalendarDayModel *Model = [[self.calendarMonth objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    /*
     CellDayTypeEmpty = 0,   //不显示
     CellDayTypePast,    //过去的日期
     CellDayTypeAllDay,    //全天不可租
     CellDayTypePartDay,    //半天不可租
     CellDayTypeAllCanDay,    //全天可租
     */
    
    if (Model.style == CellDayTypePartDay || Model.style == CellDayTypeAllCanDay) {
        
        JGAvailableTimeChooseActionSheet *sheet = [JGAvailableTimeChooseActionSheet new];
        sheet.StartModel = Model;
        WEAKSELF;
        sheet.TimeBackInfo = ^(NSString *timeStr) {
            
//            Model.timeStr = timeStr;
            
//            JGLog(@"-----%@",Model.toString);
            //记录左侧模型
            if (weakSelf.isLeftCanSel) {
                
                weakSelf.LeftModel = [Model copy];
                weakSelf.LeftModel.timeStr = timeStr;
                weakSelf.RightModel = nil;
            }
            
            //记录右侧模型
            if (weakSelf.isRightCanSel) {
                weakSelf.RightModel = [Model copy];
                weakSelf.RightModel.timeStr = timeStr;
            }
            
            if (weakSelf.LeftModel != nil && weakSelf.RightModel != nil) {
                
               //比较选中的两个日期
                int result = [NSDate compareOneDay:[NSDate dateFromString:weakSelf.RightModel.toString] withAnotherDay:[NSDate dateFromString:weakSelf.LeftModel.toString]];
                
//                JGLog(@"\n%@ \n %@", self.LeftModel.toString, self.RightModel.toString);
                
                NSInteger Index = -1;
                //判断选中的两个日期间是否都可以租车
                for (NSArray *MonthArr in weakSelf.calendarMonth) {
                    
                    for (JGCalendarDayModel *Mo in MonthArr) {
                 
                        //比较两个日期
                        int lResult = [NSDate compareOneDay:Mo.date withAnotherDay:weakSelf.LeftModel.date];
                        int rResult = [NSDate compareOneDay:Mo.date withAnotherDay:weakSelf.RightModel.date];
                        
                         if (lResult == 1 && rResult == -1) {
                          
                             if (Mo.style == CellDayTypeAllDay) {
                                 Index = 10;
                                 break;
                             }
                         }
                    }
                    if (Index == 10) {
                        break;
                    }
                }
                
                if (Index == -1) {
                    
                    //先复原
                    [weakSelf ReSetAvailableTimeLogic];
                    
                    if (result == -1) {
//                        //LeftModel 和 RightModel 需要交换 以保证开始时间小于结束时间
//                        JGCalendarDayModel *tempModel = self.LeftModel;
//                        self.LeftModel = self.RightModel;
//                        self.RightModel = tempModel;
//
//                        //可使用时间渲染
//                        [weakSelf AvailableTimeLogic];
                        
//                        [self ClearAllSelectedDate];
//                        self.RightModel
//                        self.RightModel = nil;
 
                        
                        weakSelf.LeftModel = [Model copy];
                        weakSelf.LeftModel.timeStr = timeStr;
                        weakSelf.RightModel = nil;
                        //可使用时间渲染
                        [weakSelf AvailableTimeLogic];
                        
                    }else if (result == 1) {
//                         [self ReSetAvailableTimeLogic];
                        //可使用时间渲染
                        [weakSelf AvailableTimeLogic];
                    }else {
                        dispatch_main_async_safe(^{
                            [JGToast showWithText:@"租车时间段不合理，请重新选择"];
                        })
                    }
                }else {
                    
                    dispatch_main_async_safe(^{
                        [JGToast showWithText:@"租车时间段不合理，请重新选择"];
                    })
                }
            }else {
                //可使用时间渲染
                [weakSelf AvailableTimeLogic];
            }
        };
        
        [sheet show];
    }
}


- (void)ReSetAvailableTimeLogic {
    
    
    for (NSArray *MonthArr in self.calendarMonth) {
        
        for (JGCalendarDayModel *Mo in MonthArr) {
            
            Mo.bgType = CellDayTypeSelHide;
        }
    }
}



#pragma mark - 已选时间渲染 -
- (void)AvailableTimeLogic {
    
    /*
     CellDayTypeSelHide = 0, //默认隐藏
     CellDayTypeSelRound,  //被选中日期 全部切圆
     CellDayTypeSelLeft,    //被选中日期 背景 左侧切圆角
     CellDayTypeSelCenter,  //被选中日期 背景 不切圆角
     CellDayTypeSelRight    //被选中日期 背景 右侧侧切圆角
     */
    for (NSArray *MonthArr in self.calendarMonth) {
        
        for (JGCalendarDayModel *Mo in MonthArr) {
            
            Mo.bgType = CellDayTypeSelHide;
            
            BOOL isSameDay = (self.LeftModel.year == self.RightModel.year && self.LeftModel.month == self.RightModel.month && self.LeftModel.day == self.RightModel.day);
            
            if (self.RightModel == nil || isSameDay) { //只选了左侧一个时间值
                
                //比较两个日期
                int result = [NSDate compareOneDay:Mo.date withAnotherDay:self.LeftModel.date];
                if (result == 0) {
                    Mo.bgType = CellDayTypeSelRound;
                }
            }else {//选取了两个时间值
                
                    //比较两个日期
                    int lResult = [NSDate compareOneDay:Mo.date withAnotherDay:self.LeftModel.date];
                    int rResult = [NSDate compareOneDay:Mo.date withAnotherDay:self.RightModel.date];
                    
                    /*
                     1周日 2周一 3周二 4周三 5周四 6周五 7周六
                     */
                    
                    if (lResult == 0) {
                        
                        if (Mo.week == 1 || Mo.day == Mo.date.numberOfDaysInCurrentMonth) {
                            Mo.bgType = CellDayTypeSelRound;
                        }else {
                            Mo.bgType = CellDayTypeSelLeft;
                        }
                    }
                    
                    if (rResult == 0) {
                        
                        if (Mo.week == 2 || Mo.day == 1) {
                            Mo.bgType = CellDayTypeSelRound;
                        }else {
                            Mo.bgType = CellDayTypeSelRight;
                        }
                    }
                    
                    if (lResult == 1 && rResult == -1) {
                        
                        if (Mo.day == 1 && Mo.week == 1) {
                            
                            Mo.bgType = CellDayTypeSelRound;
                        }else if (Mo.week == 2 || Mo.day == 1) {
                            
                            Mo.bgType = CellDayTypeSelLeft;
                        }else if (Mo.week == 1 || Mo.day == Mo.date.numberOfDaysInCurrentMonth) {
                            
                            Mo.bgType = CellDayTypeSelRight;
                        }else {
                            
                            Mo.bgType = CellDayTypeSelCenter;
                        }
                    }
                }
        }
    }
    
    if (self.LeftDateInfo) {
        self.LeftDateInfo(self.LeftModel);
    }
    
    if (self.RightDateInfo) {
        self.RightDateInfo(self.RightModel);
    }
    
    [self.CollectionView reloadData];    
}


// 表头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return  CGSizeMake(kDeviceWidth, 50);
}

// 表尾尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

//返回每个子视图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat W = (kDeviceWidth - 28.0) / 7.0;
    return CGSizeMake(W, W);
}

//设置每个子视图的缩进
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //UIEdgeInsets insets = {top, left, bottom, right};
    return UIEdgeInsetsMake(0, 14, 0, 14);
}

//设置子视图上下之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}

//设置子视图左右之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}


//清除所有选中的日期
- (void)ClearAllSelectedDate {
    
    for (NSArray *MonthArr in self.calendarMonth) {
        
        for (JGCalendarDayModel *Mo in MonthArr) {
            
            Mo.bgType = CellDayTypeSelHide;
        }
    }
    
    self.LeftModel = nil;
    self.RightModel = nil;

    
    if (self.LeftDateInfo) {
        self.LeftDateInfo(self.LeftModel);
    }
    
    if (self.RightDateInfo) {
        self.RightDateInfo(self.RightModel);
    }
    
    [self.CollectionView reloadData];
}



@end
