//
//  RHCFChatInputView.m
//  Chat Kit
//
//  Created by LeungChaos on 16/8/29.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "RHCFChatInputView.h"
#import "RHCFInpoutTopView.h"
#import "RHCFInputBottomView.h"
#import <Masonry.h>

NSString * const RHCFInputBottomViewSendBtnClickNotification
= @"RHCFInputBottomViewSendBtnClickNotification";
NSString * const RHCFInputBottomViewDidSelectedMenuItemNotification
= @"RHCFInputBottomViewDidSelectedMenuItemNotification";
NSString * const RHCFInputBottomViewMenuIndexKey
= @"RHCFInputBottomViewMenuIndexKey";
NSString * const RHCFInputBottomViewDidSelectedEmojiNotification
= @"RHCFInputBottomViewDidSelectedEmojiNotification";
NSString * const RHCFInputBottomViewEmojiKey
= @"RHCFInputBottomViewEmojiKey";
NSString * const kTextViewDeleteTextPrefix = @"kTextViewDeleteTextPrefix";
NSString * const kTextViewDeleteTextSuffix = @"kTextViewDeleteTextSuffix";


@interface RHCFChatInputView ()<RHCFInpoutTopViewDelegate>

/** 毛玻璃 */
@property (weak, nonatomic) UIVisualEffectView *blurView;

/** 头部 (输入框)*/
@property (weak, nonatomic) RHCFInpoutTopView *topView;

/** 底部 (表情键盘，功能键盘)*/
@property (weak, nonatomic) RHCFInputBottomView *bottomView;

/*================ 数据属性 =================*/

@property (assign, nonatomic) RHCFChatInputStyle style;

@property (assign, nonatomic) CGSize keyboardSize;

@property (assign, nonatomic) CGFloat keyboardDuration;

@property (assign, nonatomic) CGFloat bottomHeight;

@end

@implementation RHCFChatInputView

#pragma mark - 懒加载
- (RHCFInpoutTopView *)topView
{
    if (_topView == nil) {
        RHCFInpoutTopView *topv = [RHCFInpoutTopView inpoutTopViewWithStyle:self.style];
        topv.delegate = self;
        [self addSubview:topv];
        [topv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.bottom.equalTo(self.bottomView.mas_top);
        }];
        
        _topView = topv;
    }
    return _topView;
}

- (RHCFInputBottomView *)bottomView
{
    if (_bottomView == nil) {
        RHCFInputBottomView *bottom = [[RHCFInputBottomView alloc] init];
        [self addSubview:bottom];
        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(kBottomViewHeight);
        }];
        _bottomView = bottom;
    }
    return _bottomView;
}

- (UIVisualEffectView *)blurView
{
    if (_blurView == nil) {
        UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        [self addSubview:view];
        [view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(@0);
        }];
        _blurView = view;
    }
    return _blurView;
}

#pragma mark - 生命周期
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.bottomHeight = kBottomViewHeight;
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
        [self blurView];
        [self observeKeyboard];
        [self observeBottomView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 便利构造方法
+ (instancetype)chatInputViewWithStyle:(RHCFChatInputStyle)style
{
    RHCFChatInputView *view = [[self alloc] init];
    view.style = style;
    [view setup];
    return view;
}

- (void)addToView:(UIView *)superView
{
    [superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.bottom.offset(self.bottomHeight);
    }];
    [self layoutIfNeeded];
}

#pragma mark - 初始化设置
- (void)setup
{
    [self topView];
}

