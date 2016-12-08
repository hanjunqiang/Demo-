//
//  XWDetailImgModel.h
//  SixNews
//
//  Created by Dy on 15/12/1.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWDetailImgModel : NSObject
//新闻详情

@property (nonatomic,copy)NSString *src;
//图片尺寸
@property (nonatomic,copy)NSString *pixel;
//图片位置

@property (nonatomic,copy)NSString *ref;
+(instancetype)initWithDic:(NSDictionary *)dic;

@end
