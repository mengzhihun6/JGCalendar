//
//  JGAvailableDateTimeModel.h
//  EmpTraRent
//
//  Created by spring on 2019/11/27.
//  Copyright © 2019 spring. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JGAvailableDateTimeModel : NSObject

@property (nonatomic, copy) NSString *date;
// 1 全天不可租 2 半天不可租
@property (nonatomic, assign) NSInteger type;


@end

NS_ASSUME_NONNULL_END
