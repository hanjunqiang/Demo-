//
//  XWAboutController.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWAboutController.h"

@interface XWAboutController ()
@property (weak, nonatomic) IBOutlet UIImageView *pic;

@end

@implementation XWAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.pic.layer.cornerRadius=50;
    
    //添加左边导航栏的按钮
    UIBarButtonItem *leftItem=[UIBarButtonItem  itemWithWithLeftIocn:@"weather_back" highIcon:nil edgeInsets:UIEdgeInsetsMake(0, -13, 0, 13) target:self action:@selector(quit)];
    self.navigationItem.leftBarButtonItem=leftItem;

}

-(void)quit
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
