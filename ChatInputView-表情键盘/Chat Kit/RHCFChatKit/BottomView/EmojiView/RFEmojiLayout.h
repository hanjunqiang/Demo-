//
//  RFEmojiLayout.h
//  Chat Kit
//
//  Created by LeungChaos on 16/9/1.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFEmojiLayout : UICollectionViewFlowLayout

@property (assign, nonatomic) NSInteger columnCount; /** ip4，5 == 7 ,, ip6，6p == 8 */

@property (assign, nonatomic) NSInteger rowCount; /** 默认 3 */

@end

