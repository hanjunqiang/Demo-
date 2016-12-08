//
//  RFMenuDataSourceModel.h
//  Chat Kit
//
//  Created by LeungChaos on 16/9/1.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RFMenuDataSourceModel;
@protocol RFMenuDataModelDelegate <NSObject>

/** 告诉外界滑动到第几页 */
- (void)menuViewModel:(RFMenuDataSourceModel *)viewMod scrollToPage:(NSInteger)pageNum;

/** 告诉外界点击的是哪个item */
- (void)menuViewModel:(RFMenuDataSourceModel *)viewMod didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface RFMenuDataSourceModel : NSObject<UICollectionViewDelegate, UICollectionViewDataSource>

/** 数据 */
@property (readonly, nonatomic) NSArray *datas;

@property (weak, nonatomic) id<RFMenuDataModelDelegate> delegate;


@end
