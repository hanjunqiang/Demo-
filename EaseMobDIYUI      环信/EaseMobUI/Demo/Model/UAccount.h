//
//  UAccount.h
//  EaseMobUI
//
//  Created by 周玉震 on 15/9/5.
//  Copyright (c) 2015年 周玉震. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UAccount : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;

+ (instancetype)currentAccount;
+ (BOOL)logoutCurrentAccount;

- (BOOL)setCurrentAccount;

@end