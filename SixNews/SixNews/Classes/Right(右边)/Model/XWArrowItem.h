//
//  XWArrowItem.h
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWCellItem.h"

@interface XWArrowItem : XWCellItem
@property(nonatomic,assign)Class vcClass;
@property(nonatomic,copy)NSString *dismissType;

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title vcClass:(Class)vcClass dismissType:(NSString*)dismissType;
@end
