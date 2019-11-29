//
//  JGAvailableTimeChooseActionSheet.h
//  EmpTraRent
//
//  Created by spring on 2019/11/27.
//  Copyright © 2019 spring. All rights reserved.
//

#import "JGBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JGAvailableTimeChooseActionSheet : JGBaseView
//选取的时间返回
@property (nonatomic, copy) ReturnBackInfo TimeBackInfo;

-(void)show;

@end

NS_ASSUME_NONNULL_END
