//
//  XWCentreView.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWCentreView.h"
#import "XWDownloadView.h"

@interface XWCentreView ()<XWDownloadViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) NSMutableArray *btnArr; //存放按钮的数组
@property (nonatomic,strong) NSMutableArray *smallBtnArr; //存放小按钮的数组
@property (nonatomic,strong) NSMutableArray *lineArr; //存放一条线的数组

@property (nonatomic,weak) XWDownloadView *downloadView; //下载视图

@property (nonatomic,weak) UIButton *downBtn;

@end


@implementation XWCentreView

-(NSMutableArray *)btnArr
{
    if(_btnArr==nil) {
        _btnArr=[NSMutableArray array];
    }
    return _btnArr;
}
-(NSMutableArray *)smallBtnArr
{
    if(_smallBtnArr==nil){
        _smallBtnArr=[NSMutableArray array];
    }
    return _smallBtnArr;
}
-(NSMutableArray *)lineArr
{
    if(_lineArr==nil){
        _lineArr=[NSMutableArray array];
    }
    return _lineArr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        //1.添加按钮
        [self setupButton];
    }
    return self;
}

#pragma mark 添加按钮
-(void)setupButton
{
    //1.离线下载按钮
    [self addButtonWithTitle:@"离线下载" image:@"right_navigation_download_new" rightPic:@"right_navigation_more_new" buttonTag:buttonTypeDownload];
    //2.推送消息
    [self addButtonWithTitle:@"推送消息" image:@"right_navigation_push_new" rightPic:@"right_navigation_more_new" buttonTag:buttonTypePush];
    //3.媒体影响力
    [self addButtonWithTitle:@"媒体影响力" image:@"right_navigation_medialist" rightPic:nil buttonTag:buttonTypeMedia];
    //4.记者影响力
    [self addButtonWithTitle:@"记者影响力" image:@"icon_reporter_list" rightPic:@"btn_entrance_reporter" buttonTag:buttonTypeReporter];
    //5.意见反馈
    [self addButtonWithTitle:@"意见反馈" image:@"right_navigation_feedback_new" rightPic:nil buttonTag:buttonTypeFeedback];
    
    //6.添加下载视图view
    [self setupDownload];
    //7.监听下载完的通知
    [XWNotification addObserver:self selector:@selector(downDidFinish) name:downdidFinishName object:nil];
    
}
-(void)setupDownload
{
    XWDownloadView *downloadV=[[XWDownloadView alloc]init];
    [self addSubview:downloadV];
    self.downloadView=downloadV;
    downloadV.delegate=self;
    downloadV.hidden=YES;
}

-(void)addButtonWithTitle:(NSString*)title image:(NSString*)image  rightPic:(NSString*)pic buttonTag:(buttonType)buttonTag
{
    //1.添加按钮
    UIButton *btn=[[UIButton alloc]init];
    btn.tag=buttonTag; //按钮的tag
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted=NO;
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    //设置按钮内容距离左边的间距
    btn.contentEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    // 设置按钮的内容左对齐
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [btn setBackgroundImage:[UIImage imageWithColor:XWColorRGBA(255, 255, 255, 0.3)] forState:UIControlStateHighlighted];
    //添加按钮点击事件
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    //如果有附件图片 添加到按钮上
    UIButton *smallBtn=[[UIButton alloc]init];
    if(pic){
        
        smallBtn.userInteractionEnabled=NO;
        smallBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0,0);
        [smallBtn setImage:[UIImage imageNamed:pic] forState:UIControlStateNormal];
        smallBtn.autoresizingMask=UIViewAutoresizingFlexibleRightMargin;
        CGFloat smallW=smallBtn.currentImage.size.width;
        CGFloat smallH=smallBtn.currentImage.size.height;
        smallBtn.width=smallW;
        smallBtn.height=smallH;
        //如果是个认证的按钮 打标记
        if([pic isEqualToString:@"btn_entrance_reporter"]){
            smallBtn.tag=11;
        }
        [btn addSubview:smallBtn];
        
    }else{
        smallBtn.hidden=YES;
    }
    [self.smallBtnArr addObject:smallBtn]; //添加小按钮到数组
    
    
    [self addSubview:btn];
    [self.btnArr addObject:btn];
    //2.添加下滑线
    UIImageView *line=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right_navigation_line_new"]];
    [self addSubview:line];
    [self.lineArr addObject:line];//添加线到数组中
}

#pragma mark 按钮的点击事件
-(void)buttonClick:(UIButton*)sender
{
    if([self.delegate respondsToSelector:@selector(centreView:centreTag:)])
    {
        [self.delegate centreView:self centreTag:sender.tag];
    }
}

#pragma mark 离线下载点击的时候调用的方法
-(void)downloadWithTag:(buttonType)tag
{
    
    UIButton *btn=self.btnArr[0]; //取出第一个按钮
    self.downBtn=btn;
    btn.hidden=YES;
    self.downloadView.hidden=NO;
    self.downloadView.closeBtn.selected=NO;
    [self.downloadView beginProgress];
    
}
#pragma mark 监听下载完的通知
-(void)downDidFinish
{
    self.downloadView.progressView.progress=0.0;
    self.downloadView.hidden=YES;
    self.downBtn.hidden=NO;
    
}

#pragma mark 下载view的代理方法

-(void)downloadView:(XWDownloadView *)downloadView
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"你确定要取消下载?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:  //取消下载
        {
            self.downloadView.hidden=YES;
            self.downBtn.hidden=NO;
            self.downloadView.progressView.progress=0.0; //清空
        }
            break;
        case 0: //继续下载
        {
            self.downloadView.closeBtn.selected=NO;
            [self.downloadView beginProgress];
            
        }
            break;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count=self.btnArr.count;
    CGFloat btnH=self.height/count;
    CGFloat btnW=self.width;
    CGFloat btnX=0;
    CGFloat btnY=0;
    //设置下载视图的位置
    self.downloadView.frame=CGRectMake(0, 0, self.width, btnH);
    //下划线的x y w h
    CGFloat lineX=0;
    CGFloat lineY=0;
    CGFloat lineW=self.width;
    CGFloat lineH=0.5;
    
    for(int i=0;i<count;i++) {
        UIButton *btn=self.btnArr[i];
        btnY=btnH*i;
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
    
//        2.判断如果按钮有子控件  有的话 设置frame
        UIButton *smallBtn=self.smallBtnArr[i];
        if(smallBtn.hidden==NO){
            CGFloat smallX=0;
            if(smallBtn.tag==11){  //说明是认证按钮
                smallX =(self.width-smallBtn.width)-5; //认证按钮的x
            }else{
                smallX=(self.width-smallBtn.width)-20;
            }
            
            CGFloat smallY=(btn.height-smallBtn.height)*0.5;
            smallBtn.x=smallX;
            smallBtn.y=smallY;
        }
    
        //3.设置下滑线的frame
        UIImageView *line=self.lineArr[i];
        lineY=i*btnH;
        line.frame=CGRectMake(lineX, lineY, lineW, lineH);
        
    }
    
}

-(void)dealloc
{
    [XWNotification removeObserver:self name:downdidFinishName object:nil];
    }


@end
