//
//  XWBosItem.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWBosItem.h"

@implementation XWBosItem

+(instancetype)itemWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    XWBosItem *item = [[XWBosItem alloc]init];
    item.title = title;
    item.image = image;
    item.selectedImage = selectedImage;
    
    return item;
}

@end
