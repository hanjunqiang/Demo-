//
//  XWForgetPasswordViewController.m
//  SixNews
//
//  Created by  mac  on 15/12/2.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWForgetPasswordViewController.h"
#import "XWForgetPasswordView.h"
@interface XWForgetPasswordViewController ()<UITextFieldDelegate >
@property(strong,nonatomic)XWForgetPasswordView *forgetView;
@end

@implementation XWForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.添加退出当前页的按钮
    [self setupNavRight];
    self.title=@"找回密码";
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
    _forgetView=[[XWForgetPasswordView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_forgetView];
    
}
- (void)setupNavRight
{
    //添加左边导航栏的按钮
    
    UIBarButtonItem *leftItem=[UIBarButtonItem itemWithWithLeftIocn:@"weather_back" highIcon:nil edgeInsets:UIEdgeInsetsMake(0, -13, 0, 13) target:self action:@selector(quitRegis)];
    self.navigationItem.leftBarButtonItem=leftItem;
}
#pragma mark 退出的方法
-(void)quitRegis
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
