//
//  XWLeftMenu.m
//  新闻
//
//  Created by 张声扬 on 15/12/1.
//  Copyright (c) 2015年 张声扬 All rights reserved.
//

#import "XWLeftMenu.h"
#import "XELeftButton.h"

@interface XWLeftMenu ()

@property (nonatomic,weak) XELeftButton *selectedButton;
//存放按钮的数组
@property (nonatomic,strong) NSMutableArray *buttonArr;
//存放>的数组
@property (nonatomic,strong) NSMutableArray *arrowArr;
//背景滚动视图
@property (nonatomic,weak)  UIScrollView *backgroundScroll;

@end

@implementation XWLeftMenu

-(NSMutableArray *)buttonArr
{
    if(_buttonArr==nil){
        _buttonArr=[NSMutableArray array];
    }
    return _buttonArr;
}
-(NSMutableArray *)arrowArr
{
    if(_arrowArr==nil){
        _arrowArr=[NSMutableArray array];
    }
    return _arrowArr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
       
        //添加背景滚动图
        [self setupScrollView];
        CGFloat alpha=0.4;
        
        [self setupBtnWithIcon:@"sidebar_nav_news" title:@"新闻" bgColor:XWColorRGBA(202, 68, 73, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_reading" title:@"订阅" bgColor:XWColorRGBA(190, 111, 69, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_photo" title:@"图片" bgColor:XWColorRGBA(76, 132, 190, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_video" title:@"视频" bgColor:XWColorRGBA(101, 170, 78, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_comment" title:@"跟帖" bgColor:XWColorRGBA(170, 172, 73, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_radio" title:@"电台" bgColor:XWColorRGBA(190, 62, 119, alpha)];
    }
    return self;
}

#pragma mark 添加背景滚动图
-(void)setupScrollView
{
    UIScrollView *backgroundScroll=[[UIScrollView alloc]init];
    backgroundScroll.showsHorizontalScrollIndicator=NO;
    backgroundScroll.showsVerticalScrollIndicator=NO;
    backgroundScroll.contentSize=CGSizeMake(self.width, ScreenHeight+0.5); //滚动的范围
    [self addSubview:backgroundScroll];
    self.backgroundScroll=backgroundScroll;
   
}

- (UIButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title bgColor:(UIColor *)bgColor
{
    
    //1、创建按钮
    XELeftButton *btn = [[XELeftButton alloc] init];

    btn.tag = self.subviews.count;
    
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
   
    [self.backgroundScroll addSubview:btn];
    
    // 设置图片和文字
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置按钮选中的背景
    [btn setBackgroundImage:[UIImage imageWithColor:bgColor] forState:UIControlStateSelected];
    
    // 设置高亮的时候不要让图标变色
    btn.adjustsImageWhenHighlighted = NO;
    
    // 设置按钮的内容左对齐
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    
    // 设置间距
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    btn.contentEdgeInsets=UIEdgeInsetsMake(0, 30, 0, 0);
    //在按钮右边添加一个>号
    UIImageView *arrow=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"top_navigation_back_photo"]];
    [btn addSubview:arrow];
    [self.arrowArr addObject:arrow];
    //把按钮存放到数组中
    [self.buttonArr addObject:btn];
    //如果是第一个按钮默认选中
    if(self.buttonArr.count==1){
        [self buttonClick:btn];
    }
    return btn;
}

#pragma mark 按钮的点击事件
-(void)buttonClick:(XELeftButton*)sender
{
    if([self.delegate respondsToSelector:@selector(leftMenu:didSelectedFrom:to:)]){
        [self.delegate leftMenu:self didSelectedFrom:self.selectedButton.tag to:sender.tag];
    }
    self.selectedButton.selected=NO;
    sender.selected=YES;
    self.selectedButton=sender;
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];
    //1.设置背景滚动视图的frame
    self.backgroundScroll.frame=self.bounds;
    //2.设置按钮的frame   按钮上面>的frame
    int btnCount = (int)self.buttonArr.count;
    CGFloat btnW = self.width;
    //self.height / btnCount;
    CGFloat btnH = 0;
    if(iPhone6 || iPhone6P || iPhone5){
        btnH=60;
    }else{
        btnH=50;
    }
    //箭头的宽
    CGFloat arrowW= 30;
    //箭头哦的高
    CGFloat arrowH=arrowW;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.buttonArr[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = i * btnH+LeftMenuButtonY;
        //传递tag给button
        btn.tag=i;
        UIImageView *arrow=self.arrowArr[i];
        CGFloat arrowX=btn.width-arrowW-10;
        CGFloat arrowY=(btn.height-arrowH)*0.5;
        arrow.frame=CGRectMake(arrowX, arrowY, arrowW, arrowH);
    }
    
    
}

@end
