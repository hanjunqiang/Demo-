//
//  RFMenuItemCell.h
//  Chat Kit
//
//  Created by LeungChaos on 16/9/1.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const RFMenuItemCellIden;

@class RFMenuItem;

@interface RFMenuItemCell : UICollectionViewCell

@property (strong, nonatomic) RFMenuItem *item;

@end
