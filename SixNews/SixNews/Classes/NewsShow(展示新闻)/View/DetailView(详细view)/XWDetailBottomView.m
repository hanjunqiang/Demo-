//
//  XWDetailBottomView.m
//  SixNews
//
//  Created by Dy on 15/12/2.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWDetailBottomView.h"

@implementation XWDetailBottomView


-(NSMutableArray *)buttons
{

    if (_buttons == nil)
    {
        _buttons = [NSMutableArray array];
    }
    

    return _buttons;
}
-(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame])
    {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubviews];
        
    }


    return self;
    
}

-(void)addSubviews
{

    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 0.4)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    
    
    //添加评论按钮
    [self addCommentBtn];
    //添加转发按钮
    [self addButtonWithImage:@"icon_share"  selectedImage:nil tag:DetailShareType];
    [self addButtonWithImage:@"icon_bottom_star"  selectedImage:@"icon_star_full" tag:DetailLikeType];
    
    
    

}
//添加评论按钮
-(void)addCommentBtn
{
    UIButton *btn=[[UIButton alloc]init];
    btn.tag=DetailCommentType;
    [btn setTitle:@"写跟帖" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    btn.contentMode=UIViewContentModeLeft;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"night_video_comment_pen"] forState:UIControlStateNormal];
    btn.contentEdgeInsets=UIEdgeInsetsMake(0, 12, 0, 0);
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    // 设置高亮的时候不要让图标变色
    btn.adjustsImageWhenHighlighted = NO;
    
    // 设置按钮的内容左对齐
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [btn setBackgroundImage:[UIImage resizedImage:@"duanzi_button_normal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizedImage:@"night_choose_city_highlight"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    self.btn=btn;
}

-(void)addButtonWithImage:(NSString*)image  selectedImage:(NSString*)selectedImage tag:(DetailButtonType)tag
{
    
    UIButton *btn=[[UIButton alloc]init];
    btn.tag=tag;
    [btn setImage:[UIImage resizedImage:image] forState:UIControlStateNormal];
    if(selectedImage.length>0){
        [btn setImage:[UIImage resizedImage:selectedImage] forState:UIControlStateSelected];;
    }
    [self addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons addObject:btn];
}

#pragma mark 按钮的点击时间
-(void)btnClick:(UIButton*)sender
{
    int tag=(int)sender.tag;
    switch (tag) {
        case DetailCommentType:
        case DetailShareType:
        {
            //代理
            if([self.delegate respondsToSelector:@selector(detailBottom:tag:)]){
                [self.delegate detailBottom:self tag:sender.tag];
            }
        }
            break;
            
            
            
        case DetailLikeType:
        {
            sender.selected=!sender.isSelected;
            NSLog(@"保存");
        }
            break;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //布局跟帖按钮
    CGFloat commentX=10;
    CGFloat commentY=5;
    CGFloat commentH=self.height-10;
    CGFloat commentW=self.width*0.7;
    self.btn.frame=CGRectMake(commentX, commentY, commentW, commentH);
    
    CGFloat shareX=commentW+20;
    CGFloat shareY=5;
    CGFloat shareW=30;
    CGFloat shareH=30;
    UIButton *button1=self.buttons[0];
    button1.frame=CGRectMake(shareX, shareY, shareW, shareH);
    
    CGFloat saveW=30;
    CGFloat saveH=30;
    CGFloat saveX=CGRectGetMaxX(button1.frame)+10;
    CGFloat saveY=5;
    UIButton *button2=self.buttons[1];
    button2.frame=CGRectMake(saveX, saveY, saveW, saveH);
}


@end
