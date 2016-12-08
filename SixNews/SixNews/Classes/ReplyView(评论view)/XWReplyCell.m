//
//  XWReplyCell.m
//  新闻
//
//  Created by user on 15/10/3.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "XWReplyCell.h"


@interface XWReplyCell ()
//用户的名字
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//用户的地址
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
//用户的点赞数
@property (weak, nonatomic) IBOutlet UILabel *supposeLabel;
@end

@implementation XWReplyCell

- (void)awakeFromNib {
    // Initialization code
    //2.设置选中颜色
    UIView *v=[[UIView alloc]init];
    v.backgroundColor=XWColorRGBA(20, 20, 20, 0.2);
    self.selectedBackgroundView=v;
    
}

-(void)setReplyModel:(XWReplyModel *)replyModel
{
    _replyModel=replyModel;
    self.nameLabel.text=replyModel.name;
    
    self.addressLabel.text=replyModel.address;
    self.addressLabel.text = _replyModel.address;
    
    NSRange rangeAddress = [_replyModel.address rangeOfString:@"&nbsp"];
    if (rangeAddress.location != NSNotFound) {
        self.addressLabel.text = [_replyModel.address substringToIndex:rangeAddress.location];
    }
    
    
    
    self.supposeLabel.text=replyModel.suppose;
    
    
    
    self.sayLabel.text=replyModel.say;
    self.sayLabel.text = replyModel.say;
    
    NSRange rangeSay = [replyModel.say rangeOfString:@"<br>"];
    if (rangeSay.location != NSNotFound) {
        
        NSString *temp=[replyModel.say stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
        
        self.sayLabel.text = temp;
    }
    
//    if( [replyModel.address containsString:@"<br>"]){
//        NSLog(@"%@",replyModel.say);
//        NSString *sayStr=[replyModel.say stringByReplacingOccurrencesOfString:@"<br>" withString:@"hah"];
//        self.sayLabel.text=sayStr;
//    }
   
    
    
}

@end
