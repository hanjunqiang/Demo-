//
//  XWDownloadView.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWDownloadView.h"

#define closeBtnW  20
#define closeBtnH  20

@implementation XWDownloadView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        //1.添加子view
        [self setupView];
        
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
#pragma mark 添加子view
-(void)setupView
{
    //1.添加进度条
    ASProgressPopUpView *progressView=[[ASProgressPopUpView alloc]init];
    
    
    self.progressView=progressView;
    self.progressView.textColor=XWColorRGBA(124, 122, 122, 0.8);
    self.progressView.popUpViewAnimatedColors = @[[UIColor whiteColor], [UIColor whiteColor], [UIColor whiteColor]];
    [self.progressView showPopUpViewAnimated:YES];
    //2.添加按钮关闭
    UIButton *closeBtn=[[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"night_right_navigation_close@3x 2"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    self.closeBtn=closeBtn;
    self.closeBtn.selected=NO;
    
    [self insertSubview:self.progressView aboveSubview:closeBtn];
    
}
//按钮的点击
-(void)closeBtnClick:(UIButton*)sender
{
    self.closeBtn.selected=!self.closeBtn.isSelected;
    [self progress];
    if([self.delegate respondsToSelector:@selector(downloadView:)]){
        [self.delegate downloadView:self];
    }
}

//开始下载
-(void)beginProgress
{
    [self progress];
}


- (void)progress
{
    
    float progress = self.progressView.progress;
    if (!self.closeBtn.selected && progress < 1.0) {
        
        progress += 0.0005 ;
        
        [self.progressView setProgress:progress animated:YES];
        [self.progressView setProgress:progress animated:YES];
//
        //添加一个定制器
        NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval: 0.01
                                                        target:self
                                                      selector:@selector(progress)
                                                      userInfo:nil
                                                       repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
else if(progress>=1.0)
{   //下载完了
        NSNotification *note=[[NSNotification alloc]initWithName:downdidFinishName object:nil userInfo:nil];
        [XWNotification postNotification:note];  //发送通知
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.progressView.width=self.width;
    
    self.progressView.x=0;
    self.progressView.y=self.height-10;
    
    CGFloat btnX=self.width-closeBtnW;
    CGFloat btnY=15;
    self.closeBtn.frame=CGRectMake(btnX, btnY, closeBtnW, closeBtnH);
}



@end
