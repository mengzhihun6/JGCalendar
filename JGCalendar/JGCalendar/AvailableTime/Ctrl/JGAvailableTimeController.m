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

@interface JGAvailableTimeController ()

@property (nonatomic, strong) JGAvailableTimeTop *Top;

@property (nonatomic, strong) JGAvailableCalendar *Calendar;

@property (nonatomic, strong) JGAvailableTimeBottom *Bottom;

@end

@implementation JGAvailableTimeController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"清空" target:self action:@selector(rightBarButtonItemClick)];

//    WEAKSELF;
//    self.popBlock = ^(UIBarButtonItem *backItem) {
//
//        if (weakSelf.navItemClick) {
//            weakSelf.navItemClick(@"监听返回");
//            [weakSelf.navigationController popViewControllerAnimated:NO];
//        }else {
//            [weakSelf.navigationController popViewControllerAnimated:NO];
//        }
//
//    };

}


- (void)rightBarButtonItemClick {
    
    [self.Calendar ClearAllSelectedDate];
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
    _Calendar.items = self.items;
    _Calendar.timeArr = self.timeArr;
    _Calendar.LeftDateInfo = ^(JGCalendarDayModel *LModel) {
        
        weakSelf.Top.LeftModel = LModel;
        weakSelf.Bottom.LeftModel = LModel;
    };
    
    _Calendar.RightDateInfo = ^(JGCalendarDayModel *RModel) {
        
        weakSelf.Top.RightModel = RModel;
        weakSelf.Bottom.RightModel = RModel;
    };
    
    
    _Bottom = [JGAvailableTimeBottom new];
    _Bottom.TimeBackInfo = ^(id data) {
        if (weakSelf.TimeBackInfo) {
            weakSelf.TimeBackInfo(data);
        }
        
        [weakSelf.navigationController popViewControllerAnimated:NO];
    };
    
    
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
