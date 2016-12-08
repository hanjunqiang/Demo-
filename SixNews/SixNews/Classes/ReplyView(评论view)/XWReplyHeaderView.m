//
//  XWReplyHeaderView.m
//  新闻
//
//  Created by user on 15/10/4.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "XWReplyHeaderView.h"

@implementation XWReplyHeaderView

-(instancetype)init
{
    self=[super init];
    if(self){
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

+(instancetype)shareWithTitle:(NSString *)title
{
    
    XWReplyHeaderView *headerV=[[self alloc]init];
    UIButton *btn=[[UIButton alloc]init];
    [btn setBackgroundImage: [UIImage resizedImage:@"contentview_commentbacky" left:0.5 top:0.5] forState:UIControlStateNormal];
    btn.userInteractionEnabled=NO;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame=CGRectMake(0, 0, 80, 40);
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, -3, 0, 3);
    btn.titleLabel.font=[UIFont systemFontOfSize:12];
    
    [headerV addSubview:btn];
    
 
    return headerV;
}


@end
