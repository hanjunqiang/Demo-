//
//  ViewController.m
//  NSArraySwizzing
//
//  Created by yifan on 15/8/21.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
//#import "NSArray+Swizzle.h"
#import <objc/runtime.h>

#warning http://blog.csdn.net/yiyaaixuexi/article/details/9374411
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    Method ori_Method = class_getInstanceMethod([NSArray class], @selector(lastObject));
//    Method my_Method = class_getInstanceMethod([NSArray class], @selector(myLastObject));
//    //修改者两个方法的实现
//    method_exchangeImplementations(ori_Method, my_Method);
//    NSArray *array = @[@"0",@"1",@"2",@"3"];
//    NSString *string = [array lastObject];
//    NSLog(@"TEST RESULT : %@",string);
    
    Method a = class_getInstanceMethod([self class], @selector(aaa));
    Method b = class_getInstanceMethod([self class], @selector(bbb));
    //修改者两个方法的实现
    method_exchangeImplementations(a, b);
    
    [self aaa];
    [self bbb];
}

-(void)aaa
{
    NSLog(@"1111");
}

-(void)bbb
{
    NSLog(@"2222");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
