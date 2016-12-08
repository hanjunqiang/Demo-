//
//  XWNewsFrameModel.h
//  SixNews
//
//  Created by Dy on 15/12/2.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XWNewsModel.h"

//标题文字的大小
#define titleFont  [UIFont systemFontOfSize:15]
//描述文字的大小
#define subtitleFont [UIFont systemFontOfSize:12]
//回复文字的大小
#define replyFont [UIFont systemFontOfSize:12]


@interface XWNewsFrameModel : NSObject



@property (nonatomic,strong)  XWNewsModel *newsModel; //新闻模型


// 自定义单元view的frame

@property (nonatomic,assign,readonly) CGRect newsViewF;

// 图片

@property (nonatomic,assign,readonly) CGRect imgIconF;

//  标题

@property (nonatomic,assign,readonly) CGRect titleF;


// 回复数

@property (nonatomic,assign,readonly) CGRect replyF;

//  描述

@property (nonatomic,assign,readonly) CGRect subtitleF;

//  第二张照片(如果有的话)

@property (nonatomic,assign,readonly) CGRect otherImg1F;

//第三张照片(如果有的话)

@property (nonatomic,assign,readonly) CGRect otherImg2F;


//   单元格的高度


@property (nonatomic,assign,readonly) CGFloat cellH;
@end
