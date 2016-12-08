//
//  XWRegisterViewController.m
//  新闻练习
//
//  Created by  mac  on 15/12/1.
//  Copyright © 2015年 yuju. All rights reserved.
//

#import "XWRegisterViewController.h"
#import "XWRegisterView.h"
#import "NewsHUD.h"

@interface XWRegisterViewController ()
@property(strong,nonatomic)XWRegisterView *registerView;
@end

@implementation XWRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"注册新闻通行证";
    //1.添加退出当前页的按钮
    [self setupNavRight];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    _registerView=[[XWRegisterView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_registerView];
    //获取验证码
    [_registerView.getCaptcha addTarget:self action:@selector(getcode) forControlEvents:UIControlEventTouchUpInside];
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
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
//验证码
-(void)getcode
{
    [self.view endEditing:YES];//收键盘
    
    NSString *regex=@"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch=[predicate evaluateWithObject:[_registerView.phoneNumber.text stringByReplacingOccurrencesOfString:@"-" withString:@""]];
    
    
    if (_registerView.phoneNumber.text.length<1)
    {
        [NewsHUD showMbProgressHUDwithTitle:@"手机号不能为空" view:self.view];
    }
    else if (!isMatch)
    {
        [NewsHUD showMbProgressHUDwithTitle:@"请输入正确的手机号码" view:self.view];
    }
    else
    {
        //写跳转代码
    }
 
}

//手机号后加 ——
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==_registerView.phoneNumber)
    {
        NSString *textStr=textField.text;
        if (![_registerView.phoneNumber.text isEqualToString:@""])
        {
            if (_registerView.phoneNumber.text.length>12)
            {
                return NO;
            }
            else
            {
                if (textField.text.length==3||textField.text.length==8)
                {
                    NSString *str=[textStr substringWithRange:NSMakeRange(0, textField.text.length)];
                    textField.text=[NSString stringWithFormat:@"%@-",str];
                }
            }
        }
    }
    return YES;
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

//-(void)back
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}

@end
