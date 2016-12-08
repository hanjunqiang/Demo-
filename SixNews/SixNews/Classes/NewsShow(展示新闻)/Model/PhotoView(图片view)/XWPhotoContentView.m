//
//  XWPhotoContentView.m
//  SixNews
//
//  Created by Dy on 15/12/2.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWPhotoContentView.h"

@implementation XWPhotoContentView
-(instancetype)init
{

    if (self = [super init])
    {
        
        self.width = [[UIScreen mainScreen]bounds].size.width;
        self.height = 80;
        
        [self addSubviews];
        
    }
    
    return self;
}

-(void)addSubviews
{

    //添加title
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font=[UIFont fontWithName:@"HYQiHei" size:15];
    [self addSubview:titleLabel];
    self.titleLabel=titleLabel;
    //添加图片数量label
    UILabel *numLabel=[[UILabel alloc]init];
    numLabel.textAlignment=NSTextAlignmentRight;
    numLabel.font=[UIFont systemFontOfSize:15];
    numLabel.textColor=[UIColor whiteColor];
    [self addSubview:numLabel];
    self.numLabel=numLabel;
    //显示对片对应的内容
    UITextView *contentText=[[UITextView alloc]init];
    contentText.backgroundColor=[UIColor clearColor];
    contentText.editable=NO;
    contentText.contentInset=UIEdgeInsetsMake(-7, 0, 7, 0);

    contentText.textColor=[UIColor whiteColor];
    contentText.font=[UIFont systemFontOfSize:13];
    [self addSubview:contentText];
    self.contentText=contentText;
    
}
-(void)layoutSubviews
{
    //1.设置titleLabel的frame
    CGFloat titleLabelX=10;
    CGFloat titleLabelY=0;
    CGFloat titleLabelW=self.width-10*5;
    CGFloat titleLabelH= 20;
    self.titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    //2.设置数量label的frame
    CGFloat numLabelY=0;
    CGFloat numLabelW=60;
    CGFloat numLabelH=20;
    CGFloat numLabelX=self.width-10-numLabelW;
    self.numLabel.frame=CGRectMake(numLabelX, numLabelY, numLabelW, numLabelH);
    //3.设置内容的frame
    CGFloat contentX=10;
    CGFloat contentY=CGRectGetMaxY(_titleLabel.frame);
    CGFloat contentW=self.width-2*10;
    CGFloat contentH=self.height-contentY;
    self.contentText.frame=CGRectMake(contentX, contentY, contentW, contentH);
}


@end
