//
//  TestViewController.m
//  TransparentNavigationBar
//
//  Created by Michael on 15/11/20.
//  Copyright © 2015年 com.51fanxing. All rights reserved.
//

#import "TestViewController.h"
#import "UINavigationBar+Transparent.h"

@implementation TestViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    

    
//    self.navigationItem.hidesBackButton=YES;
    
    //该句不行
//    [self.navigationController.navigationBar js_reset];

//    [self.navigationController.navigationBar]
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(back)];
 
//    [self.navigationController.navigationBar js_setBackgroundColor:[UIColor clearColor]];

    
//    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(20, 20, 60, 45)];
    //        self.btn=btn;
//    self.button=btn;
//    btn.backgroundColor=[UIColor redColor];
//    [self.customView addSubview:btn];
//    [btn addTarget:self action:@selector(ccc) forControlEvents:UIControlEventTouchUpInside];

    //加不上
//    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1.000];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fqrwBackground"] forBarMetrics:UIBarMetricsDefault];
    
    UIView *btn=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    btn.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:btn];
//    [self.view insertSubview:btn atIndex:9];
    
//    [btn addTarget:self action:@selector(ccc) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    ////隐藏自定义的导航view
        for (id obj in self.navigationController.navigationBar.subviews) {
            if ([obj isKindOfClass:[UIView class]]) {
                UIView *view=(UIView *)obj;
                view.hidden=YES;
            }
        }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ////显示自定义的导航view
    for (id obj in self.navigationController.navigationBar.subviews) {
        if ([obj isKindOfClass:[UIView class]]) {
            UIView *view=(UIView *)obj;
            view.hidden=NO;
        }
    }
}

-(void)back
{

    [self.navigationController popViewControllerAnimated:YES];

}
@end
