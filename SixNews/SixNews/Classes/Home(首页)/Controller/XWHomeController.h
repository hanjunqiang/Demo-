//
//  XWHomeController.h
//  SixNews
//
//  Created by Dy on 15/12/6.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXTitleLable.h"
#import "XWNewsShowController.h"

//上面滑动栏的高度
#define smallScrollMenuH  40
@interface XWHomeController : UIViewController<UIScrollViewDelegate>
//大的滑动视图
@property (nonatomic,weak) UIScrollView *bigScroll;
//小的滑动视图
@property (nonatomic,weak) UIScrollView *smallScroll;

@property(nonatomic,strong) SXTitleLable *oldTitleLable;
@property (nonatomic,assign) CGFloat beginOffsetX;

/** 新闻接口的数组 */
@property(nonatomic,strong) NSArray *arrayLists;


@end
