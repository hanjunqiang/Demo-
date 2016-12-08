//
//  UBuddyListController.m
//  EaseMobUI
//
//  Created by 周玉震 on 15/8/25.
//  Copyright (c) 2015年 周玉震. All rights reserved.
//

#import "UBuddyListController.h"
#import "UChatController.h"
#import "UAddBuddyController.h"

#import "UResourceUtils.h"

@interface UBuddyListController ()<EM_ChatBuddyListControllerDelegate,EM_ChatBuddyListControllerDataSource>

@end

@implementation UBuddyListController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"buddy"];
        self.delegate = self;
  
//这里不能添加，不然不显示好友
//        self.dataSource = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *addBuddy = [UIButton buttonWithType:UIButtonTypeCustom];
    addBuddy.titleLabel.font = [UResourceUtils iconFontWithSize:18];
    [addBuddy setTitle:@"\ue600" forState:UIControlStateNormal];
    [addBuddy setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addBuddy setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [addBuddy addTarget:self action:@selector(addBuddyClicked:) forControlEvents:UIControlEventTouchUpInside];
    [addBuddy sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:addBuddy];
    self.navigationItem.rightBarButtonItem = rightItem;

}

//添加按钮
- (void)addBuddyClicked:(id)sender{
    UAddBuddyController *controller = [[UAddBuddyController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - EM_ChatBuddyListControllerDelegate好友，群或者讨论组被点击
- (void)didSelectedWithOpposite:(EM_ChatOpposite *)opposite{
    UChatController *chatController = [[UChatController alloc]initWithOpposite:opposite];
    [self.navigationController pushViewController:chatController animated:YES];
}

- (BOOL)shouldExpandForGroupAtIndex:(NSInteger)index
{
    return NO;
}
//
//-(BOOL)shouldExpandForGroupAtIndex2:(NSInteger)index
//{
//    return NO;
//}

@end