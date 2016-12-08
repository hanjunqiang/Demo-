//
//  RFEmojiItemCell.m
//  Chat Kit
//
//  Created by LeungChaos on 16/9/1.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "RFEmojiItemCell.h"
#import "RFEmoji.h"

NSString *const RFEmojiItemCellIden = @"RFEmojiItemCellIden";

@interface RFEmojiItemCell ()

@property (weak, nonatomic) UIButton *iconView;

@end

@implementation RFEmojiItemCell

- (void)awakeFromNib {
    
}

- (void)setEmoji:(RFEmoji *)emoji
{
    [self.iconView setImage:[UIImage imageNamed:emoji.face_image_name] forState:UIControlStateNormal];
}

- (UIButton *)iconView
{
    if (_iconView == nil) {
        UIButton *imgView = [[UIButton alloc] init];
        [self.contentView addSubview:imgView];
        imgView.userInteractionEnabled = NO;
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.left.right.equalTo(@0);
            make.centerX.centerY.equalTo(@0);
            make.size.equalTo(self).multipliedBy(0.85);
        }];
        _iconView = imgView;
    }
    return _iconView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.iconView setHighlighted:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.iconView setHighlighted:NO];
    [super touchesEnded:touches withEvent:event];
}

@end
