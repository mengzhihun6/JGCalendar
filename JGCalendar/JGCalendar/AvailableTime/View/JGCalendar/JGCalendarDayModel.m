//
//  JGCalendarDayModel.m
//  EmpTraRent
//
//  Created by spring on 2019/11/27.
//  Copyright © 2019 spring. All rights reserved.
//

#import "JGCalendarDayModel.h"

@implementation JGCalendarDayModel

- (id)copyWithZone:(NSZone *)zone {
    
    JGCalendarDayModel *Model = [[[self class] allocWithZone:zone] init];
    
    Model.year = self.year;
    Model.month = self.month;
    Model.day = self.day;
    Model.week = self.week;
    Model.style = self.style;
    Model.bgType = self.bgType;
    Model.timeStr = self.timeStr;
    
    
    return Model;
}



+ (JGCalendarDayModel *)calendarDayWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    
    JGCalendarDayModel *calendarDay = [[JGCalendarDayModel alloc] init];//初始化自身
    calendarDay.year = year;//年
    calendarDay.month = month;//月
    calendarDay.day = day;//日
    return calendarDay;
}

//返回当前天的NSDate对象
- (NSDate *)date {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.year = self.year;
    c.month = self.month;
    c.day = self.day;
    return [[NSCalendar currentCalendar] dateFromComponents:c];
}

- (NSUInteger)week {
    return [[self date] getWeekIntValueWithDate];
}

//如 2019-01-01 18:00:00 这样的格式，传给接口
- (NSString *)toString  {
    NSDate *date = [self date];
    NSString *string = [date stringFromDate:date];
    return [NSString stringWithFormat:@"%@ %@:00",string, self.timeStr];
}


//返回星期
- (NSString *)getWeek {
    
    NSDate *date = [self date];
    
    NSString *week_str = [date compareIfTodayWithDate];
    
    return week_str;
}

//判断是不是同一天
- (BOOL)isEqualTo:(JGCalendarDayModel *)day
{
    BOOL isEqual = (self.year == day.year) && (self.month == day.month) && (self.day == day.day);
    return isEqual;
}

@end
