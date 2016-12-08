//
//  XWCellItem.h
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MyBlock)();//定义一个block

@interface XWCellItem : NSObject

@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *detailTitle;
//定义一个block的成员变量
@property(nonatomic,copy)MyBlock option;

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;

@end
