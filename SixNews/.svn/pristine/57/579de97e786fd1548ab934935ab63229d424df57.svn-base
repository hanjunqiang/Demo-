//
//  XWLoginView.m
//  新闻练习
//
//  Created by  mac  on 15/12/1.
//  Copyright © 2015年 yuju. All rights reserved.
//

#import "XWLoginView.h"

@implementation XWLoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
   
    {
        self=[super initWithFrame:frame];
        if (self) {
            self.backgroundColor=[UIColor whiteColor];
            _user=[[UITextField alloc]initWithFrame:CGRectMake(20+35+10, 90, 200, 45)];
            _userIcon=[[UIImageView alloc]initWithFrame:CGRectMake(20, 95, 35, 35)];
            UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(20, 140, 335, 1)];
            _pwd=[[UITextField alloc]initWithFrame:CGRectMake(20+35+10, 145, 200, 45)];
            _pwdIcon=[[UIImageView alloc]initWithFrame:CGRectMake(20,150, 35, 35)];
            UILabel *line2=[[UILabel alloc]initWithFrame:CGRectMake(20,195, 335, 1)];
            _userIcon.image=[UIImage imageNamed:@"login_username_icon"];
            _pwdIcon.image=[UIImage imageNamed:@"login_password_icon"];
            _user.placeholder=@"请输入邮箱账号或手机号";
            _pwd.placeholder=@"请输入密码";
            
            //设置数字键盘
            _user.keyboardType= UIKeyboardTypePhonePad;
//          _user.backgroundColor=[UIColor cyanColor];
            //加密  输入的值自动覆盖为*
            _pwd.secureTextEntry=YES;
            
            _forgetBtn =[[UIButton alloc]initWithFrame:CGRectMake(270, CGRectGetMaxY(line.frame)+10, 80, 30)];
            [_forgetBtn setTitle:@"   忘记密码         " forState:UIControlStateNormal];
            [_forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_forgetBtn setBackgroundImage:[UIImage imageNamed:@"login_forgot_button"] forState:UIControlStateNormal];
            _forgetBtn.font=[UIFont boldSystemFontOfSize:12.0];
            _forgetBtn.alpha=0.7;
//            _forgetBtn.backgroundColor=[UIColor blackColor];

            line.backgroundColor=[UIColor darkGrayColor];
            line.alpha=0.5;
            line2.backgroundColor=[UIColor darkGrayColor];
            line2.alpha=0.5;
            
            _loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(line2.frame)+20, 335, 45)];
            [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
            [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //1.设置登陆密码的背景图片
            [_loginBtn setBackgroundImage:[UIImage resizedImage:@"login_tip_button"] forState:UIControlStateNormal];
            [_loginBtn setBackgroundImage:[UIImage resizedImage:@"login_tip_button_highlight"] forState:UIControlStateHighlighted];
//            [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_tip_button_highlight"] forState:UIControlStateNormal];
            UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_loginBtn.frame)+40, 300, 15)];
           [self setLabel:textLabel setText:@"你还可以选择以下方式登录" andTextColor:[UIColor blackColor] andFont:[UIFont systemFontOfSize:14.0] andAlpha:0.3];
            UILabel *line3=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(textLabel.frame)+5, 375, 1)];
            line3.backgroundColor=[UIColor darkGrayColor];
            line3.alpha=0.1;
            //设置微信 微博 QQ登录
            _WXLoginBtn=[[UIButton alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(line3.frame)+20, 60, 60)];
            _WBLoginBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_WXLoginBtn.frame)+50, CGRectGetMaxY(line3.frame)+20, 60, 60)];
            _QQLoginBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_WBLoginBtn.frame)+50, CGRectGetMaxY(line3.frame)+20,60 , 60)];
            //设置背景图片
            [_WXLoginBtn setBackgroundImage:[UIImage imageNamed:@"share_platform_wechat"] forState:UIControlStateNormal];
            [_WBLoginBtn setBackgroundImage:[UIImage imageNamed:@"share_platform_sina"] forState:UIControlStateNormal];
            [_QQLoginBtn setBackgroundImage:[UIImage imageNamed:@"share_platform_qqfriends"] forState:UIControlStateNormal];
            UILabel *wx=[[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_WBLoginBtn.frame)+10,90, 10)];
             UILabel *wb=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(wx.frame)+20, CGRectGetMaxY(_WBLoginBtn.frame)+10, 90, 10)];
             UILabel *qq=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(wb.frame)+20, CGRectGetMaxY(_WBLoginBtn.frame)+10, 90, 10)];
           
            [self setLabel:wx setText:@"微信账号登录" andTextColor:[UIColor blackColor] andFont:[UIFont systemFontOfSize:14.0] andAlpha:0.8];
            [self setLabel:wb setText:@"新浪微博登录" andTextColor:[UIColor blackColor] andFont:[UIFont systemFontOfSize:14.0] andAlpha:0.8];
            [self setLabel:qq setText:@"QQ账号登录" andTextColor:[UIColor blackColor] andFont:[UIFont systemFontOfSize:14.0] andAlpha:0.8];
            UILabel *registerLabel=[[UILabel alloc]initWithFrame:CGRectMake(175, 630, 70, 10)];
            [self setLabel:registerLabel setText:@"没有账号？" andTextColor:[UIColor blackColor] andFont:[UIFont systemFontOfSize:14.0] andAlpha:0.4];
            _registerBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(registerLabel.frame)+5, 618, 115, 35)];
            [_registerBtn setTitle:@"   手机号快速注册         " forState:UIControlStateNormal];
            [_registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_registerBtn setBackgroundImage:[UIImage imageNamed:@"login_forgot_button"] forState:UIControlStateNormal];
            _registerBtn.font=[UIFont boldSystemFontOfSize:12.0];
            _registerBtn.alpha=0.7;

            [self addSubview:_pwd];
            [self addSubview:_user];
            [self addSubview:_userIcon];
            [self addSubview:_pwdIcon];
            [self addSubview:line];
            [self addSubview:line2];
            [self addSubview:_loginBtn];
            [self addSubview:textLabel];
            [self addSubview:line3];
            [self addSubview:qq];
            [self addSubview:wx];
            [self addSubview:wb];
            [self addSubview:_WBLoginBtn];
            [self addSubview:_WXLoginBtn];
            [self addSubview:_QQLoginBtn];
            [self addSubview:registerLabel];
            [self addSubview:_registerBtn];
            [self addSubview:_forgetBtn];
            }
        return self;
    }
 
}
-(UILabel *)setLabel:(UILabel *)label setText:(NSString *)text andTextColor:(UIColor *)color andFont:(UIFont *)font andAlpha:(CGFloat           )alpha
{
    label.text=text;
    label.textColor=color;
    label.font=font;
    label.alpha=alpha;
    return label;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end




