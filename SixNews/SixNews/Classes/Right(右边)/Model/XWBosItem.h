//
//  XWBosItem.h
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWCellItem.h"

@interface XWBosItem : XWCellItem

@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *selectedImage;

+(instancetype)itemWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage;

@end
