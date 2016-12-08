//
//  XWTopMenu.h
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义枚举
typedef enum
{
    topMenuRead, //阅读按钮的tag
    topMenuComment,  //评论按钮的tag
    topMenuCollect   //收藏按钮的tag
    
}topMenuType;

@class XWTopMenu;
@protocol XWTopMenuDelegate <NSObject>

@optional
-(void)topMenu:(XWTopMenu*)topMenu menuType:(topMenuType)menuType;

@end

@interface XWTopMenu : UIView
//代理
@property (nonatomic,weak) id<XWTopMenuDelegate> delegete;

@end
