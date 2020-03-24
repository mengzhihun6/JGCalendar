//
//  JGAvailableTimeChooseActionSheet.m
//  EmpTraRent
//
//  Created by spring on 2019/11/27.
//  Copyright © 2019 spring. All rights reserved.
//

#import "JGAvailableTimeChooseActionSheet.h"

#define AlertHeight (kDeviceHight - 274)



@interface JGAvailableTimeChooseActionSheetView : UIView

@property(nonatomic,strong) UILabel *TitleLbl;

@property(nonatomic,strong) UIView *Line;

@end


@implementation JGAvailableTimeChooseActionSheetView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _TitleLbl = [UILabel new];
        _TitleLbl.font = JGFont(20);
        _TitleLbl.textColor = JGHexColor(@"#282828");
        _TitleLbl.textAlignment = NSTextAlignmentCenter;
        
        _Line = [UIView new];
        _Line.backgroundColor = JGHexColor(@"#E5E5EA");
        
        
        [self addSubview:_TitleLbl];
        [self addSubview:_Line];

        [_TitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self);
        }];
        
        [_Line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.height.equalTo(@(0.5));
        }];
    }
    return self;
}

@end




@interface JGAvailableTimeChooseActionSheet () <UIPickerViewDelegate,UIPickerViewDataSource>

/** 弹窗 */
@property(nonatomic,retain) UIView *alertView;
//标题
@property (nonatomic, strong) UILabel *TitleLbl;
//picker
@property (strong, nonatomic) UIPickerView *pickerView;
//下一步
@property (strong, nonatomic) UIButton *nextBtn;
@property (strong, nonatomic) UILabel *colonLbl;
//保存自定义的小时
@property (nonatomic, strong) NSArray *HourArrM;
//保存自定义的分钟
@property (nonatomic, strong) NSArray *MinuteArrM;
//记录选中的小时  默认00
@property (nonatomic, copy) NSString *HourStr;
//记录选中的分钟  默认00
@property (nonatomic, copy) NSString *MinuteStr;
//当前小时
@property (nonatomic, assign) NSInteger CurrentHour;
//当前分钟
@property (nonatomic, assign) NSInteger CurrentMinute;

@property (nonatomic, assign) BOOL isTimeOut;



@end


@implementation JGAvailableTimeChooseActionSheet

- (NSArray *)HourArrM {
    if (!_HourArrM) {
        _HourArrM = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23"];
    }
    return _HourArrM;
}

- (NSArray *)MinuteArrM {
    if (!_MinuteArrM) {
        _MinuteArrM = @[@"00",@"15",@"30",@"45"];
    }
    return _MinuteArrM;
}

- (void)configUI {
    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.01 alpha:0.5];
    
    self.CurrentHour = -1;
    self.CurrentMinute = -1;
    _HourStr = @"00";
    _MinuteStr = @"00";
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceHight, kDeviceWidth, kDeviceHight - AlertHeight)];
    [JGCommonTools configArbitraryCornerRadiusView:_alertView cornerRadius:10 withType:ArbitraryCornerRadiusViewTypeTopLeftTopRight];
    _alertView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_alertView];
    
    UIButton *cancelBtn = [UIButton new];
    cancelBtn.titleLabel.font = JGFont(12);
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [cancelBtn setTitleColor:JG333Color forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(CloseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _TitleLbl = [UILabel new];
    _TitleLbl.textColor = JG333Color;
    _TitleLbl.font = JGFont(16);
    _TitleLbl.text = @"请选择时间";
    
    _nextBtn = [UIButton new];
    _nextBtn.titleLabel.font = JGFont(12);
    _nextBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_nextBtn setTitleColor:JG333Color forState:UIControlStateNormal];
    [_nextBtn setTitleColor:JG999Color forState:UIControlStateDisabled];

    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _pickerView = [UIPickerView new];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
    _colonLbl = [UILabel new];
    _colonLbl.textColor = JGHexColor(@"#282828");
    _colonLbl.font = JGFont(18);
    _colonLbl.text = @":";
    
    
    [_alertView addSubview:cancelBtn];
    [_alertView addSubview:_TitleLbl];
    [_alertView addSubview:_nextBtn];
    [_alertView addSubview:_pickerView];
    [_pickerView addSubview:_colonLbl];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_alertView.mas_left).mas_offset(16);
        make.centerY.equalTo(_TitleLbl.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 50));
    }];
    
    [_TitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_alertView.mas_centerX);
        make.top.equalTo(_alertView.mas_top).mas_offset(5);
        make.height.equalTo(@(50));
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.equalTo(cancelBtn);
        make.right.equalTo(_alertView.mas_right).mas_offset(-16);
    }];
    
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(_alertView);
        make.top.equalTo(_TitleLbl.mas_bottom);
    }];
    
    [_colonLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_pickerView);
    }];
}


