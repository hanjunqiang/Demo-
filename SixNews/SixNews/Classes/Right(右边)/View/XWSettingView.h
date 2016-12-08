//
//  XWSettingView.h
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWCellItem.h"
#import "XWAboutController.h"
#import "XWSwitchItem.h"
#import "XWLabelItem.h"
#import "XWBosItem.h"

@class XWCellItem;


@interface XWSettingView : UIView

//定义模型
@property(strong,nonatomic)XWCellItem *item;

@end
