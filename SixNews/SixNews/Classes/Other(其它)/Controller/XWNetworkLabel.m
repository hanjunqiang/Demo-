//
//  XWNetworkLabel.m
//  SixNews
//
//  Created by mac on 15/12/1.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWNetworkLabel.h"

@implementation XWNetworkLabel

-(instancetype)init
{
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.textAlignment=NSTextAlignmentCenter;
        self.textColor=[UIColor lightGrayColor];
        
    }
    return self;

}

-(void)setTextStr:(NSString *)textStr
{
    if (textStr.length) {
        CGSize textSize=[textStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        self.text=textStr;
        self.width=textSize.width;
        self.height=textSize.height;
        
    }


}

@end
