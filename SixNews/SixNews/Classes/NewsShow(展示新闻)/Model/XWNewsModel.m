//
//  XWNewsModel.m
//  SixNews
//
//  Created by Dy on 15/12/2.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWNewsModel.h"

@implementation XWNewsModel

-(void)setReplyCount:(NSString *)replyCount
{
    
    //设置回帖数
    NSString *reply = nil;
    if([replyCount intValue]<10000)
    {
        //如果小于1万的话
        reply = [NSString stringWithFormat:@"%d跟帖",[replyCount intValue]];
        // NSLog(@"**********%@",replyCount);
    }
    else
    {
        //如果大于1万的话
        double counts = [replyCount intValue]/10000.0;  //获得回帖数除以10000的商
        reply = [NSString stringWithFormat:@"%.1f万跟帖",counts];
        reply = [reply stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    _replyCount = reply;
    
}
@end
