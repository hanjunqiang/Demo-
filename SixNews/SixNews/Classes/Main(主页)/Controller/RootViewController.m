//
//  RootViewController.m
//  新闻
//
//  Created by 张声扬 on 15/12/1.
//  Copyright (c) 2015年 张声扬 All rights reserved.
//

#import "RootViewController.h"
#import "XWNavController.h"
#import "XWLeftMenu.h"
#import "XWRightController.h"
#import "XWFeedBackController.h"
#import "XWPushController.h"
#import "XWReporterController.h"
#import "XWMediaController.h"
#import "XWSettingController.h"
#import "XWLoginViewController.h"
#import "XWHomeController.h"

//定义左边菜单栏的宽、高 y
#define LeftMenuW    ScreenWidth*0.65

#define Timer 0.25
//覆盖层按钮的tag值
#define buttonTag 1200


@interface RootViewController ()<XWLeftMenuDelegate,XWRightControllerDelegate,XWTopMenuDelegate,XWCentreViewDelegate,XWBottomListViewDelegate>

//左边菜单栏
@property (nonatomic,weak)  XWLeftMenu *leftMenu;
//当前显示的控制器
@property (nonatomic,strong) XWNavController *showNavController;
//右边的控制器
@property (nonatomic,strong) XWRightController *rightVc;

@end

@implementation RootViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //添加背景图片
    [self addBackgroundImage];
    //添加左边菜单栏
    [self setupLeftMenu];
    //添加子控制器
    [self addChildControllers];
    //添加右边的控制栏
    [self addRightMenu];
    //8.监听夜间模式
    [XWNotification addObserver:self selector:@selector(night1Click) name:nightName object:nil];
    //8.监听白天模式
    [XWNotification addObserver:self selector:@selector(dayClick) name:dayName object:nil];
}

#pragma mark 添加而背景图片
-(void)addBackgroundImage
{
    
    UIImageView *bak=[[UIImageView alloc]initWithFrame:self.view.bounds];
    bak.image=[UIImage imageNamed:@"default_cover_gaussian"];
        [self.view addSubview:bak];
}
-(void)night1Click
{
    self.view.alpha = 0.5;
    
}
-(void)dayClick
{
    self.view.alpha = 1;
}

#pragma mark 添加左边菜单栏
-(void)setupLeftMenu
{
    XWLeftMenu *leftMenu=[[XWLeftMenu alloc]initWithFrame:CGRectMake(0, 0, LeftMenuW, self.view.height)];
    [self.view insertSubview:leftMenu atIndex:1];
    leftMenu.delegate=self;
    self.leftMenu=leftMenu;
}
#pragma mark 添加右边的控制器
-(void)addRightMenu
{
    XWRightController *right=[[XWRightController alloc]init];
    right.delegate=self; //头像点击的代理
    CGFloat rightX=ScreenWidth-ScreenWidth*RightRatio;
    right.view.x=rightX;
    right.view.width=ScreenWidth*RightRatio-5;
    [self.view insertSubview:right.view atIndex:1];
    //头像下面菜单的点击代理
    right.topMenu.delegete=self;
    //右边中间按钮视图的代理
    right.centreView.delegate=self;
    //右边底部按钮的代理
    right.footListView.delegate=self;
    
    self.rightVc=right;
}


#pragma mark 添加子控制器
-(void)addChildControllers
{
    //首页
    XWHomeController *home=[[XWHomeController alloc]init];
    [self setupController:home title:@"新闻"];
    //添加订阅控制器
    UIViewController *read=[[UIViewController alloc]init];
    [self setupController:read title:@"订阅"];
    //图片
    UIViewController *imgVC=[[UIViewController alloc]init];
    [self setupController:imgVC title:@"图片"];
    //视频
    UIViewController *video=[[UIViewController alloc]init];
    [self setupController:video title:@"视频"];
    //跟帖
    UIViewController *reply=[[UIViewController alloc]init];
    [self setupController:reply title:@"跟帖"];
    //电台
    UIViewController *audio=[[UIViewController alloc]init];
    [self setupController:audio title:@"电台"];
}

