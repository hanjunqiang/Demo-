//
//  ViewController.m
//  热更新测试
//
//  Created by 韩军强 on 16/8/31.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.testLabel.text = @"abcdefghijklmnopqrstuvwxyz";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
