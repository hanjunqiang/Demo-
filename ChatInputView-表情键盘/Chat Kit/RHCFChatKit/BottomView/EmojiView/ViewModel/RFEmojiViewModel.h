//
//  RFEmojiViewModel.h
//  Chat Kit
//
//  Created by LeungChaos on 16/9/1.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 实现数据源方法
 告诉外界点击的是哪个item
 告诉外界滑动到第几页
 */
@class RFEmojiViewModel;
@class RFEmoji;
@protocol RFEmojiViewModelDelegate <NSObject>

- (void)emojiViewModel:(RFEmojiViewModel *)mod didSelectedEmoji:(RFEmoji *)emoji atIndexPath:(NSIndexPath *)indexPath;

- (void)emojiViewModel:(RFEmojiViewModel *)mod scrollToPage:(NSInteger)pageNumber;

- (NSInteger)numberOfItemInPage;

@end

@interface RFEmojiViewModel : NSObject<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) id<RFEmojiViewModelDelegate>delegate;

@property (readonly, nonatomic) NSArray *datas;

@end
