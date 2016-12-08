//
//  LSLStatusBarHUD.m
//
//  Created by lisilong on 15/9/21 QQ:876996667.
//

#import "LSLStatusBarHUD.h"

/** 信息提示窗口 */
UIWindow *window_;

/** 提示信息的定时器 */
static NSTimer *timer_;

/** HUD控件的高度 */
static CGFloat const LSLStatusBarHUDHeight = 20;

/** HUD控件的动画持续时间（出现\隐藏） */
static CGFloat const LSLAnimatelDuration = 0.25;

/** HUD控件默认会停留多长时间 */
static CGFloat const LSLTimeInterval = 1.5;

@implementation LSLStatusBarHUD
/**
 *  提示信息：图片+文字信息
 */
+ (void)showImage:(UIImage *)image text:(NSString *)text
{
    // 一开始时取消定时和隐藏之前的window
    [timer_ invalidate];
    timer_ = nil;
    window_.hidden = YES;
    
    // 创建一个提示窗口
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, - LSLStatusBarHUDHeight, [UIScreen mainScreen].bounds.size.width, LSLStatusBarHUDHeight);
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = NO;
    window_.backgroundColor = [UIColor blackColor];
    
    // 创建提示信息
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = window_.bounds;
    [btn setTitle:text forState:UIControlStateNormal];
    if (image) { // 有图片时显示
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    }
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleLabel.textColor = [UIColor whiteColor];
    
    [window_ addSubview:btn];
    
    // 动画显示
    [UIView animateWithDuration:LSLAnimatelDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = 0;
        window_.frame = frame;
    }];
    
    // 动画隐藏
    timer_ = [NSTimer scheduledTimerWithTimeInterval:LSLTimeInterval target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

/**
 *  提示信息：图片名称+文字信息
 */
+ (void)showImageName:(NSString *)imageName text:(NSString *)text
{
    [self showImage:[UIImage imageNamed:imageName] text:text];
}

/**
 *  提示成功信息：默认图片名称+文字信息
 */
+ (void)showSuccess:(NSString *)text
{
    [self showImage:[UIImage imageNamed:@"LSLStatusBarHUD.bundle/success"] text:text];
}

/**
 *  提示失败信息：默认图片名称+文字信息
 */
+ (void)showError:(NSString *)text
{
    [self showImage:[UIImage imageNamed:@"LSLStatusBarHUD.bundle/error"] text:text];
}

/**
 *  隐藏
 */
+ (void)hide
{
    // 清空定时器
    [timer_ invalidate];
    timer_ = nil;
    
    // 动画隐藏
    [UIView animateWithDuration:LSLAnimatelDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = - LSLStatusBarHUDHeight;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        window_ = nil;
    }];

}

/**
 *  提示信息：文字信息
 */
+ (void)showText:(NSString *)text
{
    [self showImage:nil text:text];
}

/**
 *  正在加载中：默认加载指示器 + 文字信息
 */
+ (void)showLoadding:(NSString *)text
{
    // 一开始时取消定时和隐藏之前的window
    [timer_ invalidate];
    timer_ = nil;
    window_.hidden = YES;
    
    // 创建一个提示窗口
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, - LSLStatusBarHUDHeight, [UIScreen mainScreen].bounds.size.width, LSLStatusBarHUDHeight);
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor blackColor];
    window_.hidden = NO;
    
    // 创建提示信息
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = window_.bounds;
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleLabel.textColor = [UIColor whiteColor];
    
    [window_ addSubview:btn];
    
    // 创建指示器
    UIActivityIndicatorView *activityV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityV.center = CGPointMake(btn.titleLabel.frame.origin.x - 60, window_.frame.size.height * 0.5);
    [activityV startAnimating];
    
    [window_ addSubview:activityV];
    
    // 动画显示
    [UIView animateWithDuration:LSLAnimatelDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = 0;
        window_.frame = frame;
    }];
}
@end
