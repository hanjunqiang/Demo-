//
//  ViewController.m
//  涂鸦应用
//
//  Created by 韩军强 on 15/9/26.
//  Copyright (c) 2015年 韩军强. All rights reserved.
//

#import "ViewController.h"
#import "DoodleView.h"
@interface ViewController ()

@end

@implementation ViewController

-(void)loadView
{
    self.view=[[DoodleView alloc]init];
    self.view.backgroundColor=[UIColor grayColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
