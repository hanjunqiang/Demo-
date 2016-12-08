//
//  LSLStatusBarHUD.h
//
//  Created by lisilong on 15/9/21 QQ:876996667.
//

#import <UIKit/UIKit.h>

@interface LSLStatusBarHUD : NSObject
/**
 *  提示信息：图片+文字信息
 */
+ (void)showImage:(UIImage *)image text:(NSString *)text;

/**
 *  提示信息：图片名称+文字信息
 */
+ (void)showImageName:(NSString *)imageName text:(NSString *)text;

/**
 *  提示成功信息：默认图片名称+文字信息
 */
+ (void)showSuccess:(NSString *)text;

/**
 *  提示失败信息：默认图片名称+文字信息
 */
+ (void)showError:(NSString *)text;

/**
 *  隐藏信息提示框
 */
+ (void)hide;

/**
 *  提示信息：文字信息
 */
+ (void)showText:(NSString *)text;

/**
 *  正在加载中：默认加载指示器 + 文字信息
 */
+ (void)showLoadding:(NSString *)text;

@end
