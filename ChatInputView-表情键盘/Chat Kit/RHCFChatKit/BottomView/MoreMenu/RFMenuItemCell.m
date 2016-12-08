//
//  RFMenuItemCell.m
//  Chat Kit
//
//  Created by LeungChaos on 16/9/1.
//  Copyright © 2016年 liang. All rights reserved.
//



#import "RFMenuItemCell.h"
#import "RFMenuItem.h"

NSString * const RFMenuItemCellIden = @"RFMenuItemCellIden";

@interface RFMenuItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation RFMenuItemCell


- (void)setItem:(RFMenuItem *)item
{
    _item = item;
    
    self.iconView.image = [UIImage imageNamed:item.icon];
    
    self.nameLab.text = item.name;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGFloat fontSize = 17;
    if (IPHONE4S || IPHONE5) {
        fontSize = 12;
    }
    if (IPHONE6) {
        fontSize = 15;
    }
    self.nameLab.font = [UIFont systemFontOfSize:fontSize];
    
}

@end
