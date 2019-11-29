//
//  JGAvailableTimeTop.m
//  EmpTraRent
//
//  Created by spring on 2019/11/27.
//  Copyright © 2019 spring. All rights reserved.
//

#import "JGAvailableTimeTop.h"


@interface JGAvailableTimeTopWeak : JGBaseView

@property (nonatomic, strong) NSArray *WeaksArrM;

@end

@implementation JGAvailableTimeTopWeak

- (NSArray *)WeaksArrM {
    if (!_WeaksArrM) {
        _WeaksArrM = @[ @"一", @"二", @"三", @"四", @"五", @"六",@"日"];
    }
    return _WeaksArrM;
}

- (void)configUI {
    
    CGFloat W = (kDeviceWidth - 28.0) / self.WeaksArrM.count;
    for (NSUInteger i = 0; i < self.WeaksArrM.count; i++) {
        UILabel *WeakLbl = [[UILabel alloc] initWithFrame:CGRectMake(14 + W * i, 0, W, 42)];
        WeakLbl.textColor = JG999Color;
        WeakLbl.font = JGFont(12);
        WeakLbl.textAlignment = NSTextAlignmentCenter;
        WeakLbl.text = [self.WeaksArrM objectAtIndex:i];
        [self addSubview:WeakLbl];
    }
}

@end



@interface JGAvailableTimeTop ()

@property (nonatomic, strong) UIView *TopView;

@property (nonatomic, strong) UILabel *LDateLbl;
@property (nonatomic, strong) UILabel *LTimeLbl;
@property (nonatomic, strong) UIButton *LDateBtn;

@property (nonatomic, strong) UILabel *CTimeLbl;
@property (nonatomic, strong) UIImageView *CIcon;

@property (nonatomic, strong) UILabel *RDateLbl;
@property (nonatomic, strong) UILabel *RTimeLbl;
@property (nonatomic, strong) UIButton *RDateBtn;

@property (nonatomic, strong) JGAvailableTimeTopWeak *WeakView;

@property (nonatomic, strong) UIButton *IndexBtn;

@end


@implementation JGAvailableTimeTop

- (void)configUI {
    
    _TopView = [UIView new];
    
    _LDateLbl = [UILabel new];
    _LDateLbl.textColor = JG333Color;
    _LDateLbl.font = JGBoldFont(16);
    _LDateLbl.text = @"取车时间";
    
    _LTimeLbl = [UILabel new];
    _LTimeLbl.textColor = JG333Color;
    _LTimeLbl.font = JGFont(12);
    _LTimeLbl.text = @"请设置";
    
    _LDateBtn = [UIButton new];
//    _LDateBtn.selected = YES; //默认选中
    [_LDateBtn addTarget:self action:@selector(LDateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _CTimeLbl = [UILabel new];
    _CTimeLbl.textColor = JGHexColor(@"#282828");
    _CTimeLbl.font = JGFont(12);
//    _CTimeLbl.text = @"7天";
    
    _CIcon = [UIImageView new];
    _CIcon.image = JGImage(@"choose_time_arrow");
    
    
    _RDateBtn = [UIButton new];
    [_RDateBtn addTarget:self action:@selector(RDateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _RDateLbl = [UILabel new];
    _RDateLbl.textColor = JG333Color;
    _RDateLbl.font = JGBoldFont(16);
    _RDateLbl.text = @"还车时间";
    
    _RTimeLbl = [UILabel new];
    _RTimeLbl.textColor = JG333Color;
    _RTimeLbl.font = JGFont(12);
    _RTimeLbl.text = @"请设置";
    
    _WeakView = [JGAvailableTimeTopWeak new];
    
    UIView *Line = [UIView new];
    Line.backgroundColor = JGHexColor(@"#E5E5EA");
    
    [self addSubview:_TopView];
    [_TopView addSubview:_LDateLbl];
    [_TopView addSubview:_LTimeLbl];
    [_TopView addSubview:_LDateBtn];

    [_TopView addSubview:_CTimeLbl];
    [_TopView addSubview:_CIcon];
    
    [_TopView addSubview:_RDateLbl];
    [_TopView addSubview:_RTimeLbl];
    [_TopView addSubview:_RDateBtn];
    
    [self addSubview:_WeakView];
    [self addSubview:Line];
    
    [_TopView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@(102));
    }];
    
    [_LDateLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_TopView.mas_left).mas_offset(20);
        make.bottom.equalTo(_TopView.mas_centerY).mas_offset(-2.5);
    }];
 
    [_LTimeLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_LDateLbl.mas_left);
        make.top.equalTo(_TopView.mas_centerY).mas_offset(2.5);
    }];
    
    [_LDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.bottom.equalTo(_WeakView.mas_top);
        make.right.equalTo(_CIcon.mas_left).mas_offset(-20);
    }];
    
    [_CTimeLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_TopView.mas_centerX);
        make.bottom.equalTo(_CIcon.mas_top);
    }];
    
    [_CIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_TopView);
    }];
    
    [_RDateLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_LDateLbl.mas_centerY);
        make.right.equalTo(_TopView.mas_right).mas_offset(-20);
    }];
    
    [_RTimeLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_LTimeLbl.mas_centerY);
        make.right.equalTo(_RDateLbl.mas_right);
    }];
    
    [_RDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.bottom.equalTo(_WeakView.mas_top);
        make.width.equalTo(_LDateBtn.mas_width);
    }];
    
    [_WeakView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(Line.mas_top);
        make.top.equalTo(_TopView.mas_bottom);
    }];
    
    [Line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
    
    //默认 选中 左侧
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self LDateBtnClick:_LDateBtn];
    });
}

