
//
//  XWHeaderView.m
//  SixNews
//
//  Created by Dy on 15/12/3.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWHeaderView.h"

#define HeaderViewH  230

#define  MaxCount 100

#define XWScrollName  @"scrollNameCell"
//collectionView的高度
#define collectionViewH (HeaderViewH-30)
@implementation XWHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        //1.添加collectionView
        [self add];
        //2.添加页控件
        [self setupPage];
        //3.添加底部的label
        [self addLabel];
        
        
    }
    return self;
}

#pragma mark 传递数据
-(void)setArr:(NSMutableArray *)arr
{
    _arr=arr;
    if(arr.count>0){
        //3.添加定时器
        if(self.timer==nil){
            [self addTimer];
        }
        
        //1.设置出事titleLabel的值
        XWNewsModel *newsModel=arr[0];
        self.titleLabel.text=newsModel.title;
        [self.scrollCollection reloadData];
        //2.设置page的数量
        self.page.numberOfPages=arr.count;
    }

}

#pragma mark 添加定时器
-(void)addTimer
{
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer=timer;
}
-(NSIndexPath*)resetIndexPath
{
    NSIndexPath *currentIndexPath=[[self.scrollCollection indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset=[NSIndexPath indexPathForItem:currentIndexPath.item inSection:MaxCount/2];
    
    [self.scrollCollection scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}
#pragma mark 定时器下一页的方法
-(void)nextPage
{
    
    
    NSIndexPath  *currentIndexPathReset=[self resetIndexPath];
    NSInteger item=currentIndexPathReset.item; //行
    NSInteger sec=currentIndexPathReset.section; //区
    item++;
    if(item==self.arr.count){
        item=0;
        sec++;
    }
    

    
    NSIndexPath *nextIndexPath=[NSIndexPath indexPathForItem:item inSection:sec];
    
    [self.scrollCollection scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    
}
#pragma mark 添加CollectionView
-(void)add
{
    
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc]init];
    flow.minimumLineSpacing=0;
    
    flow.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    flow.itemSize=CGSizeMake(self.width, collectionViewH);
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, collectionViewH) collectionViewLayout:flow];
    [collectionView registerClass:[XWHeaderCell  class] forCellWithReuseIdentifier:XWScrollName];
    collectionView.showsHorizontalScrollIndicator=NO;
    collectionView.backgroundColor=XWColorRGBA(20, 20, 20, 0.1);
    collectionView.delegate=self;
    collectionView.dataSource=self;
    collectionView.pagingEnabled=YES;
    [self addSubview:collectionView];
    self.scrollCollection=collectionView;
    
}

#pragma mark 添加底部的label
-(void)addLabel
{
    //1.添加小图标
    UIImageView *icon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"night_photoset_list_cell_icon"]];
    icon.frame=CGRectMake(10, self.scrollCollection.height+10, 20, 20);
    [self addSubview:icon];
    
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.font=[UIFont systemFontOfSize:14];
    CGFloat titleLabelW=self.width-CGRectGetMaxX(icon.frame)-self.page.width-10;
    titleLabel.frame=CGRectMake(CGRectGetMaxX(icon.frame)+5, self.scrollCollection.height+10, titleLabelW, 20);
    
    [self addSubview:titleLabel];
    self.titleLabel=titleLabel;
}

#pragma mark 删除控制器的方法
-(void)removeTimer
{
    [self.timer invalidate];
    self.timer=nil;
}
#pragma mark 添加页控件setupPage
-(void)setupPage
{
    UIPageControl *page=[[UIPageControl alloc]init];
    
    page.numberOfPages=self.arr.count;
    page.pageIndicatorTintColor=[UIColor lightGrayColor];
    
    page.currentPageIndicatorTintColor=XWColorRGBA(0, 0, 0, 0.8);
    CGFloat pageW=80;
    CGFloat pageH=30;
    CGFloat pageX=self.width-pageW;
    CGFloat pageY=self.scrollCollection.height+5;
    page.frame=CGRectMake(pageX, pageY, pageW, pageH);
    [self addSubview:page];
    self.page=page;
    

    
}
#pragma mark  每一组返回多少行
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.arr.count;
}
#pragma mark 返回多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return MaxCount;
}
#pragma mark 返回单元
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XWHeaderCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:XWScrollName forIndexPath:indexPath];
    
    XWNewsModel *newsModel=self.arr[indexPath.row];
    cell.newsModel=newsModel;
    return cell;
    
  
    
}

#pragma mark 点击的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.arr.count==0)  return;
    XWNewsModel *newsModel=self.arr[indexPath.row];
    if([self.delegate respondsToSelector:@selector(headerView:newsModel:)]){
        [self.delegate headerView:self newsModel:newsModel];
    }
}


#pragma mark 手指将要托转的时候
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // NSLog(@"scrollViewWillBeginDragging");
    [self removeTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // NSLog(@"scrollViewDidEndDragging");
    [self addTimer];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // NSLog(@"scrollViewDidEndDecelerating--->");
    [self resetIndexPath];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page=(scrollView.contentOffset.x/scrollView.frame.size.width+0.5);
    int currentPage=page%self.arr.count;
    self.page.currentPage=currentPage;
    
    XWNewsModel *newsModel=self.arr[currentPage];
    self.titleLabel.text=newsModel.title;
}




@end
