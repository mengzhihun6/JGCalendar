//
//  UIBarButtonItem+JGAddition.h
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/4/24.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JGAddition)

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)rigthItemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

@end
