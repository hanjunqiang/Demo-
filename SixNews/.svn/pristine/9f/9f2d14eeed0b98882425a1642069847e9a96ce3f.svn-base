
//
//  XWConstomNavBar.m
//  SixNews
//
//  Created by Dy on 15/12/3.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWConstomNavBar.h"

@implementation XWConstomNavBar

-(instancetype)init
{
    self=[super init];
    if(self){
        [self setupFirst];
    }
    return self;
}

-(void)setupFirst
{
    self.backgroundColor=[UIColor whiteColor];
    self.frame=CGRectMake(0, 0, ScreenWidth, 64);
    //底部添加一条线
    UIImageView *line=[[UIImageView alloc]init];
    line.backgroundColor=XWColorRGBA(20, 20, 20, 0.3);
    [self addSubview:line];
    line.frame=CGRectMake(0, self.height-0.3, self.width, 0.3);
    
}

@end
