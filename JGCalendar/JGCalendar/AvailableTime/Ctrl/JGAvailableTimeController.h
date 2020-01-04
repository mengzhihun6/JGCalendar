//
//  JGAvailableTimeController.h
//  EmpTraRent
//
//  Created by spring on 2019/11/25.
//  Copyright © 2019 spring. All rights reserved.
//

#import "JGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JGAvailableTimeController : JGBaseViewController

@property (nonatomic, copy) ReturnBackInfo navItemClick;

//会把被占用的日期返回给你们，如果该车每天都可租，不曾被占用， items 就是 []
//"type": "2"// 1 全天不可租 2 半天不可租
@property (nonatomic, strong) NSArray *items;

//记录上次选择的数据 时间
@property (nonatomic, strong) NSArray *timeArr;

@property (nonatomic, copy) ReturnBackInfo TimeBackInfo;

@end

NS_ASSUME_NONNULL_END
