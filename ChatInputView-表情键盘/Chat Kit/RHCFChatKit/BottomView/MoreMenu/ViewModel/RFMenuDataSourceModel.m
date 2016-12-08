//
//  RFMenuDataSourceModel.m
//  Chat Kit
//
//  Created by LeungChaos on 16/9/1.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "RFMenuDataSourceModel.h"
#import "RFMenuItemCell.h"

#import "RFMenuItem.h"

@interface RFMenuDataSourceModel ()

@property (strong, nonatomic) NSArray<RFMenuItem *> *items;

@end

@implementation RFMenuDataSourceModel

#pragma mark - 懒加载
- (NSArray *)items
{
    if (_items == nil) {
        _items = [RFMenuItem items];
    }
    return _items;
}

- (NSArray *)datas
{
    return self.items;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(menuViewModel:didSelectItemAtIndexPath:)]) {
        [self.delegate menuViewModel:self didSelectItemAtIndexPath:indexPath];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate) return;
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(menuViewModel:scrollToPage:)]) {
        NSInteger index = (int)scrollView.contentOffset.x / (int)scrollView.bounds.size.width;
        [self.delegate menuViewModel:self scrollToPage:index];
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RFMenuItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RFMenuItemCellIden forIndexPath:indexPath];
    
    cell.item = self.items[indexPath.item];
    
    return cell;
}




@end
