//
//  RHCFInpoutTopView.m
//  Chat Kit
//
//  Created by LeungChaos on 16/8/29.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "RHCFInpoutTopView.h"
#import <Masonry.h>
#import "RFEmoji.h"
#import "NSString+Emoji.h"

@interface RHCFInpoutTopView ()<UITextViewDelegate>

/**======= Top View =======*/
@property (weak, nonatomic) UIView *seperator;

/** textView */
@property (weak, nonatomic) UITextView *textView;

/** speakButton */
@property (weak, nonatomic) UIButton *speakPressButton;

/** 表情按钮 */
@property (weak, nonatomic) UIButton *emojiBtn;

/** 语音切换按钮 */
@property (weak, nonatomic) UIButton *speakerBtn;

/** 加号按钮 */
@property (weak, nonatomic) UIButton *exturnBtn;


/*========= 数据属性 ========*/

@property (assign, nonatomic) RHCFChatInputStyle style; /** 类型 */

@property (assign, nonatomic) CGFloat screenW;

@property (assign, nonatomic) CGFloat btnWH;

@property (assign, nonatomic) CGFloat oldTextViewHeight;

@property (assign, nonatomic) BOOL allowTextViewContentOffset;

@end


@implementation RHCFInpoutTopView

#pragma mark - lazy load
- (UIView *)seperator
{
    if (_seperator == nil) {
        UIView *view= [UIView new];
        view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@(0.7));
        }];
        _seperator = view;
    }
    return _seperator;
}

- (UITextView *)textView
{
    if (_textView == nil) {
        UITextView *tv = [[UITextView alloc] initWithFrame:CGRectZero];
        tv.textColor = [UIColor blackColor];
        tv.delegate = self;
        tv.font = [UIFont systemFontOfSize:16.0f];
        tv.layer.cornerRadius = 5.0;
        tv.layer.masksToBounds = YES;
        tv.layer.borderWidth = 0.5;
        tv.layer.borderColor = [UIColor lightGrayColor].CGColor;
        tv.scrollsToTop = NO;
        tv.returnKeyType = UIReturnKeySend;
        [self addSubview:tv];
        _textView = tv;
    }
    return _textView;
}

- (UIButton *)speakPressButton
{
    if (_speakPressButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [btn setTitle:@"按住 说话" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitle:@"上滑 取消" forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[self resizableImage:[UIImage imageNamed:@"VoiceBtn_Black"]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[self resizableImage:[UIImage imageNamed:@"VoiceBtn_BlackHL"] ] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(beginRecordVoice:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [btn addTarget:self action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
        [btn addTarget:self action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        [self addSubview:btn];
        btn.hidden = YES;
        _speakPressButton = btn;
    }
    return _speakPressButton;
}

- (UIButton *)emojiBtn
{
    if (_emojiBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btncClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _emojiBtn = btn;
    }
    return _emojiBtn;
}

- (UIButton *)speakerBtn
{
    if (_speakerBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btncClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _speakerBtn = btn;
    }
    return _speakerBtn;
}

- (UIButton *)exturnBtn
{
    if (_exturnBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"TypeSelectorBtnHL_Black"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btncClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _exturnBtn = btn;
    }
    return _exturnBtn;
}

- (UIImage *)resizableImage:(UIImage *)img
{
    CGFloat w = img.size.width * 0.5 - 0.01;
    CGFloat h = img.size.height * 0.5 - 0.01;
    return [img resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
}

#pragma mark - 便利构造方法
+ (instancetype)inpoutTopViewWithStyle:(RHCFChatInputStyle)style
{
    RHCFInpoutTopView *view = [[self alloc] init];
    view.style = style;
    [view setup];
    return view;
}

#pragma mark - 生命周期
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self seperator];
        self.screenW = [UIScreen mainScreen].bounds.size.width;
        self.btnWH = kInpoutTopViewHeigth - kButtonMargin * 2;
        self.oldTextViewHeight = kTextViewMinHeight;
        /* 接收通知 */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendTextNotification:) name:RHCFInputBottomViewSendBtnClickNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedEmojiItemNotification:) name:RHCFInputBottomViewDidSelectedEmojiNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__func__);
}

- (void)setup
{
    /* 根据style来创建子控件 */
    
    /** 输入框 */
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kTextViewVerticalMargin);
        make.bottom.equalTo(self).offset(-kTextViewVerticalMargin);
        make.left.equalTo(self.speakerBtn.mas_right);
        make.left.equalTo(self).offset(kTextViewLeadingMargin).priority(700);
        make.right.equalTo(self.emojiBtn.mas_left);
        make.height.mas_equalTo(kTextViewMinHeight);
    }];
    
    /** 录音按钮 */
    [self.speakPressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.textView);
        make.top.equalTo(@2);
        make.bottom.equalTo(@(-2));
    }];
    
    /** 语音按钮 */
    [self.speakerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.btnWH, self.btnWH));
        make.left.equalTo(self);
        make.bottom.equalTo(self).offset(-kButtonMargin);
    }];
    
    /** 表情按钮 */
    [self.emojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.btnWH, self.btnWH));
        make.right.equalTo(self.exturnBtn.mas_left);
        make.right.equalTo(self).priority(600);
        make.bottom.equalTo(self).offset(-kButtonMargin);
    }];
    
    /** + 按钮 */
    [self.exturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.btnWH, self.btnWH));
        make.right.equalTo(self);
        make.bottom.equalTo(self).offset(-kButtonMargin);
    }];

    /*
     必须存在：
     _emojiBtn
     
     _textView
     */
    if (self.style == RHCFChatInputStyleComment) {
        [self.speakPressButton removeFromSuperview];
        [self.speakerBtn removeFromSuperview];
        [self.exturnBtn removeFromSuperview];
    } else {
        [self sendSubviewToBack:self.speakPressButton];
    }
}


