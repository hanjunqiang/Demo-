//
//  UIImage+CH.h
//  SixNews
//
//  Created by mac on 15/11/30.
//  Copyright (c) 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ImageScale 0.2
#define LogoImageMargin 5

@interface UIImage (CH)
+(UIImage *)resizedImage:(NSString *)name;
+(UIImage *)resizedImage:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

//截屏方法
+(instancetype)renderView:(UIView *)renderView;
//图片加水印
+(instancetype)waterWithBgName:(NSString *)bg waterLogo:(NSString *)water;

//剪裁图片为圆
+(instancetype)clipWithImageName:(NSString *)name borderW:(CGFloat)bordersW borderColor:(UIColor *)borderColor;





//设置图片的背景颜色
+(UIImage *)imageWithColor:(UIColor *)color;

@end
