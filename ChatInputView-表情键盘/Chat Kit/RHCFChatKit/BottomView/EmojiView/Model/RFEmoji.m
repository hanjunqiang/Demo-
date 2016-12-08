//
//  RFEmoji.m
//  Chat Kit
//
//  Created by LeungChaos on 16/8/31.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "RFEmoji.h"

static NSArray * _emojis = nil;

static id _deleteItem  = nil;

@implementation RFEmoji

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (NSArray<RFEmoji *> *)emojis
{
    if (_emojis == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"face" ofType:@"plist"];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray array];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            RFEmoji *emoji = [[self alloc] initWithDic:obj];
            [arrM addObject:emoji];
        }];
        _emojis = [NSArray arrayWithArray:arrM];
    }
    return _emojis;
}

+ (RFEmoji *)deleteItem
{
    if (_deleteItem == nil) {
        RFEmoji *item = [[self alloc] init];
        item.face_image_name = @"[删除]";
        item.face_name = @"[删除]";
        item.face_id = @"999";
        item.face_rank = @0;
        _deleteItem = item;
    }
    return _deleteItem;
}

+ (BOOL)containEmojiName:(NSString *)name
{
    __block BOOL isContain = NO;
    [[self emojis] enumerateObjectsUsingBlock:^(RFEmoji * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.face_name isEqualToString:name]) {
            isContain = YES;
            *stop = YES;
        }
    }];
    return isContain;
}

@end
