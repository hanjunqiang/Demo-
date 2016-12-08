//
//  XWTopMenu.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWTopMenu.h"
#import "XWTopMenuBtn.h"

@interface XWTopMenu ()

@property (nonatomic,strong) NSMutableArray *btnArr; //存放按钮的数组
@property (nonatomic,strong) NSMutableArray *lineArr; //存放下滑线的数组

@end


@implementation XWTopMenu

-(NSMutableArray *)btnArr
{
    if(_btnArr==nil) {
        _btnArr=[NSMutableArray array];
    }
    return _btnArr;
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
//添加按钮
-(void)setupButton
{
    //1.阅读按钮
    [self addButtonWithTitle:@"阅读" image:@"icon_right_books" highImage:@"icon_right_books_pressed" buttonTag:topMenuRead];
    //2.评论按钮
    [self addButtonWithTitle:@"评论" image:@"icon_right_comment" highImage:@"icon_right_comment_pressed"  buttonTag:topMenuComment];
    //3.收藏按钮
    [self addButtonWithTitle:@"收藏" image:@"right_navigation_collect_new" highImage:@"right_navigation_collect_new_pressed"  buttonTag:topMenuCollect];
    //4.创建下滑线
    [self setupBottomLine];
    
}


-(XWTopMenuBtn*)addButtonWithTitle:(NSString*)title image:(NSString*)image highImage:(NSString*)highImage  buttonTag:(topMenuType)buttonTag
{
    XWTopMenuBtn *button=[[XWTopMenuBtn alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.tag=buttonTag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [self.btnArr addObject:button];
    return button;
}

#pragma mark 按钮的点击事件
-(void)buttonClick:(UIButton*)sender
{
    if([self.delegete respondsToSelector:@selector(topMenu:menuType:)])
    {
        [self.delegete topMenu:self menuType:sender.tag];
    }
}

#pragma mark 创建下划线
-(void)setupBottomLine
{
    int count=(int)self.btnArr.count-1;
    for(int i=0;i<count;i++) {
        UIImageView *line=[[UIImageView alloc]initWithImage:[UIImage resizedImage:@"search_btn_line"]];
        
        [self addSubview:line];
        [self.lineArr addObject:line];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count=self.btnArr.count;
    CGFloat btnW=self.width/count;
    CGFloat btnH=self.height;
    CGFloat btnY=0;
    CGFloat btnX=0;
    for(int i=0;i<count;i++){
        XWTopMenuBtn *btn=self.btnArr[i];
        btnX=btnW*i;
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
    }
//    设置下滑线的frame
    CGFloat lineW=0.5;
    CGFloat lineY=5;
    CGFloat lineH=self.height-lineY;
    
    CGFloat lineX=0;
    for(int i=0;i<self.lineArr.count;i++) {
        UIImageView *line=self.lineArr[i];
        lineX=btnW*(i+1);
        line.frame=CGRectMake(lineX, lineY, lineW, lineH);
    }
    
}


@end
