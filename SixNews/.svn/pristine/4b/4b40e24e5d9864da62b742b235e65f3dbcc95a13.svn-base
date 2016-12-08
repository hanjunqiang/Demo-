//
//  XWSettingView.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWSettingView.h"
#import "XWArrowItem.h"
#define imgW 30
#define imgH imgW
#define marginLeft 5 //图片距离左边的距离

#define arrowW 15 //尖括号的宽度10
#define arrowH 15 //夹括号的高度 15


//显示多少缓存的label的宽度
#define  asseoryLabelW 100
#define  asseoryLabelH 30

//复选框的宽 高

#define checkBoxW 30
#define checkBoxH checkBoxW

@interface XWSettingView ()

@property (nonatomic,weak) UIImageView *img; //图片
@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UILabel *accessoryLabel; //标签附件
@property (nonatomic,weak) UIImageView *arrow; //尖括号
@property (nonatomic,weak) UISwitch *switchView; //开关控件
@property (nonatomic,weak) UIButton *box; //选中按钮
@property (nonatomic,weak) UIButton *btn;

@end


@implementation XWSettingView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self )
    {
        //1.添加子控件
        [self setupChild];
    }
    return self;
}

#pragma mark 添加子控件
-(void)setupChild
{
    //1.创建图片
    UIImageView *img = [[UIImageView alloc]init];
    [self addSubview:img];
    self.img = img;
    //2.创建标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    //3.添加间括号
    UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"settings_list_arrow"]];
    arrow.hidden = YES;
    [self addSubview:arrow];
    self.arrow = arrow;
    //4.添加标签附件
    UILabel *accessoryLabel=[[UILabel alloc]init];
    accessoryLabel.hidden=YES;
    accessoryLabel.textAlignment=NSTextAlignmentRight;
    accessoryLabel.font=[UIFont systemFontOfSize:15];
    [self addSubview:accessoryLabel];
    self.accessoryLabel=accessoryLabel;
    //5.添加开关控件
    UISwitch *switchView=[[UISwitch alloc]init];
    [switchView addTarget:self action:@selector( statusChange:) forControlEvents:UIControlEventValueChanged];
    switchView.hidden=YES;
    [self addSubview:switchView];
    switchView.onTintColor=[UIColor redColor];
    self.switchView=switchView;
    //6.选中按钮状态
    UIButton *box=[[UIButton alloc]init];
    box.userInteractionEnabled=NO;
    [box setImage:[UIImage imageNamed:@"text_page_tool_bar_off_new"] forState:UIControlStateNormal];
    [box setImage:[UIImage imageNamed:@"text_page_tool_bar_on_new"] forState:UIControlStateSelected];
    box.hidden=YES;
    [self addSubview:box];
    self.box=box;

}
-(void)statusChange:(UISwitch *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.switchView.isOn forKey:self.item.title];
}
//传递模型
-(void)setItem:(XWCellItem *)item
{
    _item = item;
    [self addSubview:self.arrow];
    
    CGFloat titleX = 0;
    //1.设置图片 的值 frame
    if(item.icon){
        CGFloat imageX=marginLeft;
        CGFloat imageY=(self.height-imgH)*0.5;
        self.img.frame=CGRectMake(imageX, imageY, imgW, imgH);
        self.img.image=[UIImage imageNamed:item.icon];
        
        //获取title的x
        titleX=CGRectGetMaxX(self.img.frame)+marginLeft;
    }else{
        titleX=CGRectGetMaxX(self.img.frame)+marginLeft*2;
    }
    //2.设置title
    
    CGSize titleSize=[item.title  sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    CGFloat titleW=titleSize.width+10;
    CGFloat titleY=(self.height-titleSize.height)*0.5;
    self.titleLabel.frame=CGRectMake(titleX, titleY, titleW, titleSize.height);
    self.titleLabel.text=item.title;
    
    [self setAsseory];

}
-(void)setAsseory
{
    //判断模型类型 来确定右边显示什么控件
    if([self.item isKindOfClass:[XWArrowItem class]]){
        CGFloat arrowX=self.width-arrowW-marginLeft*2;
        CGFloat arrowY=(self.height-arrowH)*0.5;
        self.arrow.frame=CGRectMake(arrowX, arrowY, arrowW, arrowH);
        self.arrow.hidden=NO;
        
        
    }else if([self.item isKindOfClass:[XWSwitchItem class] ]){
        CGFloat switchX=self.width-self.switchView.width-marginLeft*2;
        CGFloat switchY=(self.height-self.switchView.height)*0.5;
        self.switchView.x=switchX;
        self.switchView.y=switchY;
        self.switchView.hidden=NO;
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        self.switchView.on=[defaults boolForKey:self.item.title];
        
    }else if([self.item isKindOfClass:[XWBosItem class]]){
        CGFloat boxX=self.width-checkBoxW-marginLeft*2;
        CGFloat boxY=(self.height-checkBoxH)*0.5;
        self.box.frame=CGRectMake(boxX, boxY, checkBoxW, checkBoxH);
        self.box.hidden=NO;
        //如果有复选框按钮 监听通知
        [XWNotification addObserver:self selector:@selector(buttonChange:) name:checkBoxName object:nil];
        
    }else if([self.item isKindOfClass:[XWLabelItem class]]){
        
        XWLabelItem *tm=(XWLabelItem*)self.item;
        CGFloat labelX=(self.width-asseoryLabelW)-marginLeft*4;
        CGFloat labelY=(self.height-asseoryLabelH)*0.5;
        self.accessoryLabel.text=tm.cacheSize;
        self.accessoryLabel.hidden=NO;
        self.accessoryLabel.frame=CGRectMake(labelX, labelY, asseoryLabelW, asseoryLabelH);
        //如果是清空缓存的话  监听通知
        [XWNotification addObserver:self selector:@selector(cleaData) name:clearDataName object:nil];
    }
}
-(void)cleaData
{
    self.accessoryLabel.text=@"0.0M";
}

//改变复选框按钮选中状态
-(void)buttonChange:(NSNotification*)note
{
    self.box.selected=!self.box.isSelected;
    
}

-(void)dealloc
{
    [XWNotification removeObserver:self name:checkBoxName object:nil];
    [XWNotification removeObserver:self name:clearDataName object:nil];
}


@end
