//
//  JGAvailableTimeBottom.h
//  EmpTraRent
//
//  Created by spring on 2019/11/27.
//  Copyright © 2019 spring. All rights reserved.
//

#import "JGBaseView.h"
#import "JGCalendarDayModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JGAvailableTimeBottom : JGBaseView

//选中的 左侧 日期模型
@property (nonatomic, strong) JGCalendarDayModel *LeftModel;
//选中的 右侧 日期模型
@property (nonatomic, strong) JGCalendarDayModel *RightModel;

@property (nonatomic, copy) ReturnBackInfo TimeBackInfo;

@end

NS_ASSUME_NONNULL_END
