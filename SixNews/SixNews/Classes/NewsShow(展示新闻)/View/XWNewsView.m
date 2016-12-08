//
//  XWNewsView.m
//  SixNews
//
//  Created by Dy on 15/12/3.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWNewsView.h"
#import "XWBaseMethod.h"
@implementation XWNewsView

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

    //创建标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = titleFont;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    //创建子标题
    UILabel *subtitleLabel = [[UILabel alloc]init];
    subtitleLabel.font = subtitleFont;
    subtitleLabel.numberOfLines = 0;
    subtitleLabel.textColor = [UIColor grayColor];
    [self addSubview:subtitleLabel];
    self.subtitleLabel = subtitleLabel;
    //创建图片
    UIImageView *img = [[UIImageView alloc]init];
    [self addSubview:img];
    self.img = img;
    //创建第二张图片
    UIImageView *otherImg1 = [[UIImageView alloc]init];
    // otherImg1.hidden=YES;
    [self addSubview:otherImg1];
    self.otherImg1 = otherImg1;
    //创建第三张图片
    UIImageView *otherImg2 = [[UIImageView alloc]init];
    // otherImg2.hidden=YES;
    [self addSubview:otherImg2];
    self.otherImg2 = otherImg2;
    //创建回复按钮
    UIButton *replyBtn = [[UIButton alloc]init];
    [replyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [replyBtn setBackgroundImage:[UIImage resizedImage:@"night_contentcell_comment_border"] forState:UIControlStateNormal];
    replyBtn.titleLabel.font = replyFont;
    replyBtn.userInteractionEnabled = NO;
    [self addSubview:replyBtn];
    self.replyBtn = replyBtn;
    //下滑线
    UILabel *bottomLine = [[UILabel alloc]init];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomLine];
    self.bottomLine = bottomLine;
    

}

-(void)setFrameModel:(XWNewsFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    if (frameModel.newsModel.hasHead && frameModel.newsModel.photosetID)
    {
        //如果有多张图片的  多张显示  没有的常态显示
        if(frameModel.newsModel.imgextra.count)
        {
          
            [self imgextra];
        
        }
        else
        {
            
            [self normalShow];
        
        }
    }
    else if (frameModel.newsModel.hasHead)
    {
     
        if(frameModel.newsModel.imgextra.count)
        {
        
            [self imgextra];
        
        }
        else
        {
            
            [self normalShow];
        
        }
    }
    else if(frameModel.newsModel.imgType)
    {
        //如果是现实一张图片
        [self imgType];
        
    }
    else if (frameModel.newsModel.imgextra)
    {
        //多张图片显示
        [self imgextra];
        
    }
    else
    {
        //正常状态下显示
        
        [self normalShow];
    
    }

}

#pragma mark 如果是一张大图片的时候
-(void)imgType;
{
  
    self.frame = self.frameModel.newsViewF;
    self.titleLabel.text = self.frameModel.newsModel.title;
    self.titleLabel.frame = self.frameModel.titleF;

    [XWBaseMethod loadImageWithImg:self.img url:self.frameModel.newsModel.imgsrc];
    self.img.frame = self.frameModel.imgIconF;

    self.subtitleLabel.text = self.frameModel.newsModel.digest;
    self.subtitleLabel.frame = self.frameModel.subtitleF;
  
    self.otherImg1.frame = self.frameModel.otherImg1F;
    self.otherImg2.frame = self.frameModel.otherImg2F;

    self.replyBtn.frame = self.frameModel.replyF;
 
    self.bottomLine.frame = CGRectMake(0, self.height-0.3, ScreenWidth, 0.3);
}
#pragma mark 如果是多张图片显示
-(void)imgextra
{

    self.frame = self.frameModel.newsViewF;
    self.titleLabel.text = self.frameModel.newsModel.title;
    self.titleLabel.frame = self.frameModel.titleF;

    [XWBaseMethod loadImageWithImg:self.img url:self.frameModel.newsModel.imgsrc];
    self.img.frame = self.frameModel.imgIconF;
    
    self.subtitleLabel.text = self.frameModel.newsModel.subtitle;
    self.subtitleLabel.frame = self.frameModel.subtitleF;

    [XWBaseMethod loadImageWithImg:self.otherImg1 url:self.frameModel.newsModel.imgextra[0][@"imgsrc"]];
    self.otherImg1.frame = self.frameModel.otherImg1F;
    

    [XWBaseMethod loadImageWithImg:self.otherImg2 url:self.frameModel.newsModel.imgextra[1][@"imgsrc"]];
    self.otherImg2.frame = self.frameModel.otherImg2F;
    

    [self.replyBtn setTitle:self.frameModel.newsModel.replyCount  forState:UIControlStateNormal];
    self.replyBtn.frame = self.frameModel.replyF;
 
    self.bottomLine.frame = CGRectMake(0, self.height-0.3, ScreenWidth, 0.3);
}

#pragma mark 正常状态下显示
-(void )normalShow
{
   
    self.frame = self.frameModel.newsViewF;
    self.titleLabel.text = self.frameModel.newsModel.title;
    self.titleLabel.frame = self.frameModel.titleF;
 
    [XWBaseMethod loadImageWithImg:self.img url:self.frameModel.newsModel.imgsrc];
    self.img.frame = self.frameModel.imgIconF;
 
    if(self.frameModel.newsModel.pixel || self.frameModel.subtitleF.size.height>30)
    {
    
        self.subtitleLabel.text = self.frameModel.newsModel.ptime;
    
    }
    else
    {
        
        self.subtitleLabel.text = self.frameModel.newsModel.digest;
    
    }
    
    
    self.subtitleLabel.frame = self.frameModel.subtitleF;
   
    [self.replyBtn setTitle:self.frameModel.newsModel.replyCount forState:UIControlStateNormal];
    self.replyBtn.frame = self.frameModel.replyF;
 
    self.otherImg1.frame = self.frameModel.otherImg1F;
    self.otherImg2.frame = self.frameModel.otherImg2F;
 
    self.bottomLine.frame = CGRectMake(0, self.height-0.3, ScreenWidth, 0.3);
}

@end
