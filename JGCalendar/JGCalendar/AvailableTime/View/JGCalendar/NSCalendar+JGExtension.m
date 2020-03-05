//
//  NSCalendar+JGExtension.m
//  EFFICIENCYLOG
//
//  Created by stkcctv on 16/12/20.
//  Copyright © 2016年 JG. All rights reserved.
//

#import "NSCalendar+JGExtension.h"

@implementation NSCalendar (JGExtension)

+ (instancetype)calendar
{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    }
}


@end
