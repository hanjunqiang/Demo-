//
//  XWReplyController.h
//  SixNews
//
//  Created by Dy on 15/12/3.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWConstomNavBar.h"
#import "XWReplyCell.h"
#import "XWReplyModel.h"
#import "XWReplyHeaderView.h"

@interface XWReplyController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray *replys;

@property (nonatomic,copy) NSString *statusBar; //有内容的话
@property (nonatomic,weak) XWConstomNavBar *navBar;
//返回按钮
@property (nonatomic,weak)  UIButton *backBtn;
//表视图
@property (nonatomic,weak)  UITableView *tableView;
@end
