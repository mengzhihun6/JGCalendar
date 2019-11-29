//
//  JGAvailableTimeController.m
//  EmpTraRent
//
//  Created by spring on 2019/11/25.
//  Copyright © 2019 spring. All rights reserved.
//

#import "JGAvailableTimeController.h"
#import "JGAvailableTimeTop.h" //顶部时间段
#import "JGAvailableTimeBottom.h"//底部
#import "JGAvailableCalendar.h"

#import "JGAvailableDateTimeModel.h"



@interface JGAvailableTimeController ()

@property (nonatomic, strong) JGAvailableTimeTop *Top;

@property (nonatomic, strong) JGAvailableCalendar *Calendar;

@property (nonatomic, strong) JGAvailableTimeBottom *Bottom;

@property (nonatomic, strong) NSMutableArray *DataArrM;

@end

@implementation JGAvailableTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"清空" target:self action:@selector(rightBarButtonItemClick)];
}


- (void)rightBarButtonItemClick {
    
    [self.Calendar ClearAllSelectedDate];
}

- (NSMutableArray *)DataArrM {
    if (!_DataArrM) {
        _DataArrM = [NSMutableArray array];
        
        for (int i = 8; i < 31; i ++) {
            
            JGAvailableDateTimeModel *Mo = [JGAvailableDateTimeModel new];
            Mo.type = arc4random() % 2 + 1;
            Mo.date = [NSString stringWithFormat:@"2019-12-%02d",i];
            
            [_DataArrM addObject:Mo];
        }
    }
    return _DataArrM;
}




- (void)configUI {
    
    WEAKSELF;
    _Top = [JGAvailableTimeTop new];

    _Top.LeftDateBtnClick = ^(UIButton *btn) {
        
        weakSelf.Calendar.isLeftCanSel = btn.selected;
    };
    
    _Top.RightDateBtnClick = ^(UIButton *btn) {
        
        weakSelf.Calendar.isRightCanSel = btn.selected;
    };
    
    
    _Calendar = [JGAvailableCalendar new];
    _Calendar.items = self.DataArrM;
    
    _Calendar.LeftDateInfo = ^(JGCalendarDayModel *LModel) {
        
        weakSelf.Top.LeftModel = LModel;
        weakSelf.Bottom.LeftModel = LModel;
    };
    
    _Calendar.RightDateInfo = ^(JGCalendarDayModel *RModel) {
        
        weakSelf.Top.RightModel = RModel;
        weakSelf.Bottom.RightModel = RModel;
    };
    
    
    _Bottom = [JGAvailableTimeBottom new];

    
    [self.view addSubview:_Top];
    [self.view addSubview:_Calendar];
    [self.view addSubview:_Bottom];

    
    [_Top mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).mas_offset(SJHeight);
        make.height.equalTo(@(144));
    }];
    
    [_Calendar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_Top);
        make.top.equalTo(_Top.mas_bottom);
        make.bottom.equalTo(_Bottom.mas_top);
    }];
    
    [_Bottom mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_Top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@(IphoneXTabbarH + 30));
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
