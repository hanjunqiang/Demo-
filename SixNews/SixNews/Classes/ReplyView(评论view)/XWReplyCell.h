//
//  XWReplyCell.h
//  新闻
//
//  Created by user on 15/10/3.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWReplyModel.h"

@interface XWReplyCell : UITableViewCell
//用户的发言评论
@property (weak, nonatomic) IBOutlet UILabel *sayLabel;

@property (nonatomic,strong)  XWReplyModel *replyModel;

@end
