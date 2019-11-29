//
//  UIBarButtonItem+JGAddition.m
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/4/24.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "UIBarButtonItem+JGAddition.h"

@implementation UIBarButtonItem (JGAddition)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc] init];
//    btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [btn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    if (highIcon) {
        [btn setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    }
//    btn.frame = (CGRect){CGPointZero,btn.currentBackgroundImage.size};
    btn.frame = CGRectMake(0, 0, 50, 44);

    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)rigthItemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc] init];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    if (highIcon) {
        [btn setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    }
    btn.frame = CGRectMake(0, 0, 50, 44);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}


+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
//    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn setTitleColor:[UIColor colorWithHexCode:@"#333333"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexCode:@"#666666"] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    btn.frame = CGRectMake(0, 0, title.length * 18, 30);
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}



@end
