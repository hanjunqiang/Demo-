//
//  XWRegisterView.m
//  新闻练习
//
//  Created by  mac  on 15/12/1.
//  Copyright © 2015年 yuju. All rights reserved.
//

#import "XWRegisterView.h"

@implementation XWRegisterView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _phoneNumber=[[UITextField alloc]initWithFrame:CGRectMake(20, 90, 335, 45)];
        _getCaptcha=[[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_phoneNumber.frame)+20, 335, 45)];
        _phoneNumber.placeholder=@"   请输入手机号码";
        _phoneNumber.layer.borderWidth=1;
        _phoneNumber.layer.cornerRadius=2;
        _phoneNumber.keyboardType=UIKeyboardTypeNumberPad;
        _phoneNumber.layer.borderColor=[[UIColor grayColor]CGColor];
        
        //3.设置按钮的背景图片
        [_getCaptcha setBackgroundImage:[UIImage resizedImage:@"go_to_taskCentre_button"] forState:UIControlStateNormal];
        [_getCaptcha setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCaptcha setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _getCaptcha.font=[UIFont systemFontOfSize:18.0];
 
        [self addSubview:_phoneNumber];
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
