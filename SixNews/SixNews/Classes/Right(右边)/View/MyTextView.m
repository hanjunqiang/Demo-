//
//  MyTextView.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
//        添加一个label
        UILabel *placeHolderLabel = [[UILabel alloc]init];
        placeHolderLabel.backgroundColor = [UIColor clearColor];
        placeHolderLabel.hidden = YES;//默认是隐藏的
        placeHolderLabel.font = [UIFont systemFontOfSize:13.0];
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = [UIColor lightGrayColor];
        
        [self addSubview:placeHolderLabel];
        self.placeHolderLabel = placeHolderLabel;
    }
    return self;
}
-(void)textDidChange
{
    self.placeHolderLabel.hidden = (self.text.length!=0);
}
-(void)setPlaceholder:(NSString *)placeholder
{
    if (placeholder.length)
    {
        self.placeHolderLabel.hidden = NO;
        CGFloat placehoderX = 5;
        CGFloat placehoderY = 7;
        CGFloat placehoderW = self.frame.size.width-2*placehoderX;
        CGFloat placehoderH = self.frame.size.height-2*placehoderY;
        CGRect b = [placeholder boundingRectWithSize:CGSizeMake(placehoderW, placehoderH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.placeHolderLabel.font} context:nil];
        self.placeHolderLabel.frame = (CGRect){{placehoderX,placehoderY},b.size};
        self.placeHolderLabel.text = placeholder;
        
//        设置监听器
///       [XWNotification addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];

    }
    else
    {
        self.placeHolderLabel.hidden = YES;
    }
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeHolderLabel.textColor = placeholderColor;
}
//设置控件的大小
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHolderLabel.font =font;
    self.placeholder = self.placeHolderLabel.text;
}
-(void)dealloc
{
///  [XWNotification removeObserver:self];
}
@end
