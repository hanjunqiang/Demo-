//
//  XWSettingViewCell.h
//  SixNews
//
//  Created by 祁 on 15/12/1.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWCellItem;
@interface XWSettingViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView indextifier:(NSString *)indextifier;

@property(nonatomic,strong)XWCellItem *item;//模型

@end
