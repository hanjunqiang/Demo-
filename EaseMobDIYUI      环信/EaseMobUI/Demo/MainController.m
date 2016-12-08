//
//  MainController.m
//  EaseMobUI
//
//  Created by 周玉震 on 15/8/24.
//  Copyright (c) 2015年 周玉震. All rights reserved.
//

#import "MainController.h"
#import "UChatListController.h"
#import "UBuddyListController.h"
#import "USettingsController.h"

@interface MainController ()

@property (nonatomic, strong) NSArray *controllers;

@end

@implementation MainController{
    UChatListController *chatController;
    UBuddyListController *buddysController;
    USettingsController *settingsController;
}

- (instancetype)init{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //消息
    chatController = [[UChatListController alloc]init];
    UINavigationController *narChatController = [[UINavigationController alloc]initWithRootViewController:chatController];
    
    //联系人
    buddysController = [[UBuddyListController alloc]init];
    UINavigationController *narBuddysController = [[UINavigationController alloc]initWithRootViewController:buddysController];
    
    //设置
    settingsController = [[USettingsController alloc]init];
    UINavigationController *narSettingsController = [[UINavigationController alloc]initWithRootViewController:settingsController];
    
    self.controllers = @[narChatController,narBuddysController,narSettingsController];
    self.viewControllers = self.controllers;
}

@end