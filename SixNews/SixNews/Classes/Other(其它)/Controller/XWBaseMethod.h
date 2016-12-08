//
//  XWBaseMethod.h
//  SixNews
//
//  Created by mac on 15/12/1.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWBaseMethod : NSObject

//加载网络图片的方法
+(void)loadImageWithImg:(UIImageView*)imageView  url:(NSString*)urlStr;

//加载网络图片 自定义的占位图
+(void)loadImageWithImg:(UIImageView*)imageView  url:(NSString*)urlStr placeImg:(NSString*)placeImg;
//显示圈圈
+(void)showHUDAddedTo:(UIView*)view animated:(BOOL)animated;
//隐藏圈圈
+(void)hideHUDAddedTo:(UIView*)view animated:(BOOL)animated;

//错误提示
+(void)showErrorWithStr:(NSString*)error toView:(UIView*)view;
//正确的提示
+(void)showSuccessWithStr:(NSString*)success toView:(UIView*)view;


//判断有没有网络
+(BOOL)connectionInternet;


@end
