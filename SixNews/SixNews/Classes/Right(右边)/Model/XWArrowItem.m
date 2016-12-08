//
//  XWArrowItem.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWArrowItem.h"

@implementation XWArrowItem


+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title vcClass:(Class)vcClass dismissType:(NSString *)dismissType
{
    XWArrowItem *arrow = [[XWArrowItem alloc]init];
    arrow.icon = icon;
    arrow.title = title;
    arrow.vcClass = vcClass;
    arrow.dismissType = dismissType;
    return arrow;
}

@end
