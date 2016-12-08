//
//  RFChatEmojiView.m
//  Chat Kit
//
//  Created by LeungChaos on 16/8/31.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "RFChatEmojiView.h"
#import "RFEmojiItemCell.h"
#import "RFEmojiViewModel.h"
#import "RFEmojiLayout.h"
#import "RFEmoji.h"
#import "RHCFChatInputView.h"


@interface RFChatEmojiView ()<RFEmojiViewModelDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *titlesView; /* <拓展> 显示分组信息 */

@property (weak, nonatomic) IBOutlet UIButton *sendBtn; /* 发送按钮 */

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) RFEmojiViewModel *viewModel;

@property (strong, nonatomic) RFEmojiLayout *layout;


/*-=-=-=-=-=-=-=-=-=-=-=-= 约束 =-=-=-=-=-=-=-=-=-=-=-=-*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seperatorHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titileViewHeightcons;
@end

@implementation RFChatEmojiView

+ (RFChatEmojiView *)chatEmojiView
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self)
                                        owner:nil
                                      options:nil].lastObject;
}

#pragma mark - 生命周期
- (void)awakeFromNib
{
    self.sendBtn.layer.shadowColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
    self.sendBtn.layer.shadowOpacity = 1.0;
    self.sendBtn.layer.shadowRadius = 5.0;
    
    [self setupCollectionView];
    
    NSInteger lastPage = self.viewModel.datas.count % [self numberOfItemInPage] == 0 ? 0 : 1;
    self.pageControl.numberOfPages = self.viewModel.datas.count / [self numberOfItemInPage] + lastPage;
}


- (void)setupCollectionView
{
    [self.collectionView registerClass:[RFEmojiItemCell class] forCellWithReuseIdentifier:RFEmojiItemCellIden];
    self.collectionView.collectionViewLayout = self.layout;
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.pagingEnabled = true;
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.showsVerticalScrollIndicator = false;

    CGFloat height = self.layout.itemSize.height * self.layout.rowCount;
                            
    self.emojiHeight = height + self.pageHeightCons.constant + self.seperatorHeightCons.constant + self.titileViewHeightcons.constant;
    
    self.collectionView.delegate = self.viewModel;
    self.collectionView.dataSource = self.viewModel;
}

#pragma mark - RFEmojiViewModelDelegate
- (void)emojiViewModel:(RFEmojiViewModel *)mod didSelectedEmoji:(RFEmoji *)emoji atIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:RHCFInputBottomViewDidSelectedEmojiNotification
                                                        object:self
                                                      userInfo:@{
                                                                 RHCFInputBottomViewEmojiKey : emoji
                                                                 }];
}

- (void)emojiViewModel:(RFEmojiViewModel *)mod scrollToPage:(NSInteger)pageNumber
{
    self.pageControl.currentPage = pageNumber;
}

- (NSInteger)numberOfItemInPage
{
    return self.layout.rowCount * self.layout.columnCount;
}

#pragma mark - 发送
- (IBAction)sendClick:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:RHCFInputBottomViewSendBtnClickNotification object:self];
}

#pragma mark - 懒加载
- (RFEmojiViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [RFEmojiViewModel new];
        _viewModel.delegate = self;
    }
    return _viewModel;
}

- (RFEmojiLayout *)layout
{
    if (_layout == nil) {
        _layout = [RFEmojiLayout new];
    }
    return _layout;
}

@end
