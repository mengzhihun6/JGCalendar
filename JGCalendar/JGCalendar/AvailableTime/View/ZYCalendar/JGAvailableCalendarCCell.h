//
//  JGAvailableCalendarCCell.h
//  EmpTraRent
//
//  Created by spring on 2019/11/27.
//  Copyright © 2019 spring. All rights reserved.
//

#import "JGBaseCollectionViewCell.h"
#import "JGCalendarDayModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JGAvailableCalendarCCell : JGBaseCollectionViewCell

@property (nonatomic, strong) JGCalendarDayModel *Model;

@end

NS_ASSUME_NONNULL_END
