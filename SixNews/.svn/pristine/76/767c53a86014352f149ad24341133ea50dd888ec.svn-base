//
//  XWHeaderCell.m
//  SixNews
//
//  Created by Dy on 15/12/3.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWHeaderCell.h"

@implementation XWHeaderCell
-(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame])
    {
        [self addSubViews];
        
    }
    
    return self;
}
-(void)addSubViews
{
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.frame=self.bounds;
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds=YES;
  
    [self.contentView addSubview:imageView];
    self.imageView=imageView;
    
    
}
-(void)setNewsModel:(XWNewsModel *)newsModel
{

    [XWBaseMethod loadImageWithImg:self.imageView url:newsModel.imgsrc];
    
}
@end