#pragma mark - 左侧时间按钮 -
- (void)LDateBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    if (self.IndexBtn == btn) return;
    self.IndexBtn = btn;
    
    
    //先更新右侧为非选中状态
    if (self.RightDateBtnClick) {

        _RDateBtn.selected = NO;
        _RDateLbl.textColor = JG333Color;
        _RTimeLbl.textColor = JG333Color;
        self.RightDateBtnClick(_RDateBtn);
    }
    
    //再更新左侧状态
    if (self.LeftDateBtnClick) {
        
        _LDateLbl.textColor = btn.selected ? JGHexColor(@"#7588FF") : JG333Color;
        _LTimeLbl.textColor = btn.selected ? JGHexColor(@"#7588FF") : JG333Color;
        self.LeftDateBtnClick(btn);
    }
}

#pragma mark - 右侧时间按钮 -
- (void)RDateBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;

    if (self.LeftModel == nil) {
        [JGToast showWithText:@"请先选开始租车时间"];
        return;
    }
    
    if (self.IndexBtn == btn) return;
    self.IndexBtn = btn;
    
    //先更新左侧为非选中状态
    if (self.LeftDateBtnClick) {
        
        _LDateBtn.selected = NO;
        _LDateLbl.textColor = JG333Color;
        _LTimeLbl.textColor = JG333Color;
        self.LeftDateBtnClick(_LDateBtn);
    }

    //再更新右侧状态
    if (self.RightDateBtnClick) {
        
        _RDateLbl.textColor = btn.selected ? JGHexColor(@"#7588FF") : JG333Color;
        _RTimeLbl.textColor = btn.selected ? JGHexColor(@"#7588FF") : JG333Color;
        self.RightDateBtnClick(btn);
    }
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
    
    if (self.LeftModel.toString.length) {
        
        _LDateLbl.text = [NSString stringWithFormat:@"%ld月%ld日 %@",self.LeftModel.month, self.LeftModel.day, self.LeftModel.getWeek];
        _LTimeLbl.text = self.LeftModel.timeStr;
    }else {
        
        _LDateLbl.text = @"取车时间";
        _LTimeLbl.text = @"请设置";
    }
    
    if (self.RightModel.toString.length) {
        
        _RDateLbl.text = [NSString stringWithFormat:@"%ld月%ld日 %@",self.RightModel.month, self.RightModel.day, self.RightModel.getWeek];
        _RTimeLbl.text = self.RightModel.timeStr;
    }else {
        
        _RDateLbl.text = @"还车时间";
        _RTimeLbl.text = @"请设置";
    }
    
    _CTimeLbl.hidden = !(self.LeftModel.toString.length && self.RightModel.toString.length);
    
    if (self.LeftModel.toString.length && self.RightModel.toString.length) {
        
        _CTimeLbl.text = [NSDate dateTimeDifferenceWithStartTime:self.LeftModel.toString endTime:self.RightModel.toString];
    }
    
    //如果清空 则复原默认 选项
    if (self.LeftModel == nil && self.RightModel == nil) {
        [self LDateBtnClick:_LDateBtn];
    }
    
    //如果左侧有值 则选中右侧
    if (self.LeftModel != nil && self.RightModel == nil) {
        [self RDateBtnClick:_RDateBtn];
    }
}



@end
