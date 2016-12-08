//
//  XWBaseSettingController.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWBaseSettingController.h"
#import "XWSettingViewCell.h"
#import "XWCellItem.h"
#import "XWArrowItem.h"
#import "XWLabelItem.h"
#import "XWSwitchItem.h"
//#import "XWLoginController.h"
#import "XWSettingGroupModel.h"
#import "XWFeedBackController.h"
@interface XWBaseSettingController ()

@end

@implementation XWBaseSettingController
-(instancetype)init
    {
        self=[super initWithStyle:UITableViewStyleGrouped];
        if(self){
            
        }
        return self;
    }
    
-(NSMutableArray *)datas
    {
        if(_datas==nil) {
            _datas=[NSMutableArray array];
        }
        return _datas;
    }
    
- (void)viewDidLoad
{
        [super viewDidLoad];
        self.tableView.backgroundColor=XWColor(250, 250, 250);
        self.tableView.contentInset=UIEdgeInsetsMake(15, 0, 0, 0);
        
        
    }
    
    
#pragma mark 返回有多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        return self.datas.count;
    }
    
#pragma mark 返回有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
        XWSettingGroupModel *group=self.datas[section];
        return group.items.count;
    }
    
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
        
        XWSettingViewCell *cell=[XWSettingViewCell cellWithTableView:tableView indextifier:@"settingCell"];
        
        XWSettingGroupModel *group=self.datas[indexPath.section];
        XWCellItem *item=group.items[indexPath.row];
        
        
        cell.item=item;
        return cell;
    }
    
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
    {
        return 8;
    }
    
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
    {
        XWSettingGroupModel *group=self.datas[section];
        return group.header;
    }
    
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
    {
        XWSettingGroupModel *group=self.datas[section];
        return group.footer;
    }
    
#pragma mark 表格单元的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        //取消选中事件
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        XWSettingGroupModel *group=self.datas[indexPath.section];
        XWCellItem *item=group.items[indexPath.row];
        //如果有块的话 在里面执行即可
        if(item.option){
            item.option();
        }else if([item isKindOfClass:[XWArrowItem class]]){
            
            XWArrowItem *arrow=(XWArrowItem*)item;
            UIViewController *vc=[[arrow.vcClass alloc]init];
            if(arrow.dismissType){
//                if([arrow.dismissType isEqualToString:@"login"]){
//                    XWLoginController *login=[[arrow.vcClass alloc]init];
//                    login.dismissType=arrow.dismissType;
//                    vc=login;
//                }
                if([arrow.dismissType isEqualToString:@"comment"]){
                    XWFeedBackController *feed=[[XWFeedBackController alloc]init];
                    feed.dismissType=arrow.dismissType;
                    vc=feed;
                }
            }
            vc.title=arrow.title;
            //如果传入跳转的类为空 的话  则不需要跳转
            if(arrow.vcClass==nil)return;
            //跳转
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
}
@end
