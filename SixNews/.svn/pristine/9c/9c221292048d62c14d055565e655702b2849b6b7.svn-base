//
//  XWNewsFrameModel.m
//  SixNews
//
//  Created by Dy on 15/12/2.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWNewsFrameModel.h"

#define marginTop  10
#define marginLeft 10
#define miniImgMargin 5  //图片之间的间距
//常态下图片的宽度和高度
#define normalImgW  80
#define normalImgH 60
//多张图片状态下得宽度和高度
#define moreImgW
#define moreImgH

@implementation XWNewsFrameModel

-(void)setNewsModel:(XWNewsModel *)newsModel
{

    _newsModel = newsModel;
    if (newsModel.hasHead && newsModel.photosetID)
    {
        
        if (newsModel.imgextra.count)
        {
            
            [self imgextra];
            
        }
        else
        {
            
            [self normalShow];
            
        }
        
        
    }
    else if (newsModel.hasHead)
    {
    
        if (newsModel.imgextra.count)
        {
            
            [self imgextra];
            
        }
        else
        {
            
            [self normalShow];
            
        }
        
    }
    else if (newsModel.imgType)
    {
    
        [self imgType];
        
    }
    else if (newsModel.imgextra)
    {
        [self imgextra];
    }
    else
    {
        
        [self normalShow];
        
    }
    
}
/*
 一张大图显示方法
 */
-(void)imgType
{
    //设置自定义单元view
    _newsViewF = CGRectMake(0, 0, ScreenWidth, 170);
    
    //设置标题
    CGFloat titleX = marginLeft;
    CGFloat titleY = marginTop;
    
    CGSize titleS = [self.newsModel.title sizeWithAttributes:@{NSFontAttributeName:titleFont}];
    _titleF = CGRectMake(titleX, titleY, titleS.width+10, titleS.height);
    
    //设置图片
    CGFloat imgY = CGRectGetMaxY(_titleF)+marginTop;
    CGFloat imgX = marginLeft;
    CGFloat imgH = 102;
    CGFloat imgW = ScreenWidth-marginLeft*2;
    _imgIconF = CGRectMake(imgX, imgY, imgW, imgH);
   
    //设置subtitle
    CGFloat subtitleX = marginLeft;
    CGFloat subtitleY = CGRectGetMaxY(_imgIconF)+marginTop;
    CGFloat maxWidth = ScreenWidth-marginLeft*2;  //最大的宽度
    CGSize subtitleS = [self.newsModel.digest boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:subtitleFont} context:nil].size;
    _subtitleF = CGRectMake(subtitleX, subtitleY, subtitleS.width, subtitleS.height);
    
    //单元格的高度
    _cellH = 170;
}

/*
 *   多张图片显示
 */
-(void)imgextra
{
    //设置自定义单元view
    _newsViewF = CGRectMake(0, 0, ScreenWidth, 120);
    //设置标题
    CGFloat titleX = marginLeft;
    CGFloat titleY = marginTop;
    CGSize titleS = [self.newsModel.title sizeWithAttributes:@{NSFontAttributeName:titleFont}];
    _titleF = CGRectMake(titleX, titleY, titleS.width-20, titleS.height);
    
    //设置回复按钮
    NSString *replyStr = self.newsModel.replyCount ;
    CGFloat replyY = marginTop;
    CGSize replyS = [replyStr sizeWithAttributes:@{NSFontAttributeName:replyFont}];
    CGFloat replyW = replyS.width+10;
    CGFloat replyX = ScreenWidth-replyW-marginLeft;
    _replyF = CGRectMake(replyX, replyY, replyW, replyS.height);
    
    //图片
    CGFloat imgY = CGRectGetMaxY(_titleF)+marginTop;
    CGFloat imgX = marginLeft;
    CGFloat imgW = (ScreenWidth-marginLeft*2-miniImgMargin*2)/3;  //多张图片显示的时候的宽度
    CGFloat imgH = 70;
    _imgIconF = CGRectMake(imgX, imgY, imgW, imgH);
   
    //第二张图片
    CGFloat otherImg1X = CGRectGetMaxX(_imgIconF)+miniImgMargin;
    _otherImg1F = CGRectMake(otherImg1X, imgY, imgW, imgH);
   
    //第三张图片
    CGFloat otherImg2X = CGRectGetMaxX(_otherImg1F)+miniImgMargin;
    _otherImg2F = CGRectMake(otherImg2X, imgY, imgW, imgH);
    
    //单元格的高度
    _cellH = 120;
}
/*
 正常情况下的显示
 */
-(void)normalShow
{
    //设置自定义单元view
    _newsViewF = CGRectMake(0, 0, ScreenWidth, 80);
    
    //设置图片
    CGFloat imgY = marginTop;
    CGFloat imgX = marginLeft;
    CGFloat imgH = normalImgH;
    CGFloat imgW = normalImgW;
    _imgIconF = CGRectMake(imgX, imgY, imgW, imgH);
    
    //设置标题
    CGFloat titleX = CGRectGetMaxX(_imgIconF)+marginLeft;
    CGFloat titleY = marginTop;
    CGSize titleS = [self.newsModel.title sizeWithAttributes:@{NSFontAttributeName:titleFont}];
    _titleF = CGRectMake(titleX, titleY, titleS.width+10, titleS.height);
    
    
    //设置子标题
    CGFloat subtitleX = CGRectGetMaxX(_imgIconF)+marginLeft;
    CGFloat subtitleH = 0;
    CGFloat subtitleY = 0;
    CGFloat maxWidth = ScreenWidth-imgW-marginLeft*4;
    //有这个值得话表明是 移动互联网 或者房地产   null
    CGSize subtitleS = [self.newsModel.digest boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:subtitleFont} context:nil].size;
    
    if(self.newsModel.pixel || subtitleS.height>30)
    {
        
        CGSize subtitleS=[self.newsModel.ptime sizeWithAttributes:@{NSFontAttributeName:subtitleFont}];
        subtitleH = subtitleS.height;
        
        
        subtitleY = CGRectGetMaxY(_imgIconF)-subtitleS.height-5;
        
        //subtitleY =CGRectGetMaxY(_imgIconF)-subtitleS.height-5;
    }
    else
    {
        
        subtitleH = subtitleS.height;
        //判断如果是iphone6 plus的话  为了适配需要坐下处理
        if(subtitleS.height>20)
        {
            //说明是多行显示
            subtitleY = CGRectGetMaxY(_imgIconF)-subtitleS.height-5;
        }
        else
        {
            subtitleY = CGRectGetMaxY(_imgIconF)-subtitleS.height-18;
        }
        
        
    }
    
    _subtitleF = CGRectMake(subtitleX, subtitleY, maxWidth, subtitleH);
    
    //设置回复按钮
    NSString *replyStr = self.newsModel.replyCount ;
    
    CGSize replyS = [replyStr sizeWithAttributes:@{NSFontAttributeName:replyFont}];
    CGFloat replyW = replyS.width+10;
    CGFloat replyX = ScreenWidth-replyW-marginLeft;
    CGFloat replyY = CGRectGetMaxY(_imgIconF)-replyS.height;
    _replyF = CGRectMake(replyX, replyY, replyW, replyS.height);
    
    //单元格的高度
    _cellH = 80;
    
}
@end
