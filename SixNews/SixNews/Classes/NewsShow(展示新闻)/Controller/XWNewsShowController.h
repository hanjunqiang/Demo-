//
//  XWNewsShowController.h
//  SixNews
//
//  Created by Dy on 15/12/3.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWHttpTool.h"
#import "XWNewsModel.h"
#import "XWNewsFrameModel.h"
#import "XWNewsCell.h"
#import "XWDetailContentController.h"
#import "XWPhotoController.h"
#import "XWHeaderView.h"
#import "XWReplyController.h"
#import "XWNewsCell.h"


@interface XWNewsShowController : UITableViewController<XWHeaderViewDelegate>
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,copy) NSString *urlString;
@property(nonatomic,strong) NSMutableArray *arrayList;
@property(nonatomic,assign)BOOL update;

//头视图
@property (nonatomic,weak) XWHeaderView *headerV;
//记载用户下拉刷新 请求新数据的次数
@property (nonatomic,assign) int networkCount;
@end
