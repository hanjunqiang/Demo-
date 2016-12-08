//
//  XWForgetPasswordView.m
//  SixNews
//
//  Created by  mac  on 15/12/2.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWForgetPasswordView.h"

@implementation XWForgetPasswordView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _userName=[[UITextField alloc]initWithFrame:CGRectMake(20, 90, 335, 45)];
        _getCaptcha=[[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_userName.frame)+20, 335, 45)];
        _userName.placeholder=@"   请输入手机号或邮箱账号";
        _userName.layer.borderWidth=1;
        _userName.layer.cornerRadius=2;
        _userName.keyboardType=UIKeyboardTypeNumberPad;
        _userName.layer.borderColor=[[UIColor grayColor]CGColor];
        
        //3.设置按钮的背景图片
        [_getCaptcha setBackgroundImage:[UIImage resizedImage:@"go_to_taskCentre_button"] forState:UIControlStateNormal];
        [_getCaptcha setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCaptcha setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _getCaptcha.font=[UIFont systemFontOfSize:18.0];
        
        [self addSubview:_userName];
        [self addSubview:_getCaptcha];

    
    }
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
