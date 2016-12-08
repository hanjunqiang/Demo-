//
//  XWCommonHttpTool.h
//  SixNews
//
//  Created by mac on 15/12/1.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
@interface XWCommonHttpTool : AFHTTPSessionManager

+(instancetype)sharedNetworkTools;

@end
