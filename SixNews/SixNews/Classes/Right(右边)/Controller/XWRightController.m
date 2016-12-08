//
//  XWRightController.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//


//菜单栏的高度
#define topMenuH  50
//中间内容的高度
#define centreH ScreenHeight*0.45
//头部视图的高度
#define headerH 120


//顶部菜单和头像之间的距离
#define menuMarginToHeader 20
//内容view所占控制器view宽度的比例
#define contentRatio 0.75
//底部的view多占控制view高度的比例
#define bottomViewRatio 0.22


#import "XWRightController.h"

@interface XWRightController ()

@end

@implementation XWRightController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"11");
    //1.换掉系统自带的view
    UIView *selfView=[[UIView alloc]init];
    CGFloat viewW=ScreenWidth*RightRatio;
    selfView.frame=CGRectMake(0, 0, viewW, self.view.height);
    self.view=selfView;
    //1.添加背景滚动视图
    [self setupBackgoundView];
    //1.添加头像
    [self addHeader];
    //2.添加头像下面的菜单
    [self addTopMenu];
    //3.添加中间的内容列表
    [self addContentList];
    //4.添加底部的view
    [self addBottomView];

}
#pragma mark 添加背景滚动视图
-(void)setupBackgoundView
{
    UIScrollView *backgroundView=[[UIScrollView alloc]init];
    backgroundView.x=0;
    backgroundView.width=self.view.width;
    backgroundView.y=0;
    backgroundView.height=ScreenHeight-ScreenHeight*bottomViewRatio;
    
    backgroundView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:backgroundView];
    self.backgroundView=backgroundView;
}

#pragma mark 添加头像
-(void)addHeader
{
    //1.创建头像视图
    UIView *headerView=[[UIView alloc]init];
    headerView.x=0;
    headerView.width=self.view.width;
    headerView.height=headerH;
    headerView.y=20;
    [self.backgroundView addSubview:headerView];
    self.headerView=headerView;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTap)];
    [self.headerView addGestureRecognizer:tap];
    //2.添加头像到headerView
    UIImageView *header=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right_navigation_head_default"]];
    CGFloat headerW=80;
    CGFloat hederH=headerW;
    CGFloat headerX=(headerView.width-headerW)*0.5;
    header.frame=CGRectMake(headerX, 20, headerW, hederH);
    [headerView addSubview:header];
    //3.添加头像下面的文字
    UILabel *labelStr=[[UILabel alloc]init];
    labelStr.text=@"立即登录账号";
    labelStr.font=[UIFont systemFontOfSize:16];
    CGFloat labelY=CGRectGetMaxY(header.frame)+5;
    labelStr.textAlignment=NSTextAlignmentCenter;
    labelStr.textColor=[UIColor whiteColor];
    labelStr.frame=CGRectMake(0, labelY, self.view.width, 25);
    [headerView addSubview:labelStr];
}

#pragma mark 添加头像底部 的菜单
-(void)addTopMenu
{
    XWTopMenu *topMenu=[[XWTopMenu alloc]init];
    
    CGFloat menuH=topMenuH;
    CGFloat menuW=self.view.width*contentRatio;
    CGFloat menuY=CGRectGetMaxY(self.headerView.frame)+menuMarginToHeader+5;
    CGFloat menuX=(self.view.width-menuW)*0.5;
    
    topMenu.frame=CGRectMake(menuX, menuY, menuW, menuH);
    [self.backgroundView addSubview:topMenu];
    self.topMenu=topMenu;
}

#pragma mark  添加中间的内容列表
-(void)addContentList
{
    XWCentreView *centreView=[[XWCentreView alloc]init];
    CGFloat centreViewW=self.view.width*(contentRatio-0.05);
    CGFloat centreViewH=centreH;
    CGFloat centreViewX=(self.view.width-centreViewW)*0.5;
    CGFloat centreViewY=CGRectGetMaxY(self.topMenu.frame)+menuMarginToHeader+5;
    
    centreView.frame=CGRectMake(centreViewX, centreViewY, centreViewW, centreViewH);
    [self.backgroundView addSubview:centreView];
    self.centreView=centreView;
    //设置背景滚动视图滚动的范围
    [self.backgroundView setContentSize:CGSizeMake(self.view.width, CGRectGetMaxY(centreView.frame)+20)];
}

#pragma mark 添加底部的view
-(void)addBottomView
{
    //1.创建底部view
    UIView *bottomView=[[UIView alloc]init];
    CGFloat bottonW=self.view.width;
    CGFloat bottomH=self.view.height*bottomViewRatio;
    CGFloat bottomX=0;
    CGFloat bottomY=self.view.height-bottomH;
    bottomView.frame=CGRectMake(bottomX, bottomY, bottonW, bottonW);
    [self.view addSubview:bottomView];
    //1.底部view添加
    XWBottomListView *bottomListView=[[XWBottomListView alloc]init];
    CGFloat footViewW=self.view.width*contentRatio;
    CGFloat footViewX=(self.view.width-footViewW)*0.5;
    CGFloat footViewH=bottomH*0.7;
    CGFloat footViewY=(bottomH-footViewH)*0.5;
    bottomListView.frame=CGRectMake(footViewX, footViewY, footViewW, footViewH);
    [bottomView addSubview:bottomListView];
    self.footListView=bottomListView;
}

#pragma mark 点击头像视图的事件
-(void)headerTap
{
    if([self.delegate respondsToSelector:@selector(righrVc: headerTap:)])
    {
        [self.delegate righrVc:self headerTap:1];
    }
    
}

@end
