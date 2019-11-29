//
//  UIColor+JGHexColor.h
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/3/14.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JGHexColor)

/**
 *  创建一个UIColor实例 使用16进制码
 *
 *  @param hexCode 16进制码
 *
 *  @return UIColor instance
 */
+ (UIColor *)colorWithHexCode:(NSString *)hexCode;

+ (UIColor *)colorWithHexCode:(NSString *)hexCode alpha:(CGFloat)alpha;


//[UIColor jg_colorHex:0x333333]
+ (instancetype)jg_colorHex:(uint32_t)hex;

+ (instancetype)jg_colorHex:(uint32_t)hex alpha:(CGFloat)alpha;

/**2019-2-26随机色*/
+ (instancetype)jg_randomColor;



@end
