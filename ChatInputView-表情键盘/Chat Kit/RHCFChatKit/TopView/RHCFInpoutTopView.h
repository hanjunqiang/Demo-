//
//  RHCFInpoutTopView.h
//  Chat Kit
//
//  Created by LeungChaos on 16/8/29.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHCFChatInputView.h"

/*
 beginRecordVoice   UIControlEventTouchDown
 endRecordVoice     UIControlEventTouchUpInside
 cancelRecordVoice  UIControlEventTouchUpOutside | UIControlEventTouchCancel
 RemindDragExit     UIControlEventTouchDragExit
 RemindDragEnter    UIControlEventTouchDragEnter
 */

@class RHCFInpoutTopView;
@protocol RHCFInpoutTopViewDelegate <NSObject>

@optional
/** 状态改变时调用 */
- (void)inputTopView:(RHCFInpoutTopView *)inputTopView statusDidChanged:(RHCFChatInputStatus)status;

/** 点击录音按钮时调用 */
- (void)inputTopView:(RHCFInpoutTopView *)inputTopView recordBtnPress:(RHCFRecordButtonStatus)status;

/** 发送事件 */
- (void)inputTopView:(RHCFInpoutTopView *)inputTopView sendText:(NSString *)text;

- (void)inputTopView:(RHCFInpoutTopView *)inputTopView textDidChange:(NSString *)text;

@end

@interface RHCFInpoutTopView : UIView

+ (instancetype)inpoutTopViewWithStyle:(RHCFChatInputStyle)style;

- (void)inputText:(NSString *)text;

@property (assign, nonatomic) RHCFChatInputStatus status; /** 显示状态 */

@property (weak, nonatomic) id<RHCFInpoutTopViewDelegate> delegate;

- (void)setText:(NSString *)text;

@end
