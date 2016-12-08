//
//  XWDetailContentController.h
//  SixNews
//
//  Created by Dy on 15/12/3.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "XWNewsModel.h"
#import "XWConstomNavBar.h"
#import "XWNewsModel.h"
#import "XWDetailModel.h"
#import "XWDetailImgModel.h"
#import "XWHttpTool.h"
#import "XWReplyController.h"
#import "XWReplyModel.h"
#import "XWDetailBottomView.h"
#import "XWWriteReply.h"

//覆盖层按钮的tag
#define coverTag 1800
@interface XWDetailContentController : UIViewController<UIWebViewDelegate,XWDetailBottomDelegate,XWWriteReplyDelegate>
@property (nonatomic,strong) XWNewsModel *newsModel;
//内容详情模型
@property (nonatomic,strong) XWDetailModel *detailModel;

/*
 自定义的导航条view
 */
@property (nonatomic,weak) XWConstomNavBar *navBar;

//webview浏览器   用于显示网页
@property (nonatomic,weak) UIWebView *webView;
//返回按钮
@property (nonatomic,weak)  UIButton *backBtn;
//回复按钮
@property (nonatomic,weak)  UIButton *replyBtn;
//底部的评论view
@property (nonatomic,weak) XWDetailBottomView *commentView;
//发送评论的输入框
@property (nonatomic,weak) XWWriteReply *writeReply;

//存放评论模型的数组
@property (nonatomic,strong) NSMutableArray *replyArr;

@property (nonatomic,strong) Reachability *reach;
@end
