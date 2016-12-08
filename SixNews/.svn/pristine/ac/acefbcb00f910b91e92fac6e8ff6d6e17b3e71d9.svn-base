//
//  UIBarButtonItem+CH.m
//  SixNews
//
//  Created by mac on 15/11/30.
//  Copyright (c) 2015年 张声扬. All rights reserved.
//

#import "UIBarButtonItem+CH.h"

@implementation UIBarButtonItem (CH)
//设置左边的按钮
+(UIBarButtonItem *)itemWithLeftIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *btn=[[UIButton alloc]init];
    
    // 这里需要注意：由于是想让图片右移，所以left需要设置为正，right需要设置为负。正在是相反的。
    // 让按钮图片左移15    设置图像边缘
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [btn setImage:[UIImage  resizedImage:icon] forState:UIControlStateNormal];
    btn.frame=CGRectMake(0, 20, btn.currentImage.size.width, btn.currentImage.size.height);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    

}

//设置右边按钮
+(UIBarButtonItem *)itemWithRightIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *btn=[[UIButton alloc]init];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    [btn setImage:[UIImage resizedImage:icon] forState:UIControlStateNormal];
    btn.frame=CGRectMake(0, 20, btn.currentImage.size.width, btn.currentImage.size.height);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    

    return [[UIBarButtonItem alloc]initWithCustomView:btn];

}
+(UIBarButtonItem *)itemWithWithLeftIocn:(NSString *)icon highIcon:(NSString *)hightIcon edgeInsets:(UIEdgeInsets)edgeInsets target:(id)target action:(SEL)action

{
    UIButton *btn=[[UIButton alloc]init];
    [btn setImageEdgeInsets:edgeInsets];
    [btn setImage:[UIImage resizedImage:icon] forState:UIControlStateNormal];
    btn.frame=CGRectMake(0, 20, btn.currentImage.size.width, btn.currentImage.size.height);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];


}
//设置按钮文字
+(UIBarButtonItem *)itemWithLeftTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 10);
    //导航条上UIBarButtonItem的更改方法（使用initWithCustomView:btn）
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:btn
                           ];
    

    return item;
}
@end
