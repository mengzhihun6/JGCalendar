//
//  JGAvailableTimeChooseActionSheet.h
//  EmpTraRent
//
//  Created by spring on 2019/11/27.
//  Copyright © 2019 spring. All rights reserved.
//

#import "JGBaseView.h"
#import "JGCalendarDayModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JGAvailableTimeChooseActionSheet : JGBaseView
//选取的时间返回
@property (nonatomic, copy) ReturnBackInfo TimeBackInfo;

//选中的 左侧 日期模型  开始日期
@property (nonatomic, strong) JGCalendarDayModel *StartModel;

-(void)show;

@end

NS_ASSUME_NONNULL_END
