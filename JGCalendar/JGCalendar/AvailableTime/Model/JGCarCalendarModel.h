//
//  JGCarCalendarModel.h
//  EmpTraRent
//
//  Created by indulgeIn on 2019/12/02.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface JGCarCalendarItemsModel : NSObject
//不可租的日期
@property (nonatomic, copy) NSString *date;
// 1 全天不可租 2 半天不可租
@property (nonatomic, assign) NSInteger type;

@end


@interface JGCarCalendarModel : NSObject

@property (nonatomic, strong) NSArray<JGCarCalendarItemsModel *> *items;

@end


NS_ASSUME_NONNULL_END
