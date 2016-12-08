//
//  RFMoreMenuView.m
//  Chat Kit
//
//  Created by LeungChaos on 16/8/31.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "RFMoreMenuView.h"
#import "RFMoreMenuLayout.h"
#import "RFMenuDataSourceModel.h"
#import "RFMenuItemCell.h"
#import "RHCFChatInputView.h"

@interface RFMoreMenuView ()<RFMenuDataModelDelegate>

/** 顶部分割线 */
@property (weak, nonatomic) UIView *seperator;

/** 可滚动的item */
@property (weak, nonatomic) UICollectionView *collectionView;

/** 页码显示 */
@property (weak, nonatomic) UIPageControl *pageControl;

/** 页数 */
@property (assign, nonatomic) NSInteger pageNumber;

/** view model */
@property (strong, nonatomic) RFMenuDataSourceModel *dataSource;

@end

@implementation RFMoreMenuView


#pragma mark - 生命周期
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark -  初始化设置
- (void)setup
{
    
    NSInteger lastPage = self.dataSource.datas.count % kNumberOfItemInPage == 0 ? 0 : 1;
    self.pageNumber = self.dataSource.datas.count / kNumberOfItemInPage + lastPage;
    
    [self pageControl];
    
    [self.collectionView registerNib:[UINib nibWithNibName: NSStringFromClass([RFMenuItemCell class]) bundle:nil] forCellWithReuseIdentifier:RFMenuItemCellIden];
}

#pragma mark - <RFMenuDataModelDelegate>
- (void)menuViewModel:(RFMenuDataSourceModel *)viewMod didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:RHCFInputBottomViewDidSelectedMenuItemNotification
                                                        object:self
                                                      userInfo:@{
                                                                 RHCFInputBottomViewMenuIndexKey : @(indexPath.item)
                                                                 }];
}

- (void)menuViewModel:(RFMenuDataSourceModel *)viewMod scrollToPage:(NSInteger)pageNum
{
    if (!_pageControl) return;
    self.pageControl.currentPage = pageNum;
}

#pragma mark - 懒加载
- (UIView *)seperator
{
    if (_seperator == nil) {
        UIView *view= [UIView new];
        view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        
        [self addSubview:view];

        self.menuHeight = 0.5;  /*  **/

        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@(self.menuHeight));
        }];
        
        _seperator = view;
    }
    return _seperator;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        RFMoreMenuLayout *layout = [[RFMoreMenuLayout alloc] init];
        UICollectionView *cv = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        cv.backgroundColor = [UIColor clearColor];
        cv.pagingEnabled = true;
        cv.showsHorizontalScrollIndicator = false;
        cv.showsVerticalScrollIndicator = false;
        cv.dataSource = self.dataSource;
        cv.delegate = self.dataSource;
        [cv registerNib:[UINib nibWithNibName:@"RFMenuItemCell" bundle:nil] forCellWithReuseIdentifier:RFMenuItemCellIden];
        [self addSubview:cv];
        
        CGFloat cvH = layout.itemSize.height * kNumberOfItemInPage / kColmuns ;

        [cv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.seperator.mas_bottom);
            make.height.equalTo(@(cvH));
        }];
        
        self.menuHeight += cvH;/*  **/
        
        _collectionView = cv;
    }
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        UIPageControl *page = [UIPageControl new];
        page.numberOfPages = self.pageNumber;
        page.hidden = self.pageNumber < 2;
        [self addSubview:page];
        
        [page mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collectionView.mas_bottom);
            make.bottom.left.right.equalTo(@0);
            make.height.equalTo(@(25));
        }];
        
        self.menuHeight += 25;/*  **/
        
        _pageControl = page;
    }
    return _pageControl;
}

- (RFMenuDataSourceModel *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [RFMenuDataSourceModel new];
        _dataSource.delegate = self;
    }
    return _dataSource;
}

@end
