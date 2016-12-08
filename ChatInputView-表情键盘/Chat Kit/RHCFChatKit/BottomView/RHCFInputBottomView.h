//
//  RHCFInputBottomView.h
//  Chat Kit
//
//  Created by LeungChaos on 16/8/29.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RFEmoji;
@class RHCFInputBottomView;
@protocol RHCFInputBottomViewDelegate <NSObject>

- (void)bottomView:(RHCFInputBottomView *)bottomView didSelectedMenuItemAtIndex:(NSInteger )index;

- (void)bottomView:(RHCFInputBottomView *)bottomView didSelectedEmoji:(RFEmoji *)emoji atIndex:(NSInteger)index;

- (void)bottomViewSendBtnClick:(RHCFInputBottomView *)bottomView;

@end

@interface RHCFInputBottomView : UIView

@property (weak, nonatomic) id<RHCFInputBottomViewDelegate> delegate;

- (CGFloat)showEmojiKeyBoard; /** 表情键盘 并返回键盘高度 */

- (CGFloat)showMoreMenu; /** 更多菜单 并返回键盘高度 */

- (CGFloat)hideAllView;

- (void)showEmojiKeyBoardCompleted:(void(^)(CGFloat height))block;
- (void)showMoreMenuCompleted:(void(^)(CGFloat height))block;

@end
