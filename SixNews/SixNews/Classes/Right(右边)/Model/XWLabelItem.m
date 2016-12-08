//
//  XWLabelItem.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWLabelItem.h"

@implementation XWLabelItem

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title cacheSize:(NSString *)cacheSize
{
    XWLabelItem *item = [[XWLabelItem alloc]init];
    item.icon = icon;
    item.title = title;
    item.cacheSize = cacheSize;
    
    return item;
}

@end
