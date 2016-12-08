//
//  AppDelegate.m
//  EaseMobUI
//
//  Created by 周玉震 on 15/6/30.
//  Copyright (c) 2015年 周玉震. All rights reserved.
//

#import "AppDelegate.h"

#import "MainController.h"
#import "ULoginController.h"
#import "UAccount.h"

#import "EaseMobUIClient.h"
#import "EM+Common.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

#import "UserCustomExtend.h"

#import <EaseMobSDKFull/EaseMob.h>
#import <Toast/UIView+Toast.h>

#define EaseMob_AppKey (@"904410775#mrhan1214")

#ifdef DEBUG
#define EaseMob_APNSCertName (@"huanxin_dev")
#else
#define EaseMob_APNSCertName (@"huanxin_distribution")
#endif

@interface AppDelegate ()<EMChatManagerDelegate,IChatManagerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //添加登录者
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    UIViewController *rootController;

    //是否已经开启自动登录
    BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
    if (isAutoLogin) {
        rootController = [[MainController alloc]init];
    }else{
        rootController = [[UINavigationController alloc]initWithRootViewController:[[ULoginController alloc]init]];
    }
#warning 设置根控制器
    self.window.rootViewController = rootController;
    [self.window makeKeyAndVisible];
    
    //初始化SDK
    [[EaseMob sharedInstance] registerSDKWithAppKey:EaseMob_AppKey apnsCertName:EaseMob_APNSCertName];
    //注册一个监听对象到监听列表中
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    //启动完毕
    [[EaseMobUIClient sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
#warning 注册远程推送
    [[EaseMobUIClient sharedInstance] registerForRemoteNotificationsWithApplication:application];
    
    //注册扩展类
    [[EaseMobUIClient sharedInstance] registerExtendClass:[UserCustomExtend class]];
#warning 后台应用显示的未读数（为0，隐藏不显示数目）
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    
    //注册一个监听对象到监听列表中添加好友的消息
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    
    return YES;
}

#pragma mark -mrhan启动远程通知注册程序的应用程序对象。
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

//注册远程通知失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

//收到远程推送通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[EaseMobUIClient sharedInstance] application:application didReceiveRemoteNotification:userInfo];
}

//收到本地推送通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    [[EaseMobUIClient sharedInstance] application:application didReceiveLocalNotification:notification];
}

#pragma mark -mrhan根控制器变为主界面
- (void)changeRootControllerToMain{
    BACK(^{
        sleep(1);
        MAIN(^{
            if (![self.window.rootViewController isMemberOfClass:[MainController class]]) {
                self.window.rootViewController = [[MainController alloc]init];
            }
        });
    });
}

#pragma mark -mrhan根控制器变为登录界面
- (void)changeRootControllerToLogin{
    BACK(^{
        sleep(1);
        MAIN(^{
            if ([self.window.rootViewController isMemberOfClass:[MainController class]]) {
                self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[ULoginController alloc]init]];
            }
        });
    });
}

#pragma mark - EMChatManagerLoginDelegate用户登录后的回调，把登录界面变成主界面
- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error{
    if (!error) {
        [[EaseMob sharedInstance].chatManager enableAutoLogin]; //开启自动登录功能
        [self.window makeToast:@"登录成功"]; //window底部的一个提示
        [self changeRootControllerToMain];
    }else{
        [self.window makeToast:error.description];  //错误信息描述
    }
}

#pragma mark -mrhan用户将要进行自动登录操作的回调
- (void)willAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error{
    if (!error) {
        [self.window makeToast:@"自动登录中..."];
    }else{
        [self.window makeToast:error.description];
        [self changeRootControllerToLogin];
    }
}

#pragma mark -mrhan用户自动登录完成后的回调
- (void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error{
    if (!error) {
        [self.window makeToast:@"自动登录完成"];
    }else{
        [self.window makeToast:error.description];
        [self changeRootControllerToLogin];
    }
}

#pragma mark -mrhan用户注销后的回调
- (void)didLogoffWithError:(EMError *)error{
    if (!error) {
        [self.window makeToast:@"已注销"];
        [self changeRootControllerToLogin];
    }
}

#pragma mark -mrhan当前登录账号在其它设备登录时的通知回调
- (void)didLoginFromOtherDevice{
    [self.window makeToast:@"您的账号已在其他设备登录"];
    [self changeRootControllerToLogin];
}

#pragma mark -mrhan当前登录账号已经被从服务器端删除
- (void)didRemovedFromServer{
    
}

//注册新用户后的回调
- (void)didRegisterNewAccount:(NSString *)username password:(NSString *)password error:(EMError *)error{
    if (!error) {
        [self.window makeToast:@"注册成功"];
        [self changeRootControllerToMain];
    }else{
        [self.window makeToast:error.description];
    }
}

#pragma mark -mrhan将要发起自动重连操作
- (void)willAutoReconnect{
    
}

#pragma mark -mrhan自动重连操作完成后的回调（成功的话，error为nil，失败的话，查看error的错误信息）
- (void)didAutoReconnectFinishedWithError:(NSError *)error{
    
}

#pragma mark - EMChatManagerUtilDelegate - SDK连接服务器的状态变化时的回调
- (void)didConnectionStateChanged:(EMConnectionState)connectionState{
    
}

- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application{
    [[EaseMobUIClient sharedInstance] applicationProtectedDataWillBecomeUnavailable:application];
}

- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application{
    [[EaseMobUIClient sharedInstance] applicationProtectedDataDidBecomeAvailable:application];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[EaseMobUIClient sharedInstance] applicationWillResignActive:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[EaseMobUIClient sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EaseMobUIClient sharedInstance] applicationWillEnterForeground:application];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EaseMobUIClient sharedInstance] applicationDidEnterBackground:application];
    
    //从数据库获取所有未读消息数量
    NSInteger unreadMessagesCount = [[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
    if (unreadMessagesCount > 0) {
        [UIApplication sharedApplication].applicationIconBadgeNumber = unreadMessagesCount;
    }else{
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }
    
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [[EaseMobUIClient sharedInstance] applicationDidReceiveMemoryWarning:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[EaseMobUIClient sharedInstance] applicationWillTerminate:application];
}


//监听好友申请消息
- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:username,@"username",message,@"message", nil];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:dic forKey:@"dic"];
    
    [userDefaults synchronize];
    
    NSString *title = [NSString stringWithFormat:@"来自%@的好友申请",username];
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"222");
    }];
    [alterController addAction:action2];
    [self.window.rootViewController presentViewController:alterController animated:YES completion:nil];
    
}
@end