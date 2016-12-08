//
//  MainController.m
//  EaseMobUI
//
//  Created by 周玉震 on 15/7/1.
//  Copyright (c) 2015年 周玉震. All rights reserved.
//

#import "UChatController.h"
#import "UserCustomExtend.h"

@interface UChatController ()<EM_ChatControllerDelegate>

@end

@implementation UChatController

- (instancetype)initWithConversation:(EMConversation *)conversation{
    self = [super initWithConversation:conversation];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (instancetype)initWithOpposite:(EM_ChatOpposite *)opposite{
    self = [super initWithOpposite:opposite];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#define mark - EM_ChatControllerDelegate为要发送的消息添加扩展
- (void)extendForMessage:(EM_ChatMessageModel *)message{
    message.messageExtend.extendAttributes = @{@"a":@"不显示的属性"};
}

#pragma mark -mrhan自定义动作监听
- (void)didActionSelectedWithName:(NSString *)name{
    
}

#pragma mark -mrhan点击头像时候出发的方法
- (void)didAvatarTapWithChatter:(NSString *)chatter isOwn:(BOOL)isOwn{
    if (isOwn) {
        NSLog(@"111");
    }else
    {
        NSLog(@"222");
    }
}

- (void)didExtendTapWithUserInfo:(NSDictionary *)userInfo{
    
}

- (void)didExtendMenuSelectedWithUserInfo:(NSDictionary *)userInfo{
    
}

@end