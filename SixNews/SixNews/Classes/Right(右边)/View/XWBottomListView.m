//
//  XWBottomListView.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWBottomListView.h"


@interface XWBottomListView ()
@property (nonatomic,strong) NSMutableArray *btnArr; //存放按钮的数组
@property (nonatomic,strong) NSMutableArray *labelArr; //存放label的数组


@property (nonatomic,weak) UIButton *nightButton ;//白天夜间的那妞
@property (nonatomic,weak) UIButton *dayButton ;//白天夜间的那妞

@end

@implementation XWBottomListView

-(NSMutableArray *)btnArr
{
    if(_btnArr==nil) {
        _btnArr=[NSMutableArray array];
    }
    return _btnArr;
}

-(NSMutableArray *)labelArr
{
    if(_labelArr==nil) {
        self.labelArr=[NSMutableArray array];
    }
    return _labelArr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        //1.添加子元素
        [self setupChild];
    }
    return self;
}

#pragma mark 添加子元素
-(void)setupChild
{
    //1.添加有图按钮
    [self addButtonWithTitle:@"无图" image:@"night_right_navigation_no_pic_new" highImage:@"night_right_navigation_no_pic_preesed_new" selectedImage:@"night_right_navigation_have_pic" tag:FootButtonTypePic];
    
    //2.添加夜间按钮
    UIButton  *dayButton=[self addDayButtonWithTitle:@"白天" image:@"night_right_navigation_day_new" highImage:@"night_right_navigation_day_pressed_new" selectedImage:@"right_navigation_night_new" tag:FootButtonTypeNight];
    self.dayButton=dayButton;

      //3.添加白天按钮  默认隐藏
    UIButton *nightButton= [self addButtonWithTitle:@"夜间" image:@"right_navigation_night_new" highImage:@"right_navigation_night_pressed_new" selectedImage:@"night_right_navigation_day_new" tag:FootButtonTypeNight];
    self.nightButton=nightButton;

        //4.添加设置按钮
    [self addButtonWithTitle:@"设置" image:@"right_navigation_setting_new" highImage:@"right_navigation_setting_pressed_new" tag:FootButtonTypeSetting];
}

//添加 有图按钮 夜间按钮
-(UIButton*)addButtonWithTitle:(NSString*)title image:(NSString*)image highImage:(NSString*)highImage selectedImage:(NSString*)selectedImage tag:(FootButtonType)tag
{
    //1.创建按钮
    UIButton *foot=[[UIButton alloc]init];
    foot.tag=tag;
    [foot setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [foot setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [foot setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [self addSubview:foot];
    [self.btnArr addObject:foot];
    //点击事件
    [foot addTarget:self action:@selector(footButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //2.创建label
    UILabel *label=[[UILabel alloc]init];
    label.font=[UIFont systemFontOfSize:14];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.text=title;
    [self addSubview:label];
    [self.labelArr addObject:label];
    return foot;
    
}

//添加无图  白天按钮
-(UIButton*)addDayButtonWithTitle:(NSString*)title image:(NSString*)image highImage:(NSString*)highImage selectedImage:(NSString*)selectedImage tag:(FootButtonType)tag
{
    //1.创建按钮
    UIButton *foot=[[UIButton alloc]init];
    foot.tag=tag;
    [foot setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [foot setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [foot setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [self addSubview:foot];
    foot.hidden=YES;
    //点击事件
    [foot addTarget:self action:@selector(footButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return foot;
    
}

//添加设置按钮
-(void)addButtonWithTitle:(NSString*)title image:(NSString*)image highImage:(NSString*)highImage tag:(FootButtonType)tag
{
    //1 创建设置按钮
    UIButton *foot=[[UIButton alloc]init];
    foot.tag=tag;
    [foot setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [foot setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    [self addSubview:foot];
    [self.btnArr addObject:foot];
    [foot addTarget:self action:@selector(footButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //2.创建label
    UILabel *label=[[UILabel alloc]init];
    label.font=[UIFont systemFontOfSize:14];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.text=title;
    [self addSubview:label];
    [self.labelArr addObject:label];
    
}

#pragma mark 按钮点击事件
-(void)footButtonClick:(UIButton*)sender
{
    switch (sender.tag) {
        case FootButtonTypeNight:
        {
            UILabel *label=self.labelArr[sender.tag];
            if(self.nightButton.hidden){
                self.nightButton.frame=self.dayButton.frame;
                self.nightButton.hidden=NO;
                self.dayButton.hidden=YES;
                
                NSNotification *nont = [[NSNotification alloc]initWithName:dayName object:nil userInfo:nil];
                [XWNotification postNotification:nont];//发送通知


                label.text=@"夜间";
            }else{
                self.dayButton.frame=sender.frame;
                self.dayButton.hidden=NO;
                self.nightButton.hidden=YES;
                NSNotification *nont = [[NSNotification alloc]initWithName:nightName object:nil userInfo:nil];
                [XWNotification postNotification:nont];//发送通知
                
                

                label.text=@"白天";
            }
            
        }
            break;
        case FootButtonTypePic:    //如果是图片按钮 和设置按钮响应代理
        case FootButtonTypeSetting:
        {
            if([self.delegate respondsToSelector:@selector(footView:footTag:)]){
                [self.delegate footView:self footTag:sender.tag];
            }
            
        }
            
            break;
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    int count=(int)self.btnArr.count;
    CGFloat btnW=self.width/count;
    CGFloat btnH=btnW;
    CGFloat btnY=0; //按钮的y
    if(iPhone6P){
        btnY=-10;
    }else if(iPhone6 || iPhone5 || iPhone4){
        btnY=-6;
    }
    
    CGFloat btnX=0;
    
    CGFloat labelW=btnW;
    CGFloat labelH=20;
    CGFloat labelX=0;
    for(int i=0;i<count;i++){
        UIButton *foot=self.btnArr[i];
        btnX=btnW*i;
        foot.frame=CGRectMake(btnX, btnY, btnW, btnH);
//        设置label的frame
        UILabel *label=self.labelArr[i];
        CGFloat labelY=CGRectGetMaxY(foot.frame)-5;
        labelX=labelW*i;
        label.frame=CGRectMake(labelX, labelY, labelW, labelH);
    }
    
}


@end
