//
//  NSString+Emoji.h
//  Chat Kit
//
//  Created by LeungChaos on 16/9/2.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)

/** 返回一个包含表情的属性字符串 */
- (NSMutableAttributedString *)stringToAttributedStringWithFont:(UIFont *)font emojiSize:(CGFloat)emojiSize;

/** 判断是否为空字符串 */
- (BOOL)isEmpty;

@end

@interface NSAttributedString (BoundingSize)

/** 计算一个属性字符串占用的尺寸 */
- (CGSize)boundingSizeWithMaxWidth:(CGFloat)width;

@end