//
//  JGBaseCollectionViewCell.m
//  GoldSilicon
//
//  Created by spring on 2019/11/4.
//  Copyright © 2019 spring. All rights reserved.
//

#import "JGBaseCollectionViewCell.h"

@implementation JGBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
        
    }
    return self;
}


- (void)configUI {}

@end
