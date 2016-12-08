//
//  RFMoreMenuLayout.m
//  Chat Kit
//
//  Created by LeungChaos on 16/9/1.
//  Copyright © 2016年 liang. All rights reserved.
//


#import "RFMoreMenuLayout.h"

@interface RFMoreMenuLayout ()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attrArray;

@property (nonatomic, assign) CGSize contentSize;

@property (assign, nonatomic) CGFloat page;

@property (assign, nonatomic) UIEdgeInsets pageInset;

@end

@implementation RFMoreMenuLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.minimumInteritemSpacing = self.minimumLineSpacing = 0;
        
        CGFloat itemWH = SCREEN.width / kColmuns - 0.000000001;
        
        self.itemSize = CGSizeMake(itemWH, itemWH);
        
        self.pageInset = UIEdgeInsetsMake(10, 20, 0, 20);
        
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

// 准备布局
- (void)prepareLayout
{
    [super prepareLayout];
    
    CGFloat itemWH = (SCREEN.width - self.pageInset.left - self.pageInset.right - ((kColmuns - 1) * self.minimumInteritemSpacing)) / kColmuns - 0.000000001;
    
    self.itemSize = CGSizeMake(itemWH, itemWH);
    
    [self.attrArray removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    NSInteger lastPage = count % (kColmuns * kRows) == 0 ? 0 : 1;
    
    self.page = count / (kColmuns * kRows) + lastPage;
    
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        [self.attrArray addObject:attr];
    }
    self.contentSize = CGSizeMake(self.page * SCREEN.width, 0);
}

// 自己实现cell的布局方法
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat leftInset = self.pageInset.left;
    CGFloat rightInset = self.pageInset.right;
    CGFloat topIniset = self.pageInset.top;
    
    NSInteger page = indexPath.item / (kColmuns * kRows);
    
    NSInteger row = indexPath.item / kColmuns % kRows;
    
    NSInteger col = indexPath.item % kColmuns + page * kColmuns;
    
    CGFloat x = col * (self.minimumInteritemSpacing + self.itemSize.width) + (leftInset + rightInset) * page + leftInset - self.minimumInteritemSpacing * page;
    // y
    CGFloat y = row * (self.minimumLineSpacing + self.itemSize.height) + topIniset;
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attr.frame = CGRectMake( x, y, self.itemSize.width, self.itemSize.height);
    return attr;
}

- (CGSize)collectionViewContentSize
{
    return self.contentSize;
}

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)attrArray
{
    if (_attrArray == nil) {
        _attrArray = [NSMutableArray array];
    }
    return _attrArray;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrArray;
}


@end
