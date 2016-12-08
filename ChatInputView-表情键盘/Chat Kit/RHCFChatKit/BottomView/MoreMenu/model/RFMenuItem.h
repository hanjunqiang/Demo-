//
//  RFMenuItem.h
//  Chat Kit
//
//  Created by LeungChaos on 16/9/1.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFMenuItem : NSObject

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *icon;

+ (NSArray<RFMenuItem *> *)items;

@end
