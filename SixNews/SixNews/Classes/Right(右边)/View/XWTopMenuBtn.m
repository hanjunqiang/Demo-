//
//  XWTopMenuBtn.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWTopMenuBtn.h"

#define tabbarButtonImageRatio 0.65

@implementation XWTopMenuBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        self.imageView.contentMode=UIViewContentModeCenter;
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:14];
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:XWColorRGBA(255, 255, 255, 0.8) forState:UIControlStateHighlighted];
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW=contentRect.size.width;  //图片的高度
    CGFloat imageH=contentRect.size.height*tabbarButtonImageRatio;  //图片的高度
    return CGRectMake(0, 0, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW=contentRect.size.width; //文字的宽度
    CGFloat imageH=contentRect.size.height*tabbarButtonImageRatio;  //图片的高度
    CGFloat titleH=contentRect.size.height-imageH;  //文字的高度=按钮的高度-图片的高度
    
    return CGRectMake(0, imageH, titleW, titleH);
}



@end