//添加子控制器的实现方法
-(void)setupController:(UIViewController*)vc title:(NSString*)title
{
    if(self.childViewControllers.count>=1){
       vc.view.backgroundColor=XWRandomColor;
    }
    
    XWNavController *nav=[[XWNavController alloc]initWithRootViewController:vc];
    
    vc.title=title;
    
    vc.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithLeftIcon:@"top_navigation_menuicon" highIcon:@"" target:self action:@selector(leftClick)];
    vc.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithRightIcon:@"top_navigation_infoicon" highIcon:nil target:self action:@selector(rightClick)];
    [self addChildViewController:nav];
    
    //为首页添加view
    if(self.childViewControllers.count==1){
        self.showNavController=nav;
        [self.view addSubview:nav.view];
    }
}

#pragma mark 导航栏左边按钮点击的方法
-(void)leftClick
{
    self.leftMenu.hidden=NO;

    //先调整左边菜单的动画属性   然后在下面的block里面 在调回去
    CGAffineTransform scaleform=CGAffineTransformMakeScale(0.9, 0.9);
    CGAffineTransform anim=CGAffineTransformTranslate(scaleform, -80, 0);
    self.leftMenu.transform=anim;
    
    [UIView animateWithDuration:Timer animations:^{
        //调回左边菜单的动画属性
        self.leftMenu.transform=CGAffineTransformIdentity;
        //1.算出缩放比例
        CGFloat navH=ScreenHeight-2*LeftMenuButtonY;
        CGFloat scale=navH/ScreenHeight; //比例
        //2.左边菜单的距离
        CGFloat leftMargin=ScreenWidth*(1-scale)*0.5; //缩放后首页视图距离两边的距离
        CGFloat translateX=(LeftMenuW-leftMargin)/scale;
        //3.设置移动缩放
        CGAffineTransform scaleForm=CGAffineTransformMakeScale(scale, scale);
        CGAffineTransform translateForm=CGAffineTransformTranslate(scaleForm, translateX, 0);
        self.showNavController.view.transform=translateForm;
        //4.创建一个按钮覆盖首页
        UIButton *cover=[[UIButton alloc]initWithFrame:self.showNavController.view.bounds];
        //设置按钮的tag
        cover.tag=buttonTag;
        
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.showNavController.view addSubview:cover];
    }];
    
}
#pragma mark 导航栏右边按钮点击的方法
-(void)rightClick
{
    //隐藏左边菜单栏
    self.leftMenu.hidden=YES;
    self.rightVc.view.hidden=NO; //显示右边菜单栏
    
    self.rightVc.backgroundView.transform=CGAffineTransformMakeScale(0.8, 0.8);
    self.rightVc.view.alpha=0.5;
    
    [UIView animateWithDuration:Timer animations:^{
        //调回左边菜单的动画属性
        self.leftMenu.transform=CGAffineTransformIdentity;
        //设置右边的view动画返回
        self.rightVc.backgroundView.transform=CGAffineTransformIdentity;
        self.rightVc.view.alpha=1;
        //1.算出缩放比例
        CGFloat navH=ScreenHeight-2*LeftMenuButtonY;
        CGFloat scale=navH/ScreenHeight; //比例
        //2.左边菜单的距离
        CGFloat rightMargin=ScreenWidth*(1-scale)*0.5; //缩放后首页视图距离两边的距离
        CGFloat translateX=-(ScreenWidth*RightRatio-rightMargin)/scale;
        //3.设置移动 缩放
        CGAffineTransform scaleForm=CGAffineTransformMakeScale(scale, scale);
        CGAffineTransform translateForm=CGAffineTransformTranslate(scaleForm, translateX, 0);
        self.showNavController.view.transform=translateForm;
        //4.创建一个按钮覆盖首页
        UIButton *cover=[[UIButton alloc]initWithFrame:self.showNavController.view.bounds];
        cover.tag=buttonTag; //设置按钮的tag
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.showNavController.view addSubview:cover];
    }];
    
}



