//
//  XWLeftMenu.h
//  新闻
//
//  Created by 张声扬 on 15/12/1.
//  Copyright (c) 2015年 张声扬 All rights reserved.
//

#import <UIKit/UIKit.h>

//左边菜单最上面按钮的y值
#define  LeftMenuButtonY  50

@class XWLeftMenu;
@protocol XWLeftMenuDelegate <NSObject>

@optional
-(void)leftMenu:(XWLeftMenu*)leftMenu didSelectedFrom:(NSInteger)from to:(NSInteger)to;

@end


@interface XWLeftMenu : UIView

//代理
@property (nonatomic,weak) id<XWLeftMenuDelegate> delegate;

@end
