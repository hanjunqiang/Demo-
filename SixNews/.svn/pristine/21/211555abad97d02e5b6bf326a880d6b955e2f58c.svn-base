//
//  NewsHUD.m
//  SixNews
//
//  Created by  mac  on 15/12/2.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "NewsHUD.h"

@implementation NewsHUD
+(void)showMbProgressHUDwithTitle:(NSString *)title view:(UIView *)view
{
    MBProgressHUD *HUD=[[MBProgressHUD alloc]initWithView:view];
    [view addSubview:HUD];
    HUD.labelText=title;
    
    HUD.mode=MBProgressHUDModeText;
    //指定距离中心点X轴 Y轴的偏移量
    HUD.yOffset=0;
    HUD.xOffset=0;
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    }completionBlock:^{
        [HUD removeFromSuperview];
        
    }];
    
    
}
@end
