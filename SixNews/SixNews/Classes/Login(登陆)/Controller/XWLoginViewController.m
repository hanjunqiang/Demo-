//
//  XWLoginViewController.m
//  新闻练习
//
//  Created by  mac  on 15/12/1.
//  Copyright © 2015年 yuju. All rights reserved.
//

#import "XWLoginViewController.h"
#import "XWLoginView.h"
#import "XWRegisterViewController.h"
#import "XWForgetPasswordViewController.h"
#import "XWNavController.h"

#import "NewsHUD.h"
#import "NSString+Helper.h"
@interface XWLoginViewController ()<UITextFieldDelegate>
@property(strong,nonatomic)XWLoginView *loginView;
@end

@implementation XWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.添加退出当前页的按钮
    [self setupNavRight];
    //2.给view添加识别手势
    [self addGesture];
    
    // Do any additional setup after loading the view.
    _loginView=[[XWLoginView alloc]initWithFrame:self.view.frame];
    _loginView.user.delegate=self;
    _loginView.pwd.delegate=self;
    [self.view addSubview:_loginView];
    //添加注册点击事件
    [_loginView.registerBtn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
    //点击登录事件
    [_loginView.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    //点击忘记密码
    [_loginView.forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
}
//登录
-(void)login
{
    if ([_loginView.user.text isEmptyString])
    {
        [NewsHUD showMbProgressHUDwithTitle:@"用户账号不能为空" view:self.view];
    }
    else if([_loginView.pwd.text isEmptyString])
    {
        [NewsHUD showMbProgressHUDwithTitle:@"密码不能为空" view:self.view];
    }
    else
    {
        //跳转代码
    }

}
//忘记密码
-(void)forgetBtnClick
{
    XWForgetPasswordViewController *forget=[[XWForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
    
}
#pragma mark 添加退出当前页的按钮
-(void)setupNavRight
{
    self.title=@"登陆我的新闻";
    
    //添加右边的导航栏的按钮
    if(!self.dismissType){
        UIBarButtonItem *rightItem=[UIBarButtonItem itemWithRightIcon:@"search_close_btn" highIcon:nil target:self action:@selector(quit)];
        self.navigationItem.rightBarButtonItem=rightItem;
    }
    
    //添加左边导航栏的按钮
    UIBarButtonItem *leftItem=[UIBarButtonItem itemWithWithLeftIocn:@"weather_back" highIcon:nil edgeInsets:UIEdgeInsetsMake(0, -13, 0, 13) target:self action:@selector(quit)];
    self.navigationItem.leftBarButtonItem=leftItem;
}
#pragma mark 给当前view添加识别手势
-(void)addGesture
{
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

-(void)tap
{
    [self.view endEditing:YES];
}

-(void)quit
{
    if(self.dismissType){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(void)toRegister
{
    XWRegisterViewController *registerVC=[[XWRegisterViewController alloc]init];
    
    XWNavController *nav=[[XWNavController alloc]initWithRootViewController:registerVC];
   
    [self presentViewController:nav animated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_loginView.user resignFirstResponder];
    [_loginView.pwd resignFirstResponder];
    return YES;
    
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
