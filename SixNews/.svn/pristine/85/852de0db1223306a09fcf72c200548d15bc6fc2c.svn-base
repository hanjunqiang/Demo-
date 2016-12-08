//
//  XWWriteReply.h
//  SixNews
//
//  Created by Dy on 15/12/2.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{

    CancelButton,
    SendButton
    
}mButtonType;


@class XWWriteReply;
@protocol XWWriteReplyDelegate <NSObject>
-(void)writeReply:(XWWriteReply*)write buttonType:(mButtonType)type;


@end


@interface XWWriteReply : UIView
//文本框
@property (nonatomic,strong)UITextView *inputText;

//按钮
@property (nonatomic,strong)UIButton *send;

@property (nonatomic,strong)UILabel *title;

@property (nonatomic,strong)UILabel *tip;

@property (nonatomic,weak)id <XWWriteReplyDelegate>delegate;






@end
