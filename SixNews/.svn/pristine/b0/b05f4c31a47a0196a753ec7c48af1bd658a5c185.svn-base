//
//  XWDetailModel.m
//  SixNews
//
//  Created by Dy on 15/12/1.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWDetailModel.h"
#import "XWDetailImgModel.h"
@implementation XWDetailModel
+(instancetype)initWithDic:(NSDictionary *)dic
{
    XWDetailModel *detailModel = [[XWDetailModel alloc]init];
    
    detailModel.title = dic[@"title"];
    detailModel.ptime = dic[@"ptime"];
    detailModel.body = dic[@"body"];
    detailModel.soure = dic[@"source"];
    
    NSArray *imgArr = dic[@"img"];
    NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:imgArr.count];
    if (imgArr)
    {
        for (NSDictionary *dic in imgArr)
        {
        
            XWDetailImgModel *imgModel = [XWDetailImgModel initWithDic:dic];
            [tmpArr addObject:imgModel];
            
            
        }
        
        
    }
    
    detailModel.img = tmpArr;
    
    
    
    
    
    
    

    
    return detailModel;
}
@end
