//
//  RFMenuItem.m
//  Chat Kit
//
//  Created by LeungChaos on 16/9/1.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "RFMenuItem.h"

static NSArray *_items = nil;

@implementation RFMenuItem

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (NSArray<RFMenuItem *> *)items
{
    if (_items == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"menuItem" ofType:@"plist"];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray array];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrM addObject:[[self alloc] initWithDic:obj]];
        }];
        _items = [NSArray arrayWithArray:arrM];
    }
    return _items;
}

@end
