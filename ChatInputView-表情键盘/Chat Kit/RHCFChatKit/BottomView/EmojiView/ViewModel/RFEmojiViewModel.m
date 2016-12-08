//
//  RFEmojiViewModel.m
//  Chat Kit
//
//  Created by LeungChaos on 16/9/1.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "RFEmojiViewModel.h"
#import "RFEmoji.h"
#import "RFEmojiItemCell.h"

@interface RFEmojiViewModel ()

@property (strong, nonatomic) NSMutableArray<RFEmoji*> *emojis;

@end

@implementation RFEmojiViewModel

#pragma mark - 懒加载
- (NSMutableArray<RFEmoji*> *)emojis
{
    if (_emojis == nil) {
        _emojis = [NSMutableArray arrayWithArray:[RFEmoji emojis]];
        /** 获取页item数 */
        if ([self.delegate respondsToSelector:@selector(numberOfItemInPage)]) {
            NSInteger itemCount = [self.delegate numberOfItemInPage];
            NSInteger lastNumber = itemCount - 1;
            NSInteger page = _emojis.count / itemCount;
            NSInteger lastPage = (_emojis.count + page) % itemCount == 0 ? 1 : 0;
            page += lastPage;
            for (int i = 0; i < page; i++) {
                [_emojis insertObject: [RFEmoji deleteItem] atIndex: i * itemCount + lastNumber ];
            }
            if (_emojis.count % itemCount > 0) {
                [_emojis addObject:[RFEmoji deleteItem]];
            }
        }
    }
    return _emojis;
}

- (NSArray *)datas
{
    return self.emojis;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(emojiViewModel:didSelectedEmoji:atIndexPath:)]) {
        [self.delegate emojiViewModel:self didSelectedEmoji:self.emojis[indexPath.item] atIndexPath:indexPath];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate) return;
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(emojiViewModel:scrollToPage:)]) {
        NSInteger index = (int)scrollView.contentOffset.x / (int)scrollView.bounds.size.width;
        [self.delegate emojiViewModel:self scrollToPage:index];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.emojis.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RFEmojiItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RFEmojiItemCellIden
                                                                      forIndexPath:indexPath];
    cell.emoji = self.emojis[indexPath.item];
    return cell;
}

@end
