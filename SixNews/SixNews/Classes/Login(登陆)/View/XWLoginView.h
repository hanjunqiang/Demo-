//
//  XWLoginView.h
//  新闻练习
//
//  Created by  mac  on 15/12/1.
//  Copyright © 2015年 yuju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWLoginView : UIView
@property(strong,nonatomic)UITextField *user;
@property(strong,nonatomic)UITextField *pwd;
@property(strong,nonatomic)UIImageView *userIcon;
@property(strong,nonatomic)UIImageView *pwdIcon;
@property(strong,nonatomic)UIButton *forgetBtn;
@property(strong,nonatomic)UIButton *loginBtn;
@property(strong,nonatomic)UIButton *registerBtn;

@property(strong,nonatomic)UIButton *WXLoginBtn;
@property(strong,nonatomic)UIButton *WBLoginBtn;
@property(strong,nonatomic)UIButton *QQLoginBtn;


@end
