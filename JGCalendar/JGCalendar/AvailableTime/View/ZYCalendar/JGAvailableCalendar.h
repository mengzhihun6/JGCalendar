//
//  JGAvailableCalendar.h
//  EmpTraRent
//
//  Created by spring on 2019/11/27.
//  Copyright © 2019 spring. All rights reserved.
//

#import "JGBaseView.h"
#import "JGAvailableDateTimeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JGAvailableCalendar : JGBaseView
//左侧是否可选时间
@property (nonatomic, assign) BOOL isLeftCanSel;
//右侧是否可选时间
@property (nonatomic, assign) BOOL isRightCanSel;

//会把被占用的日期返回给你们，如果该车每天都可租，不曾被占用， items 就是 []
//"type": "2"// 1 全天不可租 2 半天不可租
@property (nonatomic, strong) NSArray *items;

//左侧日期
@property (nonatomic, copy) ReturnBackInfo LeftDateInfo;
//右侧日期
@property (nonatomic, copy) ReturnBackInfo RightDateInfo;

//清除所有选中的日期
- (void)ClearAllSelectedDate;


@end

NS_ASSUME_NONNULL_END