#pragma mark - 输入框的点击事件
/** <RHCFInpoutTopViewDelegate> **/
/** 状态改变时调用 */
- (void)inputTopView:(RHCFInpoutTopView *)inputTopView statusDidChanged:(RHCFChatInputStatus)status
{
    /** 改变bottomView的高度 */
    switch (status) {
        case RHCFChatInputStatusText:
            /** 有键盘 height = 0 ,调整offset */
//            [self updateBottomHeight:[self.bottomView hideAllView]];
            break;
        case RHCFChatInputStatusEmoji:{
            /** 表情键盘 height = 计算 */
            [self.bottomView showEmojiKeyBoardCompleted:^(CGFloat height) {
                [self updateBottomHeight:height];
            }];}
//            [self updateBottomHeight:[self.bottomView showEmojiKeyBoard]];
            break;
        case RHCFChatInputStatusMore:{
            /** 没有键盘 height = 计算 */
            [self.bottomView showMoreMenuCompleted:^(CGFloat height) {
                [self updateBottomHeight:height];
            }];
        }
            break;
        case RHCFChatInputStatusSpeaker:
            /** 没有键盘 height = 0 */
            [self updateBottomHeight:[self.bottomView hideAllView]];
            break;
        default:
            
            break;
    }
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)layoutIfNeeded
{
    [super layoutIfNeeded];
    if ([self.delegate respondsToSelector:@selector(inputView:positionChangedRect:)]) {
        [self.delegate inputView:self positionChangedRect:self.frame];
    }
}

- (void)inputText:(NSString *)text
{
    [self.topView inputText:text];
}

- (void)setText:(NSString *)text
{
    [self.topView setText:text];
}

/** 点击录音按钮时调用 */
- (void)inputTopView:(RHCFInpoutTopView *)inputTopView recordBtnPress:(RHCFRecordButtonStatus)status
{
    /** 录音 */
    if ([self.delegate respondsToSelector:@selector(inputView:recodeBtnForStatus:)]) {
        [self.delegate inputView:self recodeBtnForStatus:status];
    }
}

/** 发送事件 */
- (void)inputTopView:(RHCFInpoutTopView *)inputTopView sendText:(NSString *)text
{
    if ([self.delegate respondsToSelector:@selector(inputView:sendText:)]) {
        [self.delegate inputView:self sendText:text];
    }
}

- (void)inputTopView:(RHCFInpoutTopView *)inputTopView textDidChange:(NSString *)text
{
    if ([text isEqualToString:@"@"]) {
        if ([self.delegate respondsToSelector:@selector(inputViewDidInputAtSign:)]) { /** 点击了@ */
            [self.delegate inputViewDidInputAtSign:self];
        }
    }
}

- (void)updateBottomHeight:(CGFloat)height
{
    if (height == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(self.bottomHeight);
        }];
        return;
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
    }];
    
    self.bottomHeight = height;
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}

- (void)hideDown
{
    [self endEditing:YES];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(self.bottomHeight + kTextViewMaxHeight + kTextViewHorizontalMargin * 2);
    }];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)showUp
{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(self.bottomHeight);
    }];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self layoutIfNeeded];
    }];
}

#pragma mark - 监听键盘弹出
- (void)observeKeyboard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)kbShow:(NSNotification *)noti
{
    self.keyboardSize = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.keyboardDuration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (self.keyboardSize.height == 0) {
        return;
    }
    [self updateChatBarKeyBoardConstraints];
}


- (void)kbHide:(NSNotification *)noti
{
//    self.keyboardSize = CGSizeZero;
//    
//    [self updateChatBarKeyBoardConstraints];
}


- (void)updateChatBarKeyBoardConstraints
{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset( - (self.keyboardSize.height - self.bottomHeight));
    }];
    
    [UIView animateWithDuration:self.keyboardDuration animations:^{
        [self layoutIfNeeded];
    }];
}

- (BOOL)endEditing:(BOOL)force
{
    if (self.topView.status == RHCFChatInputStatusSpeaker) return force;
    self.topView.status = 0;
    [self updateBottomHeight:[self.bottomView hideAllView]];
    
    self.keyboardSize = CGSizeZero;
    [self updateChatBarKeyBoardConstraints];
    return [super endEditing:force];
}

#pragma mark - 监听通知, 表情键盘
- (void)observeBottomView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedMenuItemNotification:) name:RHCFInputBottomViewDidSelectedMenuItemNotification object:nil];
}

- (void)selectedMenuItemNotification:(NSNotification *)noti
{
    NSInteger index = [noti.userInfo[RHCFInputBottomViewMenuIndexKey] integerValue];
    if ([self.delegate respondsToSelector:@selector(inputView:clickMenuItemAtIndex:)]) {
        [self.delegate inputView:self clickMenuItemAtIndex:index];
    }
}

@end
