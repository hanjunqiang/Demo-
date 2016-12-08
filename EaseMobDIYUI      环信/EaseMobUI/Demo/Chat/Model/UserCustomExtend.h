//
//  UserCustomExtend.h
//  EaseMobUI
//
//  Created by 周玉震 on 15/8/14.
//  Copyright (c) 2015年 周玉震. All rights reserved.
//

#import "EM+ChatMessageExtendBody.h"

#define kIdentifierForCustom               (@"kIdentifierForCustom")

@interface UserCustomExtend : EM_ChatMessageExtendBody

@property (nonatomic, copy) NSString *extendProperty;

@end