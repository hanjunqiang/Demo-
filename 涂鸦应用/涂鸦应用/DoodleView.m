//
//  DoodleView.m
//  涂鸦应用
//
//  Created by 韩军强 on 15/9/26.
//  Copyright (c) 2015年 韩军强. All rights reserved.
//

#import "DoodleView.h"

@implementation DoodleView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _lineArray=[[NSMutableArray alloc]init];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame=CGRectMake(100, 420, 120, 40);
        [btn setTitle:@"撤销" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(undoDraw) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
      
    }
    return self;
}

//撤销操作
-(void)undoDraw
{
    [_lineArray removeLastObject];
    
    [self setNeedsDisplay];     //让view进行一次重绘操作 ，会自动调用UIView的drawRect方法
}

//每次手指开始触摸时，增加一个新的数组。数组记录划过的点。
//利用这些点进行绘画
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_lineArray addObject:[NSMutableArray arrayWithCapacity:1]];//每次触摸的时候都初始化一个数组存这1个接触点。
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    //数组里需要id类型
    NSValue *value=[NSValue valueWithCGPoint:point];
    //把value装到_lineArray的最后一个元素（数组）里。
    [[_lineArray lastObject]addObject:value];
    [self setNeedsDisplay];     //调用此方法会调用drawRect方法
}

-(void)drawRect:(CGRect)rect
{
    //获取上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //设置画笔的颜色
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);//这里是一个函数，因为它要求的是CGColor
    
    for (int i=0; i<[_lineArray count]; i++)
    {
        NSMutableArray *pointArray=[[NSMutableArray alloc]initWithArray:[_lineArray objectAtIndex:i]];
        for (int j=0; j<[pointArray count]-1; j++)
        {
            //遍历所有的点
            NSValue *a=[pointArray objectAtIndex:j];
            CGPoint p1=[a CGPointValue];
            
            NSValue *b=[pointArray objectAtIndex:j+1];
            CGPoint p2=[b CGPointValue];
            
            CGContextMoveToPoint(context, p1.x, p1.y);
            CGContextAddLineToPoint(context, p2.x, p2.y);
        }
    }
    // 在当前的图形上下文中。根据画笔的颜色和画笔的路径进行绘制
    CGContextStrokePath(context);
}
@end