#pragma mark 点击覆盖按钮返回
-(void)coverClick:(UIButton*)cover
{
    
    [UIView animateWithDuration:Timer animations:^{
        //设置左边菜单的动画属性
        CGAffineTransform scaleform=CGAffineTransformMakeScale(0.9, 0.9);
        CGAffineTransform anim=CGAffineTransformTranslate(scaleform, -80, 0);
        self.leftMenu.transform=anim;
        self.leftMenu.hidden = YES;
        
        //设置右边view的动画属性
        self.rightVc.backgroundView.transform=CGAffineTransformMakeScale(0.8, 0.8);
        self.rightVc.view.alpha=0.5;
        self.rightVc.view.hidden = YES;
        
        
        self.showNavController.view.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //移除按钮
        [cover removeFromSuperview];
    }];
}

#pragma mark 左边菜单栏按钮点击的代理方法
-(void)leftMenu:(XWLeftMenu *)leftMenu didSelectedFrom:(NSInteger)from to:(NSInteger)to
{
    //取出上一个控制器
    XWNavController *lastNav=self.childViewControllers[from];
    [lastNav.view removeFromSuperview];
    //要切换到的控制器
    XWNavController *nav=self.childViewControllers[to];
    //赋值动画属性
    nav.view.transform=lastNav.view.transform;
    
    [self.view addSubview:nav.view];
    self.showNavController=nav;
    
    [self coverClick:(UIButton*)[nav.view viewWithTag:buttonTag]];
    
}
#pragma mark 右边头像点击的方法
-(void)righrVc:(XWRightController *)rightVc headerTap:(NSInteger)headerTap
{
    [self jumpLoginVc];
}

#pragma mark 头像下面菜单的点击代理
-(void)topMenu:(XWTopMenu *)topMenu menuType:(topMenuType)menuType
{
    switch (menuType) {
        case topMenuCollect:
        case topMenuComment:
        case topMenuRead:
        {
            NSLog(@"asx");
            //跳转到登陆控制器
            [self jumpLoginVc];
        }
            break;
            
    }
}

#pragma mark 右边中间按钮视图的代理方法
-(void)centreView:(XWCentreView *)centreView centreTag:(buttonType)centreTag
{
    switch (centreTag) {
        case buttonTypeDownload: //下载按钮点击操作
            NSLog(@"下载");
            [centreView downloadWithTag:buttonTypeDownload];
            break;
        case buttonTypePush: //推送按钮点击操作
        {
            XWPushController *push=[[XWPushController alloc]init];
            push.title=@"推送消息";
            [self jumpToVc:push];
        }
            
            break;
        case buttonTypeMedia:   //媒体影响力按钮点击操作
        {
            XWMediaController *media=[[XWMediaController alloc]init];
            media.title=@"媒体影响力";
            [self jumpToVc:media];
        }
            break;
        case buttonTypeReporter:   //记者影响力按钮点击操作
        {
            XWReporterController *reporter=[[XWReporterController alloc]init];
            reporter.title=@"记者影响力";
            [self jumpToVc:reporter];
        }
            break;
        case buttonTypeFeedback:   //意见反馈按钮点击操作
        {
            XWFeedBackController *feedBack=[[XWFeedBackController alloc]init];
            [self jumpToVc:feedBack];
        }
            
            break;
    }
}
#pragma mark 跳转到登陆控制器的方法
-(void)jumpLoginVc
{
    NSLog(@"aedsae");
    XWLoginViewController *login=[[XWLoginViewController alloc]init];
    XWNavController *nav=[[XWNavController alloc]initWithRootViewController:login];
    self.title=@"登录到我的新闻";
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark 要跳转到的控制器
-(void)jumpToVc:(UIViewController*)vc
{
    XWNavController *nav=[[XWNavController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark 右边底部按钮代理方法
-(void)footView:(XWBottomListView *)footView footTag:(FootButtonType)footTag
{
    switch (footTag) {
        case FootButtonTypeSetting:
        {
            XWSettingController *sett=[[XWSettingController alloc]init];
            [self jumpToVc:sett];
        }
            break;
            
        default:
            break;
    }
}


@end
