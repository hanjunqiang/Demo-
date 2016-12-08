//
//  RHCFChatRecordModel.h
//  fusionWealthApp
//
//  Created by LeungChaos on 16/9/5.
//  Copyright © 2016年 rhcf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHCFChatInputView.h"

@protocol RHCFChatRecordModelDelegate <NSObject>

- (void)recordModelSendVoice:(NSData *)data time:(NSTimeInterval)time;

- (void)recordModelSendPicture:(UIImage *)image;

@end

@interface RHCFChatRecordModel : NSObject

@property (weak, nonatomic) id<RHCFChatRecordModelDelegate> delegate;

/**
 *  便利构造方法
 */
+ (instancetype)recordModelWithControllerViewController:(UIViewController *)contro;

/**
 *  录音
 */
- (void)recordWithStatus:(RHCFRecordButtonStatus)status;

/**
 *  点击了功能按钮
 */
- (void)buttonAtIndex:(NSInteger)buttonIndex;


@end
