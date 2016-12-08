//
//  XWNewsPushController.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWNewsPushController.h"
#import "XWCellItem.h"
#import "XWBosItem.h"
#import "XWSettingGroupModel.h"

@interface XWNewsPushController ()

@end

@implementation XWNewsPushController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //加载数组
    [self loadData];
    
    //添加左边导航栏的按钮
    UIBarButtonItem *leftItem= [UIBarButtonItem  itemWithWithLeftIocn:@"weather_back" highIcon:nil edgeInsets:UIEdgeInsetsMake(0, -13, 0, 13) target:self action:@selector(quit)];
    self.navigationItem.leftBarButtonItem=leftItem;

}

-(void)loadData
{
    XWCellItem *push=[XWBosItem itemWithTitle:@"接收推送" image:@"text_page_tool_bar_off_new" selectedImage:@"text_page_tool_bar_on_new"];
    
    XWSettingGroupModel *group=[[XWSettingGroupModel alloc]init];
    group.items=@[push];
    
    push.option=^{
        NSLog(@"hh");
    };
    
    [self.datas addObject:group];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //发送一个通知 来改变按钮的选中状态
    NSNotification *note=[[NSNotification alloc]initWithName:checkBoxName object:nil userInfo:nil];
    [XWNotification postNotification:note];
    
    
}

-(void)quit
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)dealloc
{
//    [XWNotification removeObserver:self];
}

@end
