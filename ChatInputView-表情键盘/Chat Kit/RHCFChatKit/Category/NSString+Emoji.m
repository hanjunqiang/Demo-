//
//  NSString+Emoji.m
//  Chat Kit
//
//  Created by LeungChaos on 16/9/2.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "NSString+Emoji.h"
#import "RFEmoji.h"

@implementation NSString (Emoji)

- (NSMutableAttributedString *)stringToAttributedStringWithFont:(UIFont *)font emojiSize:(CGFloat)emojiSize
{
    if (self == nil && [self isEmpty]) return [NSMutableAttributedString new];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    NSMutableString *imgName = nil;
    
    for (int i = 0; i < self.length; i++) {
        NSRange subRange = NSMakeRange(i, 1);
        NSString *subStr = [self substringWithRange:subRange];
        
        if ([subStr isEqualToString:@"["] && i < self.length - 1) { /* 创建imgName */
            if (imgName) {
                [attributedText appendAttributedString:[imgName attStringWithFont:font]];
            }
            imgName = [NSMutableString stringWithString:subStr];
            continue;
        }
        
        if ([subStr isEqualToString:@"]"] && imgName) {
            [imgName appendString:subStr];
            if ([RFEmoji containEmojiName:imgName]) {
                UIImage *img = [UIImage imageNamed:imgName];
                if (img) {
                    NSTextAttachment *attach = [NSTextAttachment new];
                    attach.image = img;
                    attach.bounds = CGRectMake(0, -(emojiSize * 0.3), emojiSize, emojiSize);
                    NSAttributedString *likeIcon = [NSAttributedString attributedStringWithAttachment:attach];
                    [attributedText appendAttributedString:likeIcon];
                    imgName = nil;
                    continue;
                }
            }
            [attributedText appendAttributedString:[imgName attStringWithFont:font]];
            imgName = nil;
            continue;
        }
        
        if (imgName) {
            [imgName appendString:subStr];
            if (i == self.length - 1) {
                [attributedText appendAttributedString:[imgName attStringWithFont:font]];
            }
            continue;
        } else {
            [attributedText appendAttributedString:[subStr attStringWithFont:font]];
            continue;
        }
        
    }
    return attributedText;
}

- (NSAttributedString *)attStringWithFont:(UIFont *)font
{
   return [[NSAttributedString alloc] initWithString:self
                                    attributes:@{
                                                 NSFontAttributeName : font,
                                                 NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                }];
    
    
}

- (BOOL)isEmpty
{
    if (!self) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}


@end

@implementation NSAttributedString (BoundingSize)

- (CGSize)boundingSizeWithMaxWidth:(CGFloat)width
{
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
}

@end


