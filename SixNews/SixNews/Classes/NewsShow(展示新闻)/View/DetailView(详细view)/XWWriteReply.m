//
//  XWWriteReply.m
//  SixNews
//
//  Created by Dy on 15/12/2.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWWriteReply.h"

@implementation XWWriteReply
-(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame])
    {
    
    self.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    
    self.width = self.frame.size.width;
    self.height = 120;
    
        [self addSubviews];
    
    }
    

    return self;
}

//添加子控件

-(void)addSubviews
{

//    返回按钮
    UIButton *cancel =[self createButton:@"" disabeColor:nil];
    cancel.tag = CancelButton;
    cancel.frame = CGRectMake(10, 10, 40, 25);
    [cancel addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    发送按钮
    
    UIButton *send = [self createButton:@"发送" disabeColor:[UIColor lightGrayColor]];
    
    
    send.tag = SendButton;
    
    send.frame = CGRectMake(self.width-40, 10, 40, 25);
    
    [send addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.send = send;
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"写跟帖";
    title.font = [UIFont systemFontOfSize:18];
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.frame = CGRectMake((self.width-100)*0.5, 5, 100, 30);
    
    [self addSubview:title];
    
    self.title = title;
    
    UILabel *tip = [[UILabel alloc]initWithFrame:CGRectMake((self.width-150)*0.5, 5, 150, 30)];
    tip.hidden = YES;
    tip.text = @"再写几句吧！";
    tip.font = [UIFont systemFontOfSize:15];
    tip.textColor = [UIColor redColor];
    tip.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tip];
    self.tip = tip;
    
    
    UITextView *input = [[UITextView alloc]initWithFrame:CGRectMake(10, 40, self.width-20, 60)];
    input.font = [UIFont systemFontOfSize:15];
    input.textColor = [UIColor blackColor];
    [self addSubview:input];
    self.inputText = input;
    
    

}


-(UIButton*)createButton:(NSString*)title  disabeColor:(UIColor*)color
{
    UIButton *btn=[[UIButton alloc]init];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateDisabled];
    [self addSubview:btn];
    return btn;
}
//取消按钮点击的方法
-(void)buttonClick:(UIButton*)sender
{
    if([self.delegate respondsToSelector:@selector(writeReply:ybuttonType:)]){
        [self.delegate writeReply:self buttonType:sender.tag];
    }
}

@end
