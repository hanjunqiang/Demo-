//
//  RFEmoji.h
//  Chat Kit
//
//  Created by LeungChaos on 16/8/31.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFEmoji : NSObject

@property (copy, nonatomic) NSString * face_id;
@property (copy, nonatomic) NSString * face_image_name;
@property (copy, nonatomic) NSString * face_name;
@property (copy, nonatomic) NSNumber * face_rank;

+ (NSArray<RFEmoji *> *)emojis;

+ (RFEmoji *)deleteItem; /** 创建删除按钮的模型 */


+ (BOOL)containEmojiName:(NSString *)name;

@end
