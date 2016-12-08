//
//  RFEmojiItemCell.h
//  Chat Kit
//
//  Created by LeungChaos on 16/9/1.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const RFEmojiItemCellIden;

@class RFEmoji;
@interface RFEmojiItemCell : UICollectionViewCell

@property (strong, nonatomic) RFEmoji *emoji;

@end
