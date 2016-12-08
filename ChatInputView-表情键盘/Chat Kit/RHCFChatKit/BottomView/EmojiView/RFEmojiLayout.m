//
//  RFEmojiLayout.m
//  Chat Kit
//
//  Created by LeungChaos on 16/9/1.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "RFEmojiLayout.h"

@interface RFEmojiLayout ()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attrArray;

@property (nonatomic, assign) CGSize contentSize;

@property (assign, nonatomic) NSInteger page;

@property (assign, nonatomic) UIEdgeInsets pageInset;

@property (assign, nonatomic) CGFloat colMargin;

@property (assign, nonatomic) CGFloat rowMargin;

@end

@implementation RFEmojiLayout

- (void)awakeFromNib
{
    [self setup];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    if (IPHONE4S || IPHONE5) {
        self.columnCount = 7;
        self.colMargin = self.rowMargin = 5;
        self.pageInset = UIEdgeInsetsMake(5, 15, 0, 15);
    } else {
        self.columnCount = 8;
        self.colMargin = self.rowMargin = 8;
        self.pageInset = UIEdgeInsetsMake(10, 30, 0, 30);
    }
    self.rowCount = 3;
    
    CGFloat itemWH = SCREEN.width / self.columnCount - 0.000000001;
    
    self.itemSize = CGSizeMake(itemWH, itemWH);
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

// 准备布局
- (void)prepareLayout
{
    [super prepareLayout];
    
    CGFloat itemWH = (SCREEN.width - self.pageInset.left - self.pageInset.right - ((self.columnCount - 1) * self.colMargin)) / (double)self.columnCount;
    
    self.itemSize = CGSizeMake(itemWH, itemWH);
    
    [self.attrArray removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    NSInteger lastPage = count % (self.columnCount * self.rowCount) == 0 ? 0 : 1;
    
    self.page = count / (self.columnCount * self.rowCount) + lastPage;
    
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
    
    NSInteger page = indexPath.item / (self.columnCount * self.rowCount);
    
    NSInteger row = indexPath.item / self.columnCount % self.rowCount;
    
    NSInteger colInPage = indexPath.item % self.columnCount;
    
    NSInteger col = colInPage + page * self.columnCount;
    
    CGFloat x = col * self.colMargin + col * self.itemSize.width + (leftInset + rightInset) * page + leftInset - self.colMargin * page;
    // y
    CGFloat y = row * (self.rowMargin + self.itemSize.height) + topIniset;
    
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