- (void)setStartModel:(JGCalendarDayModel *)StartModel {
    _StartModel = StartModel;
    
    NSDate *CurDate = [NSDate date];
    
    int result = [self compareOneDay:CurDate withAnotherDay:StartModel.date];
    if (result != 0) return;
    
//    JGLog(@"%d", result);

    self.CurrentHour = CurDate.dateHour;
    self.CurrentMinute = CurDate.dateMinute;
    
    if (self.CurrentMinute > 45) {
        
        self.CurrentHour += 1;
    }
    
    
//    [_pickerView reloadAllComponents];

    //滚动到指定位置
    
    [self.pickerView selectRow:self.CurrentHour inComponent:0 animated:YES];
    [self pickerView:self.pickerView didSelectRow:self.CurrentHour inComponent:0];
    
    NSInteger MinuteRow = [self GetMinuteRowWithMinute:self.CurrentMinute];
    
//    JGLog(@"%ld",MinuteRow);
    
    
    [self.pickerView selectRow:MinuteRow inComponent:1 animated:YES];
    [self pickerView:self.pickerView didSelectRow:MinuteRow inComponent:1];
}



- (NSInteger)GetMinuteRowWithMinute:(NSInteger)Minute {
    
    if (Minute < 15) {
        return 1;
    }else if (Minute < 30) {
        return 2;
    }else if (Minute < 45) {
        return 3;
    }else if (Minute < 30) {
        return 4;
    }
    return 0;
    
}



- (void)nextBtnClick {
    if (self.TimeBackInfo) {
        NSString *TimeStr = [NSString stringWithFormat:@"%@:%@", _HourStr,_MinuteStr];
        [self CloseBtnClick];
        self.TimeBackInfo(TimeStr);
    }    
}


#pragma mark - 点击其他区域关闭
- (void)tapClick:(UITapGestureRecognizer *)tap {
    if( CGRectContainsPoint(_alertView.frame, [tap locationInView:self])) {
    }else {
        [self CloseBtnClick];
    }
}


#pragma mark - UIPickerViewDataSource Implementation
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // Returns
    switch (component)
    {
        case 0: return self.HourArrM.count;
        case 1: return self.MinuteArrM.count;
        default:break;
    }
    return 0;
}
#pragma mark UIPickerViewDelegate Implementation

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0: return self.HourArrM[row];break;
        case 1: return self.MinuteArrM[row];break;
        default:break;
    }
    return nil;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    JGAvailableTimeChooseActionSheetView *pView =(JGAvailableTimeChooseActionSheetView *)view;
    if (!pView) {
        pView = [[JGAvailableTimeChooseActionSheetView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth / 2.0, 50)];
    }
    
    NSString * Hour = @"";
    NSString * Minute = @"";
    UIColor *textColor = JGHexColor(@"#282828");
    switch (component) {
        case 0:
            {
               Hour =   self.HourArrM[row];
                pView.TitleLbl.text=Hour;
            }
            break;
        case 1:
        {
            Minute =  self.MinuteArrM[row];
            pView.TitleLbl.text=Minute;
        }
            break;
        default:
            break;
    }
    

    if (self.CurrentHour == -1 && self.CurrentMinute == -1) {
        
        textColor = JGHexColor(@"#282828");

    }else {
      
        if (self.isTimeOut) {
            
            textColor = [UIColor lightGrayColor];
        }else {
            
            textColor = JGHexColor(@"#282828");
        }
    }
    
    _colonLbl.textColor = textColor;
    
    pView.TitleLbl.textColor = textColor;
    
    return pView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
 
    if (component == 0) {
        
        _HourStr = [self.HourArrM objectAtIndex:row];
    }else {
        
        _MinuteStr = [self.MinuteArrM objectAtIndex:row];
    }
    
    
    if (self.CurrentHour == -1 && self.CurrentMinute == -1) return;
    
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld %@:%@:00",self.StartModel.year, self.StartModel.month,self.StartModel.day,_HourStr,_MinuteStr];
    
    NSDate *date = [NSDate dateFromString:dateStr];
    
    self.isTimeOut = date.isTimeout;
    
//    JGLog(@"isTimeOut: %d",self.isTimeOut);
    
    
    if (date.isTimeout) {
        
        _TitleLbl.text = @"本时间不可租";
        _TitleLbl.textColor = JGHexColor(@"#EA6F5A");
        _nextBtn.enabled = NO;
    }else {
        
        _TitleLbl.text = @"请选择时间";
        _TitleLbl.textColor = JG333Color;
        _nextBtn.enabled = YES;
    }
    
    [pickerView reloadAllComponents];
}


- (void)configurePickerView:(UIPickerView *)pickerView
{
    pickerView.showsSelectionIndicator = NO;
}



#pragma mark - 弹出
-(void)show {
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

-(void)creatShowAnimation {
    self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alertView.transform = CGAffineTransformMakeTranslation(0, -kDeviceHight + AlertHeight);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - 关闭按钮点击才回调
- (void)CloseBtnClick {
    
    self.alertView.transform = CGAffineTransformMakeTranslation(0, -kDeviceHight + AlertHeight);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


//- (void)dealloc {
//    JGLog(@"ActionSheet销毁了");
//}

//时间大小比较
- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //yyyy-MM-dd HH:mm:ss
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
    
}

@end
