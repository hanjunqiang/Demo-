//
//  RHCFInputBottomView.m
//  Chat Kit
//
//  Created by LeungChaos on 16/8/29.
//  Copyright © 2016年 liang. All rights reserved.
//
/**======= bottom View ========*/

#import "RHCFInputBottomView.h"
#import "RFMoreMenuView.h"
#import "RFChatEmojiView.h"

@interface RHCFInputBottomView ()

@property (strong, nonatomic) RFMoreMenuView *menuView; /** 更多菜单 */

@property (strong, nonatomic) RFChatEmojiView *emojiView;

@end

@implementation RHCFInputBottomView

- (CGFloat)hideAllView
{
//    [_emojiView mas_remakeConstraints:^(MASConstraintMaker *make) {
//    }];
//    [_menuView mas_remakeConstraints:^(MASConstraintMaker *make) {
//    }];
//    [_menuView removeFromSuperview];
//    [_emojiView removeFromSuperview];
    
    return 0;
}

- (void)hideViewViewCompleted:(void(^)(CGFloat height))block
{
    
}

- (void)showEmojiKeyBoardCompleted:(void(^)(CGFloat height))block
{
    if (_menuView) {
        [_menuView mas_remakeConstraints:^(MASConstraintMaker *make) {
        }];
        [_menuView removeFromSuperview];
    }
    if (block) {
        block(self.emojiView.emojiHeight);
    }
    [self.emojiView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(@0);
    }];
    [self animation];
}

- (void)showMoreMenuCompleted:(void(^)(CGFloat height))block
{
    if (_emojiView) {
        [_emojiView mas_remakeConstraints:^(MASConstraintMaker *make) {
        }];
        [_emojiView removeFromSuperview];
    }
    if (block) {
        block(self.menuView.menuHeight);
    }
    /* 创建菜单并添加到self */
    [self.menuView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(@0);
    }];
    [self animation];
}

- (CGFloat)showEmojiKeyBoard
{
    if (_menuView) {
        [_menuView mas_remakeConstraints:^(MASConstraintMaker *make) {
        }];
        [_menuView removeFromSuperview];
    }
    [self.emojiView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(@0);
    }];
    
    [self animation];
    
    return self.emojiView.emojiHeight;
}

- (CGFloat)showMoreMenu
{
    if (_emojiView) {
        [_emojiView mas_remakeConstraints:^(MASConstraintMaker *make) {
        }];
        [_emojiView removeFromSuperview];
    }
    /* 创建菜单并添加到self */
    [self.menuView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(@0);
    }];
    
    [self animation];
    
    return self.menuView.menuHeight;
}

- (void)animation
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    anim.fromValue = @210;
    anim.toValue = @0;
    anim.duration = 0.2;
    [self.layer addAnimation:anim forKey:nil];
}

- (RFMoreMenuView *)menuView
{
    if (_menuView == nil) {
        _menuView = [RFMoreMenuView new];
    }
    if (![self.subviews containsObject:_menuView]) {
        [self addSubview:_menuView];
    }
    return _menuView;
}

- (RFChatEmojiView *)emojiView
{
    if (_emojiView == nil) {
        _emojiView = [RFChatEmojiView chatEmojiView];
    }
    if (![self.subviews containsObject:_emojiView]) {
        [self addSubview:_emojiView];
    }
    return _emojiView;
}

@end