#pragma mark - text view delegate
/** 输入时 是否可以输入该字符串 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (range.location == [textView.text length]) {
        self.allowTextViewContentOffset = YES;
    } else {
        self.allowTextViewContentOffset = NO;
    }
    if ([text isEqualToString:@"\n"]) {
        [self sendTextMessage:textView.text]; /** 点击了键盘的 send “发送” */
        return NO;
    }
    if (text.length == 0) { /** <- 回退 */
        //构造元素需要使用两个空格来进行缩进，右括号]或者}写在新的一行，并且与调用语法糖那行代码的第一个非空字符对齐：
        NSArray *defaultRegulations = @[
                                        //判断删除的文字是否符合表情文字规则
                                        @{
                                            kTextViewDeleteTextPrefix : @"[",
                                            kTextViewDeleteTextSuffix : @"]",
                                            },
                                        //判断删除的文字是否符合提醒群成员的文字规则
                                        @{
                                            kTextViewDeleteTextPrefix : @"@",
                                            kTextViewDeleteTextSuffix : @" ",
                                            },
                                        ];
        
        for (NSDictionary *regulation in defaultRegulations) {
            NSString *prefix = regulation[kTextViewDeleteTextPrefix];
            NSString *suffix = regulation[kTextViewDeleteTextSuffix];
            if (![self textView:textView shouldChangeTextInRange:range deleteBatchOfTextWithPrefix:prefix suffix:suffix]) {
                
                return  NO;
            }
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(inputTopView:textDidChange:)]) {
        [self.delegate inputTopView:self textDidChange:text];
        return ![text isEqualToString:@"@"];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    [self textViewDidChange:textView shouldCacheText:NO];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self layoutIfNeeded];
        [self.superview layoutIfNeeded];
    }];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self setStatus:RHCFChatInputStatusText];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
                                    deleteBatchOfTextWithPrefix:(NSString *)prefix
                                                         suffix:(NSString *)suffix
{
    NSString *substringOfText = [textView.text substringWithRange:range];
    if ([substringOfText isEqualToString:suffix]) {
        NSUInteger location = range.location;
        NSUInteger length = range.length;
        NSString *subText;
        while (1) {
            if (location == 0) {
                return YES;
            }
            location --;
            length ++;
            subText = [textView.text substringWithRange:NSMakeRange(location, length)];
            if (([subText hasPrefix:prefix] && [subText hasSuffix:suffix])) {
                break;
            }
        }
        
        if ([RFEmoji containEmojiName:subText] || [prefix isEqualToString:@"@"]) {
            textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
            [textView setSelectedRange:NSMakeRange(location, 0)];
            [self textViewDidChange:textView];
            return NO;
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView shouldCacheText:(BOOL)shouldCacheText {
    
    CGRect textViewFrame = textView.frame;
    /** 让系统自己计算size */
    CGSize textSize = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(textViewFrame), 1000.0f)];
    /** 是否可滑动 */
    textView.scrollEnabled = (textSize.height > kTextViewMinHeight);
    
    /** 控制范围 */
    CGFloat newTextViewHeight = MAX(kTextViewMinHeight, MIN(kTextViewMaxHeight, textSize.height));
    
    BOOL textViewHeightChanged = self.oldTextViewHeight != newTextViewHeight;
    
    if (textViewHeightChanged) {
        self.oldTextViewHeight = newTextViewHeight;
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) { /** 更新约束 */
            make.height.mas_equalTo(newTextViewHeight);
        }];
    }
    
    if (textView.scrollEnabled && self.allowTextViewContentOffset) {
        if (newTextViewHeight == kTextViewMaxHeight) {
            [textView setContentOffset:CGPointMake(0, textView.contentSize.height - newTextViewHeight) animated:YES];
        } else {
            [textView setContentOffset:CGPointZero animated:YES];
        }
    }
}


#pragma mark - 监听按钮点击
- (void)btncClick:(UIButton *)btn
{
    if (btn == self.speakerBtn) {
        if (!btn.selected) { /* 语音 */
            [self setStatus:RHCFChatInputStatusSpeaker];
        } else { /* 文字 */
            [self setStatus:RHCFChatInputStatusText];
        }
        return;
    }
    else if (btn == self.emojiBtn) {
        if (!btn.selected) { /* 表情 */
            [self setStatus:RHCFChatInputStatusEmoji];
        } else { /* 文字 */
            [self setStatus:RHCFChatInputStatusText];
        }
        return;
    }
    else if (btn == self.exturnBtn) {/* 更多 */
        [self setStatus:RHCFChatInputStatusMore];
        return;
    }
}

