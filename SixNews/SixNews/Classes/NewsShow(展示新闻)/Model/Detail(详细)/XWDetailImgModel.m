//
//  XWDetailImgModel.m
//  SixNews
//
//  Created by Dy on 15/12/1.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWDetailImgModel.h"

@implementation XWDetailImgModel

+(instancetype)initWithDic:(NSDictionary *)dic
{
    XWDetailImgModel *imgModel  = [[XWDetailImgModel alloc]init];
    imgModel.pixel = dic[@"pixel"];
    imgModel.src = dic[@"src"];
    imgModel.ref = dic[@"ref"];
    
    
    return imgModel;
    
}

@end
