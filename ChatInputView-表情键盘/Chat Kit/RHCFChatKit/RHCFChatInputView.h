//
//  RHCFChatInputView.h
//  Chat Kit
//
//  Created by LeungChaos on 16/8/29.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

/*========== 尺寸常量 ===========*/
static CGFloat const kInpoutTopViewHeigth             = 50;   /** 整个控件的高度 */
static CGFloat const kTextViewMinHeight               = 37.f;   /** 输入框的高度 */
static CGFloat const kTextViewMaxHeight               = 62.f; /**< 输入框最大高度，用于限制最多行数，需要自己估算 */
static CGFloat const kTextViewLeadingMargin           = 12;
static CGFloat const kTextViewHorizontalMargin        = 8;   /** 输入框的水平间距 */
static CGFloat const kTextViewVerticalMargin          = 7;    /** 输入框的垂直间距 */
static CGFloat const kInpoutTopViewHorizontalInset    = 5;    /** 水平内边距 */
static CGFloat const kButtonMargin                    = 0;   /** 每个按钮的距离 */
static CGFloat const kAnimationDuration               = 0.2;
static CGFloat const kBottomViewHeight                = 210;//这个参数在此设置无效,想要设置高度在RFMoreMenuView.m 109行 cvH增加 但是会影响到 本类中hideDown方法
/*=============================*/

/*=-=-=-=-=-=-=-=-=-=-=-=-=- 字符常量 -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
extern NSString * const RHCFInputBottomViewSendBtnClickNotification;
extern NSString * const RHCFInputBottomViewDidSelectedMenuItemNotification;
extern NSString * const RHCFInputBottomViewMenuIndexKey;
extern NSString * const RHCFInputBottomViewDidSelectedEmojiNotification;
extern NSString * const RHCFInputBottomViewEmojiKey;
extern NSString * const kTextViewDeleteTextPrefix;
extern NSString * const kTextViewDeleteTextSuffix;
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/

/** 显示样式 */
typedef NS_ENUM(NSUInteger, RHCFChatInputStyle) {
    RHCFChatInputStyleChat,     /** 聊天样式 */
    RHCFChatInputStyleComment,  /** 评论样式 */
};

/** 输入状态 */
typedef NS_ENUM(NSUInteger, RHCFChatInputStatus) {
    RHCFChatInputStatusText,        /** 文本 */
    RHCFChatInputStatusSpeaker,     /** 语音 */
    RHCFChatInputStatusEmoji,       /** 表情 */
    RHCFChatInputStatusMore         /** 更多 */
};

/** 录音按钮点击状态 */
typedef NS_ENUM(NSUInteger, RHCFRecordButtonStatus) {
    RHCFRecordButtonStatusBegan,            /** 开始录音 */
    RHCFRecordButtonStatusEnded,            /** 录音完毕 */
    RHCFRecordButtonStatusCanceled,         /** 取消录音 */
    RHCFRecordButtonStatusExited,           /** 手指滑出按钮范围 */
    RHCFRecordButtonStatusEntered,          /** 手指重回按钮范围 */
};

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 设置代理监听点击事件 -=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=*/
@class RHCFChatInputView;
@protocol RHCFChatInputViewDelegate <NSObject>

/** 点击了发送按钮时调用 */
- (void)inputView:(RHCFChatInputView *)inputView sendText:(NSString *)text;

/** 点击菜单的某个按钮时调用，参数：对应的下标 */
- (void)inputView:(RHCFChatInputView *)inputView clickMenuItemAtIndex:(NSInteger)index;

/** 录音按钮的状态发生改变时调用 */
- (void)inputView:(RHCFChatInputView *)inputView recodeBtnForStatus:(RHCFRecordButtonStatus)status;

/** 输入了 "@" 时调用*/
- (void)inputViewDidInputAtSign:(RHCFChatInputView *)inputView;

/** 位置发生改变时 */
- (void)inputView:(RHCFChatInputView *)inputView positionChangedRect:(CGRect)rect;

@end
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=*/

@interface RHCFChatInputView : UIView

/**
 *  代理
 */
@property (weak, nonatomic) id<RHCFChatInputViewDelegate> delegate;

/**
 *  便利构造方法
 *
 *  @param style 显示的样式 （ 聊天 / 评论 )
 */
+ (instancetype)chatInputViewWithStyle:(RHCFChatInputStyle)style;

/** 添加到view并设置约束 */
- (void)addToView:(UIView *)superView;

/** 向输入框添加文字 */
- (void)inputText:(NSString *)text;

/** 重新设置输入框的文字 */
- (void)setText:(NSString *)text;

/* 隐藏 */
- (void)hideDown;
/* 显示 （创建时不需要调用）*/
- (void)showUp;

@end


