//
//  XWDataCacheTool.h
//  SixNews
//
//  Created by mac on 15/12/1.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWDataCacheTool : NSObject
+(void)addArr:(NSArray *)arr andId:(NSString *)idstr;
+(void)addDict:(NSDictionary *)dict andId:(NSString *)idstr;

+(NSArray *)dataWithID:(NSString *)ID;
+(void)deleteWidthId:(NSString *)ID;



@end
