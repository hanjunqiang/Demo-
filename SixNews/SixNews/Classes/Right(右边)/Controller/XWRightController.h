//
//  XWRightController.h
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWLoginViewController.h"
#import "XWTopMenu.h"
#import "XWTopMenuBtn.h"
#import "XWCentreView.h"
#import "XWBottomListView.h"
//当前视图view所占屏幕宽度的比例
#define RightRatio 0.8

@class XWRightController;
@protocol XWRightControllerDelegate <NSObject>

@optional
//头像点击的代理方法
-(void)righrVc:(XWRightController*)rightVc headerTap:(NSInteger)headerTap;

@end

@interface XWRightController : UIViewController

//背景滚动视图
@property (nonatomic,weak) UIScrollView *backgroundView;
//头像视图
@property (nonatomic,weak) UIView *headerView;
//顶部的菜单视图  阅读 评论
@property (nonatomic,weak)  XWTopMenu *topMenu;
//中间的内容view
@property (nonatomic,weak) XWCentreView *centreView;
//底部按钮
@property (nonatomic,weak) XWBottomListView *footListView;

//代理
@property (nonatomic,weak) id<XWRightControllerDelegate>delegate;


@end
