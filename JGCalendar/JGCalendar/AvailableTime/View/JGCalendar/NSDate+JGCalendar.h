//
//  NSDate+JGCalendar.h
//  EmpTraRent
//
//  Created by spring on 2019/11/27.
//  Copyright © 2019 spring. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (JGCalendar)

/**
 *  获得当前 NSDate 对象对应的分钟
 */
- (NSInteger)dateMinute;
/**
 *  获得当前 NSDate 对象对应的小时
 */
- (NSInteger)dateHour;
/**
 *  获得当前 NSDate 对象对应的日子
 */
- (NSInteger)dateDay;

/**
 *  获得当前 NSDate 对象对应的月份
 */
- (NSInteger)dateMonth;

/**
 *  获得当前 NSDate 对象对应的年份
 */
- (NSInteger)dateYear;

/**
 *  获得当前 NSDate 对象的上个月的某一天（此处定为15号）的 NSDate 对象
 */
- (NSDate *)previousMonthDate;

/**
 *  获得当前 NSDate 对象的下个月的某一天（此处定为15号）的 NSDate 对象
 */
- (NSDate *)nextMonthDate;

/**
 *  获得当前 NSDate 对象对应月份根据所传入的day所属日期
 */
- (NSDate *)otherDayInMonth:(NSInteger)number;

/**
 *  获得当前 NSDate 对象对应的月份的总天数
 */
- (NSInteger)totalDaysInMonth;

/**
 *  获得当前 NSDate 对象对应月份当月第一天的所属星期
 */
- (NSInteger)firstWeekDayInMonth;

/**
 *  获得当前 NSDate 对象对应农历日期
 */
- (NSString *)lunarText;

/**
 *  计算这个月有多少天
 */
- (NSUInteger)numberOfDaysInCurrentMonth;

/**
 *  获取当前日期之后的几个月
 */
- (NSDate *)dayInTheFollowingMonth:(int)month;

//周日是“1”，周一是“2”...
-(int)getWeekIntValueWithDate;

- (NSDateComponents *)JGComponents;

- (NSString *)stringFromDate:(NSDate *)date;//NSDate转NSString

+ (NSDate *)dateFromString:(NSString *)timeStr;//NSString转NSDate

//判断日期是今天,明天,后天,周几
-(NSString *)compareIfTodayWithDate;

//判断一个日期是否是今天之前的时间
- (BOOL)isItPassday;

//时间大小比较
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

//两个时间相差多少天多少小时多少分
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

/**
 *  是否超时
 */
- (BOOL)isTimeout;

@end

NS_ASSUME_NONNULL_END
