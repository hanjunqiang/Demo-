//
//  XWBottomListView.h
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    FootButtonTypePic, //无图按钮
    FootButtonTypeNight,  //白天 夜间按钮
    FootButtonTypeSetting //设置按钮
    
}FootButtonType;

@class XWBottomListView;

@protocol XWBottomListViewDelegate <NSObject>

@optional
-(void)footView:(XWBottomListView*)footView footTag:(FootButtonType)footTag;

@end


@interface XWBottomListView : UIView

@property (nonatomic,weak) id<XWBottomListViewDelegate> delegate;


@end
