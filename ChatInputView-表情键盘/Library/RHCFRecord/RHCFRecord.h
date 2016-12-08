//
//  RHCFRecord.h
//  fusionWealthApp
//
//  Created by rhcf_wujh on 16/7/27.
//  Copyright © 2016年 rhcf. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RHCFRecorderDelegate <NSObject>
- (void)failRecord;
- (void)beginConvert;
- (void)endConvertWithData:(NSData *)voiceData;
@end

@interface RHCFRecord : NSObject

+(RHCFRecord *)share;


@property (nonatomic, weak) id<RHCFRecorderDelegate> delegate;

- (void)startRecord;
- (void)stopRecord;
- (void)cancelRecord;


@end
