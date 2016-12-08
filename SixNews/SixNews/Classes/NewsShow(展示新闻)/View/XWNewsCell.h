//
//  XWNewsCell.h
//  SixNews
//
//  Created by Dy on 15/12/2.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XWNewsFrameModel.h"
#import "XWNewsModel.h"
#import "XWNewsView.h"
@interface XWNewsCell : UITableViewCell

@property (strong,nonatomic) XWNewsFrameModel *frameModel;
@property (nonatomic,weak) XWNewsView *newsView;
+(instancetype)cellWithTableView:(UITableView *)tableView Identifier:(NSString *)identifier;

@end