#pragma mark - 录音touch事件
- (void)beginRecordVoice:(UIButton *)button 
{
    if ([self.delegate respondsToSelector:@selector(inputTopView:recordBtnPress:)]) {
        [self.delegate inputTopView:self recordBtnPress:RHCFRecordButtonStatusBegan];
    }
}
- (void)endRecordVoice:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(inputTopView:recordBtnPress:)]) {
        [self.delegate inputTopView:self recordBtnPress:RHCFRecordButtonStatusEnded];
    }
}
- (void)cancelRecordVoice:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(inputTopView:recordBtnPress:)]) {
        [self.delegate inputTopView:self recordBtnPress:RHCFRecordButtonStatusCanceled];
    }
}
- (void)RemindDragExit:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(inputTopView:recordBtnPress:)]) {
        [self.delegate inputTopView:self recordBtnPress:RHCFRecordButtonStatusExited];
    }
}
- (void)RemindDragEnter:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(inputTopView:recordBtnPress:)]) {
        [self.delegate inputTopView:self recordBtnPress:RHCFRecordButtonStatusEntered];
    }
}

#pragma mark - 外部调用
- (void)setStatus:(RHCFChatInputStatus)status
{
    if (_status == status) return;
    _status = status;
    switch (status) {
        case RHCFChatInputStatusSpeaker: { /* 语音 */
            self.speakerBtn.selected    = YES;
            self.emojiBtn.selected      = NO;
            [self endEditing:YES];
            self.oldTextViewHeight = kTextViewMinHeight;
            [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(kTextViewMinHeight);
            }];
        }   break;
        case RHCFChatInputStatusEmoji:{ /* 表情 */
            self.speakerBtn.selected    = NO;
            self.emojiBtn.selected      = YES;
            [self endEditing:YES];
            self.oldTextViewHeight = kTextViewMinHeight;
            if (_textView) {
                [self textViewDidChange:self.textView shouldCacheText:YES];
            }
        }
            break;
        case RHCFChatInputStatusMore:{/* 更多 */
            self.speakerBtn.selected    = NO;
            self.emojiBtn.selected      = NO;
            [self endEditing:YES];
            self.oldTextViewHeight = kTextViewMinHeight;
            if (_textView) {
                [self textViewDidChange:self.textView shouldCacheText:YES];
            }
        }break;
        case RHCFChatInputStatusText:{/* 文字 */
            self.speakerBtn.selected    = NO;
            self.emojiBtn.selected      = NO;
            [_textView becomeFirstResponder];
            if (_textView) {
                [self textViewDidChange:self.textView shouldCacheText:YES];
            }
        }break;
        
        default:
            break;
    }
    
    if ([self.delegate respondsToSelector:@selector(inputTopView:statusDidChanged:)]) {
        [self.delegate inputTopView:self statusDidChanged:status];
    }
    
    self.textView.hidden = status == RHCFChatInputStatusSpeaker;
    self.speakPressButton.hidden = !self.textView.hidden;

}

- (void)setText:(NSString *)text
{
    [self.textView setText:text];
}

- (void)inputText:(NSString *)text
{
    NSString *temPtext = text;
    if ([temPtext isEqualToString:@"[删除]"]) { /* 点击了删除按钮 */
        temPtext = @"";
        if (self.textView.text.length == 0) {
            return;
        }
    }
    NSRange range = NSMakeRange(self.textView.text.length - 1, 1);
    BOOL seccess = [self textView:self.textView shouldChangeTextInRange:range replacementText:temPtext];
    if (seccess) {
        if (temPtext.length) {
            self.textView.text = [NSString stringWithFormat:@"%@%@",self.textView.text,temPtext];
            self.allowTextViewContentOffset = YES;
            [self textViewDidChange:self.textView];
        } else {
            self.textView.text = [self.textView.text stringByReplacingCharactersInRange:range withString:@""];
        }
    }
    if ([self.delegate respondsToSelector:@selector(inputTopView:textDidChange:)]) {
        
    }
}

/** 点击发送时候调用 */
- (void)sendTextMessage:(NSString *)text
{
    if ([text isEmpty]) return;
    if ([self.delegate respondsToSelector:@selector(inputTopView:sendText:)]) {
        [self.delegate inputTopView:self sendText:text];
        self.textView.text = @"";
        [self textViewDidChange:self.textView];
    }
}

#pragma mark - 发送信息
- (void)sendTextNotification:(NSNotification *)noti
{
    [self sendTextMessage:self.textView.text];
}

- (void)selectedEmojiItemNotification:(NSNotification *)noti
{
    RFEmoji *emoji = noti.userInfo[RHCFInputBottomViewEmojiKey];
    [self inputText:emoji.face_name];
}



@end






