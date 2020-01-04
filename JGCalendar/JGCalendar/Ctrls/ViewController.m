//
//  ViewController.m
//  JGCalendar
//
//  Created by spring on 2019/11/29.
//  Copyright © 2019 spring. All rights reserved.
//

#import "ViewController.h"
#import "JGAvailableTimeController.h"
#import "JGCalendarDayModel.h"

#import "JGCarCalendarModel.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *DateLbl;


@property (nonatomic, strong) NSMutableArray *DataArrM;

//记录上次选择的数据 时间
@property (nonatomic, strong) NSArray *timeArr;

@end

@implementation ViewController


//模拟不可租车数据
- (NSMutableArray *)DataArrM {
    if (!_DataArrM) {
        _DataArrM = [NSMutableArray array];

        //获取当前日期
        NSDate *date = [NSDate date];
        
        //对象对应的月份的总天数
        NSInteger totalDaysInMonth = date.totalDaysInMonth;
        
        for (NSInteger i = date.dateDay; i < totalDaysInMonth; i++) {
            
            JGCarCalendarItemsModel *Model = [JGCarCalendarItemsModel new];
            
            Model.date = [NSString stringWithFormat:@"%ld-%02ld-%02ld",date.dateYear, date.dateMonth,i+1];
            // 1 全天不可租 2 半天不可租
            Model.type = arc4random() % 3;
            
            [_DataArrM addObject:Model];
        }
    }
    return _DataArrM;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)CalenderClick:(id)sender {
    
    JGAvailableTimeController *VC = [JGAvailableTimeController new];
    
    VC.timeArr = self.timeArr;
    WEAKSELF;
    VC.TimeBackInfo = ^(NSArray *data) {
        
        if (data.count) {
            
            weakSelf.timeArr = data;
            
            JGCalendarDayModel *LModel = [data firstObject];
            JGCalendarDayModel *RModel = [data lastObject];
            
            NSString *start_time = LModel.toString;
            NSString *end_time = RModel.toString;
            
            weakSelf.DateLbl.text = [NSString stringWithFormat:@"取车时间：%@\n还车时间:%@",start_time, end_time];
            
        }else {
           
            weakSelf.timeArr = @[];
            weakSelf.DateLbl.text = @"点击日历选择";
            
        }
        
       
    };
    //模拟不可租 日期 数据
    VC.items = self.DataArrM;
    
    [self.navigationController pushViewController:VC animated:YES];
}

@end
