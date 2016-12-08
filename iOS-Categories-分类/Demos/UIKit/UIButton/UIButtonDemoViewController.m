//
//  UIButtonDemoViewController.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/3/29.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIButtonDemoViewController.h"
#import "UIButton+CountDown.h"
//#import "UIButton+Block.h"  //这里好像没用到
#import "UIControl+ActionBlocks.h"
#import "UIControl+Block.h"
@interface UIButtonDemoViewController ()

@end

@implementation UIButtonDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
#pragma mark -根据自己对按钮点击、拖拽、松开，执行不同的回调
    [self.blockButton handleControlEvents:UIControlEventTouchDragInside withBlock:^(id weakSender) {
        NSLog(@"UIControlEventTouchDragInside");
    }];
    [self.blockButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        NSLog(@"UIControlEventTouchUpInside");
    }];
    
    [self.blockButton touchUpInside:^{
        NSLog(@"touchUpInside");

    }];
    [self.blockButton touchDown:^{
        NSLog(@"touchDown");
        
    }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)countButtonTouchd:(id)sender {
    
    [sender startTime:6 title:@"倒计时" waitTittle:@"秒"];

}
@end
