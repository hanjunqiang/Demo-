//
//  XWPhotoController.h
//  SixNews
//
//  Created by Dy on 15/12/3.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWHttpTool.h"
#import "XWNewsModel.h"
#import "XWReplyController.h"
#import "XWConstomNavBar.h"
#import "XWPhotoContentView.h"
#import "XWPhotoBottomView.h"
#import "XWPhotoModel.h"
#import "XWPhotoDetailModel.h"

@interface XWPhotoController : UIViewController<UIScrollViewDelegate>

@property (nonatomic,strong) XWNewsModel *newsModel;

/*
 自定义的导航条view
 */
@property (nonatomic,weak) XWConstomNavBar *navBar;

//返回按钮
@property (nonatomic,weak)  UIButton *backBtn;
//回复按钮
@property (nonatomic,weak)  UIButton *replyBtn;
//滚动视图
@property (nonatomic,weak) UIScrollView *photoScrollView;

//新闻内容的view
@property (nonatomic,weak) XWPhotoContentView *photoContentV;

//底部view
@property (nonatomic,weak) XWPhotoBottomView *photoBottom;

//新闻数据的模型
@property (nonatomic,strong)  XWPhotoModel *photoModel;

//存放评论模型的数组
@property (nonatomic,strong) NSMutableArray *replyArr;
@end
