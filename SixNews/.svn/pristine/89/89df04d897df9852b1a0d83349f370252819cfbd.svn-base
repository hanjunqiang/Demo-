//
//  XWHeaderView.h
//  SixNews
//
//  Created by Dy on 15/12/3.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWNewsModel.h"
#import "XWHeaderCell.h"

@class XWHeaderView;
@protocol XWHeaderViewDelegate <NSObject>

-(void)headerView:(XWHeaderView*)headerView newsModel:(XWNewsModel*)newsModel;

@end
@interface XWHeaderView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,weak)id <XWHeaderViewDelegate>delegate;
@property (nonatomic,strong)NSMutableArray *arr;

@property (nonatomic,weak) UICollectionView *scrollCollection;
//标题label
@property (nonatomic,weak) UILabel *titleLabel;

@property (nonatomic,weak) UIPageControl *page;
@property (nonatomic,strong) NSTimer *timer;
@end
