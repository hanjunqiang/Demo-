//
//  XWDetailBottomView.h
//  SixNews
//
//  Created by Dy on 15/12/2.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    DetailCommentType,
    DetailShareType,
    DetailLikeType
    
    
}DetailButtonType;

@class XWDetailBottomView;
@protocol XWDetailBottomDelegate <NSObject>
-(void)detailBottom:(XWDetailBottomView*)detailView tag:(DetailButtonType)tag;



@end


@interface XWDetailBottomView : UIView

@property (nonatomic,strong)NSMutableArray *buttons;
@property (nonatomic,weak)UIButton *btn;

@property (nonatomic,weak)id <XWDetailBottomDelegate>delegate;




@end
