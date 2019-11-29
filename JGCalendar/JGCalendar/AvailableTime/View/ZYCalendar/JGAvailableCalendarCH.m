//
//  JGAvailableCalendarCH.m
//  EmpTraRent
//
//  Created by spring on 2019/11/27.
//  Copyright © 2019 spring. All rights reserved.
//

#import "JGAvailableCalendarCH.h"

@implementation JGAvailableCalendarCH

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _TitleLbl = [UILabel new];
        _TitleLbl.textColor = JG333Color;
        _TitleLbl.font = JGBoldFont(16);
        
        [self addSubview:_TitleLbl];
        
        [_TitleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).mas_offset(20);
        }];
        
    }
    return self;
}

@end
