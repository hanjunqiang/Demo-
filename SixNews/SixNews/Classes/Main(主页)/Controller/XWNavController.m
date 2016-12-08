//
//  XWNavController.m
//  新闻
//
//  Created by 张声扬 on 15/12/1.
//  Copyright (c) 2015年 张声扬 All rights reserved.
//

#import "XWNavController.h"

@interface XWNavController ()

@end

@implementation XWNavController


+(void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:[UIColor redColor]];
    [navBar setTintColor:[UIColor whiteColor]];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //隐藏掉navigation底部的那条线
    navBar.shadowImage=[[UIImage alloc]init];
    
    
    //2.设置导航栏barButton上面文字的颜色
    UIBarButtonItem *item=[UIBarButtonItem appearance];
    [item setTintColor:[UIColor whiteColor]];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
}

@end
