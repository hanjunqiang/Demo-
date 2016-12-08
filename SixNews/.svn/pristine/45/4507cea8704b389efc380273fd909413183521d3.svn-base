//
//  XWPhotoBottomView.m
//  SixNews
//
//  Created by Dy on 15/12/2.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWPhotoBottomView.h"

@implementation XWPhotoBottomView


-(NSMutableArray *)btnArr
{

    if (_btnArr == nil)
    {
        _btnArr = [NSMutableArray array];
        
    }
    
    return _btnArr;
}

-(instancetype)init
{

    if (self = [super init])
    {
    
        self.width = [UIScreen mainScreen].bounds.size.width;
        self.height = 50;
        
        
        [self addButtons];
    }
    
    return self;
    
}

-(void)addButtons
{

    [self addButtonWithImg:@"top_navigation_more" tag:buttonDownloadType];
    [self addButtonWithImg:@"weather_share" tag:buttonShareType];
    [self addButtonWithImg:@"icon_star" selectedImg:@"icon_star_full" tag:buttonLikeType];
}

-(void)addButtonWithImg:(NSString*)img tag:(ybuttonType)tag
{
    UIButton *btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    btn.tag=tag;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnArr addObject:btn];
    [self addSubview:btn];
}

-(void)addButtonWithImg:(NSString*)img selectedImg:(NSString*)selectedImg tag:(ybuttonType)tag
{
    UIButton *btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImg] forState:UIControlStateSelected];
    btn.tag=tag;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnArr addObject:btn];
    [self addSubview:btn];
}

-(void)btnClick:(UIButton*)sender
{
    switch (sender.tag) {
        case buttonDownloadType:
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"保存图片被阻止了" message:@"请到系统\"设置>隐私>照片\"中开启界面新闻访问权限" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case buttonShareType:
        {
            
        }
            break;
            
        case buttonLikeType:{
            sender.selected=!sender.isSelected;
        }
            break;
    }
}


-(void)layoutSubviews
{
    NSInteger count=self.btnArr.count;
    CGFloat btnW=ScreenWidth*0.5/count;
    CGFloat btnH=self.height;
    CGFloat btnY=0;
    CGFloat marginF=ScreenWidth*(1-0.5);
    if(iPhone6){
        
    }
    
    CGFloat btnX=0;
    
    for(int i=0;i<(int)count;i++){
        UIButton *btn=self.btnArr[i];
        btnX=btnW*i+marginF;
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        
    }
}



@end
