//
//  JGAvailableTimeBottom.m
//  EmpTraRent
//
//  Created by spring on 2019/11/27.
//  Copyright © 2019 spring. All rights reserved.
//

#import "JGAvailableTimeBottom.h"

@interface JGAvailableTimeBottom ()

@property (nonatomic, strong) UIButton *AllDateBtn;
@property (nonatomic, strong) UIButton *PartDateBtn;
@property (nonatomic, strong) UIButton *NoDateBtn;

@property (nonatomic, strong) UILabel *TotalLbl;

@property (nonatomic, strong) UIButton *SureBtn;


@end


@implementation JGAvailableTimeBottom

- (void)configUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *TopLine = [UIView new];
    TopLine.backgroundColor = JGHexColor(@"#E5E5EA");
    
    _AllDateBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 30)];
    _AllDateBtn.titleLabel.font = JGFont(11);
    [_AllDateBtn setTitleColor:JG333Color forState:UIControlStateNormal];
    [_AllDateBtn setTitle:@"全天可租" forState:UIControlStateNormal];
    [_AllDateBtn setImage:JGImage(@"calendar_all_time_small") forState:UIControlStateNormal];
    [_AllDateBtn layoutWithStatus:0 andMargin:4];
    
    
    _PartDateBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 88, 30)];
    _PartDateBtn.titleLabel.font = JGFont(11);
    [_PartDateBtn setTitleColor:JG333Color forState:UIControlStateNormal];
    [_PartDateBtn setTitle:@"部分时段可租" forState:UIControlStateNormal];
    [_PartDateBtn setImage:JGImage(@"calendar_part_time_small") forState:UIControlStateNormal];
    [_PartDateBtn layoutWithStatus:0 andMargin:4];
    
    _NoDateBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 30)];
    _NoDateBtn.titleLabel.font = JGFont(11);
    [_NoDateBtn setTitleColor:JG333Color forState:UIControlStateNormal];
    [_NoDateBtn setTitle:@"不可租" forState:UIControlStateNormal];
    [_NoDateBtn setImage:JGImage(@"calendar_del_line_small") forState:UIControlStateNormal];
    [_NoDateBtn layoutWithStatus:0 andMargin:4];
    
    
    
    UILabel *DescLbl = [UILabel new];
    DescLbl.textColor = JG333Color;
    DescLbl.font = JGBoldFont(14);
    DescLbl.text = @"总计";
    
    _TotalLbl = [UILabel new];
    _TotalLbl.textColor = JG333Color;
    _TotalLbl.font = JGBoldFont(18);
    _TotalLbl.text = @"0天";
    
    
    _SureBtn = [UIButton new];
    _SureBtn.titleLabel.font = JGFont(16);
    _SureBtn.backgroundColor = JGHexColor(@"#282828");
    _SureBtn.layer.cornerRadius = 5.0;
    [_SureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_SureBtn addTarget:self action:@selector(SureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:TopLine];
    [self addSubview:_AllDateBtn];
    [self addSubview:_PartDateBtn];
    [self addSubview:_NoDateBtn];
    [self addSubview:DescLbl];
    [self addSubview:_TotalLbl];
    [self addSubview:_SureBtn];
    
    
    [TopLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
    
    [_AllDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_NoDateBtn.mas_top);
        make.right.equalTo(_PartDateBtn.mas_left).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(65, 30));
    }];
    
    [_PartDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_NoDateBtn.mas_top);
        make.right.equalTo(_NoDateBtn.mas_left).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(88, 30));
    }];
    
    [_NoDateBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopLine.mas_bottom);
        make.right.equalTo(self.mas_right).mas_offset(-16);
        make.size.mas_equalTo(CGSizeMake(55, 30));
    }];
    
    [DescLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_SureBtn.mas_centerY);
        make.left.equalTo(self.mas_left).mas_offset(16);
    }];
    
    [_TotalLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_SureBtn.mas_centerY);
        make.left.equalTo(DescLbl.mas_right);
    }];
    
    [_SureBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).mas_offset(-16);
        make.top.equalTo(_NoDateBtn.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
}


- (void)setLeftModel:(JGCalendarDayModel *)LeftModel {
    _LeftModel = LeftModel;
    
    [self CalculateDate];
}

- (void)setRightModel:(JGCalendarDayModel *)RightModel {
    _RightModel = RightModel;
    
    [self CalculateDate];
}


- (void)CalculateDate {
    
    _TotalLbl.hidden = !(self.LeftModel.toString.length && self.RightModel.toString.length);
    
    if (self.LeftModel.toString.length && self.RightModel.toString.length) {
        
        _TotalLbl.text = [NSDate dateTimeDifferenceWithStartTime:self.LeftModel.toString endTime:self.RightModel.toString];
    }
}


- (void)SureBtnClick {
    
    JGLog(@"%@ - %@", self.LeftModel.toString, self.RightModel.toString);
    
}

@end
