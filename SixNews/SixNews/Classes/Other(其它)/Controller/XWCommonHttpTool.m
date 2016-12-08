//
//  XWCommonHttpTool.m
//  SixNews
//
//  Created by mac on 15/12/1.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWCommonHttpTool.h"

@implementation XWCommonHttpTool
//共享网络工具
+(instancetype)sharedNetworkTools
{
    static XWCommonHttpTool *httpTool;
    static dispatch_once_t onceToekn;
    //单例
  dispatch_once(&onceToekn, ^{
      //NSURLSession类支持三种类型的任务:加载数据,下载和上传. NSURLSession是 ios7引入的新网络请求接口
      NSURL *url=[NSURL URLWithString:@"http://c.m.163.com/"];
      NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
      httpTool=[[self alloc]initWithBaseURL:url sessionConfiguration:config];
      httpTool.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
  });



    return httpTool;
    
}
@end
