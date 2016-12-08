//
//  XWDownloadController.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWDownloadController.h"
#import "XWCellItem.h"
#import "XWSwitchItem.h"
#import "XWSettingGroupModel.h"
@implementation XWDownloadController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数组
    [self loadData];
    
    //添加左边导航栏的按钮
    UIBarButtonItem *leftItem= [UIBarButtonItem  itemWithWithLeftIocn:@"weather_back" highIcon:nil edgeInsets:UIEdgeInsetsMake(0, -13, 0, 13) target:self action:@selector(quit)];
    self.navigationItem.leftBarButtonItem=leftItem;
    
}

-(void)loadData
{
    XWCellItem *download=[XWSwitchItem itemWithIcon:nil title:@"WIFI网络下自动下载"];
    XWSettingGroupModel *group=[[XWSettingGroupModel alloc]init];
    group.footer=@"如果开启的话，默认会在WIFI网络下下载数据";
    group.items=@[download];
    
    [self.datas addObject:group];
    
}

-(void)quit
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
