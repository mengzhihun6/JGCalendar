//
//  JGCalendarDayModel.h
//  EmpTraRent
//
//  Created by spring on 2019/11/27.
//  Copyright © 2019 spring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+JGCalendar.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZYCalendarDayCellType) {
    CellDayTypeEmpty = 0,   //不显示
    CellDayTypePast,    //过去的日期
    CellDayTypeAllDay,    //全天不可租
    CellDayTypePartDay,    //半天不可租
    CellDayTypeAllCanDay    //全天可租
};


typedef NS_ENUM(NSInteger, ZYCalendarDayCellBgType) {
    CellDayTypeSelHide = 0, //默认隐藏
    CellDayTypeSelRound,  //被选中日期 全部切圆
    CellDayTypeSelLeft,    //被选中日期 背景 左侧切圆角
    CellDayTypeSelCenter,  //被选中日期 背景 不切圆角
    CellDayTypeSelRight    //被选中日期 背景 右侧侧切圆角
};


@interface JGCalendarDayModel : NSObject

@property (assign, nonatomic) ZYCalendarDayCellType style;//显示的样式
@property (assign, nonatomic) ZYCalendarDayCellBgType bgType;//背景样式

@property (nonatomic, assign) NSUInteger day;//天
@property (nonatomic, assign) NSUInteger month;//月
@property (nonatomic, assign) NSUInteger year;//年
@property (nonatomic, assign) NSUInteger week;//周
//选择的时间 如 06:45
@property (nonatomic, copy) NSString *timeStr;

+ (JGCalendarDayModel *)calendarDayWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day;

- (NSDate *)date;//返回当前天的NSDate对象
//如 2019-01-01 18:00:00 这样的格式，传给接口
- (NSString *)toString;
- (NSString *)getWeek; //返回星期

@end

NS_ASSUME_NONNULL_END
