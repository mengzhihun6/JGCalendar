//
//  UIButton+JGLayout.m
//  FD_Rider
//
//  Created by 郭军 on 2019/3/16.
//  Copyright © 2019年 zhiyuan. All rights reserved.
//

#import "UIButton+JGLayout.h"

@implementation UIButton (JGLayout)


/**
 title     :   text in button
 titleFont :   text's font
 image     :   image in button
 gap       :   gap between button and image
 layType   :   0:title---left ,image---right
 1:title---right ,image---left
 2:title---down ,image---up
 */

-(void)layoutButtonForTitle:(NSString *)title
                  titleFont:(UIFont *)titleFont
                      image:(UIImage *)image
                 gapBetween:(CGFloat)gap
                    layType:(NSInteger)layType
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateNormal];
    self.titleLabel.font = titleFont;
    self.imageView.image = image;
    
    
    [self selectType:(NSInteger)layType withTitle:(NSString *)title withTitleFont:(UIFont *)titleFont withImage:(UIImage *)image WithGapBetween:(CGFloat)gap];
}

- (void) selectType:(NSInteger)layType withTitle:(NSString *)title withTitleFont:(UIFont *)titleFont withImage:(UIImage *)image WithGapBetween:(CGFloat)gap{
    switch (layType) {
        case 0:
        {
            //title---left ,image---right
            [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            CGFloat image_width = image.size.width;
            
            
            
            NSDictionary *attribute = @{NSFontAttributeName:titleFont};
            
            CGSize titleSize = [title boundingRectWithSize:CGSizeMake(self.frame.size.width,MAXFLOAT)
                                                   options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                                attributes:attribute
                                                   context:nil].size;
            
            CGFloat title_origin_x = (self.frame.size.width-image_width-gap-titleSize.width)/2 - image_width;
            CGFloat image_origin_x = title_origin_x + gap + titleSize.width+image_width;
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0,title_origin_x,0,0)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,image_origin_x,0,0)];
        }
            break;
        case 1:
        {
            //title---right ,image---left
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,-gap/2,0,0)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0,gap/2,0,0)];
            
        }
            break;
        case 2:
        {
            //title---down ,image---up
            NSDictionary *attribute = @{NSFontAttributeName:titleFont};
            
            CGSize titleSize = [title boundingRectWithSize:CGSizeMake(self.frame.size.width,MAXFLOAT)
                                                   options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                                attributes:attribute
                                                   context:nil].size;
            CGFloat title_origin_x = -image.size.width/2;
            CGFloat image_origin_x = titleSize.width/2;
            CGFloat image_origin_y = - (titleSize.height+gap)/2;
            CGFloat title_origin_y = (image.size.height+gap)/2;
            [self setImageEdgeInsets:UIEdgeInsetsMake(image_origin_y,image_origin_x,-image_origin_y,-image_origin_x)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(title_origin_y,title_origin_x,-title_origin_y,-title_origin_x)];
            
        }
            break;
        default:
            break;
    }
    CGRect rect = self.imageView.frame;
    rect.size.height = 16.0;
    rect.size.width = 13.5;
    self.imageView.frame = rect;
}




- (void)layoutWithStatus:(JGLayoutStatus)status andMargin:(CGFloat)margin{
    CGFloat imgWidth = self.imageView.bounds.size.width;
    CGFloat imgHeight = self.imageView.bounds.size.height;
    CGFloat labWidth = self.titleLabel.bounds.size.width;
    CGFloat labHeight = self.titleLabel.bounds.size.height;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (labWidth < frameSize.width) {
        labWidth = frameSize.width;
    }
    CGFloat kMargin = margin/2.0;
    switch (status) {
        case JGLayoutStatusNormal://图左字右
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -kMargin, 0, kMargin)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, kMargin, 0, -kMargin)];
            break;
        case JGLayoutStatusImageRight://图右字左
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, labWidth + kMargin, 0, -labWidth - kMargin)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgWidth - kMargin, 0, imgWidth + kMargin)];
            break;
        case JGLayoutStatusImageTop://图上字下
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,0, labHeight + margin, -labWidth)];
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(imgHeight + margin, -imgWidth, 0, 0)];
            break;
        case JGLayoutStatusImageBottom://图下字上
            [self setImageEdgeInsets:UIEdgeInsetsMake(labHeight + margin,0, 0, -labWidth)];
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgWidth, imgHeight + margin, 0)];
            
            break;
        default:
            break;
    }
}


@end
