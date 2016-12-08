//
//  ViewController.m
//  TransparentNavigationBar
//
//  Created by Michael on 15/11/20.
//  Copyright © 2015年 com.51fanxing. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+Transparent.h"
#import "TestViewController.h"
#import "TransparentView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong)  TransparentView *transparentView;

@end

@implementation ViewController

static NSString *ID = @"cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];


    UIImageView *topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"6.jpeg"]];
    topView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
    
    TransparentView *transparentView = [TransparentView dropHeaderViewWithFrame:topView.frame contentView:topView stretchView:topView];
    self.transparentView=transparentView;
    transparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    
    
    UIView *btn=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), self.view.frame.size.width, 100)];
    btn.backgroundColor=[UIColor yellowColor];
//    [self.view addSubview:btn];
    [transparentView addSubview:btn];
    self.tableView.tableHeaderView = transparentView;

    [self.view addSubview:self.tableView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar js_setBackgroundColor:[UIColor clearColor]];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar js_reset];

    //移除自定义的导航view
    for (id obj in self.navigationController.navigationBar.subviews) {
        if ([obj isKindOfClass:[UIView class]]) {
            [obj removeFromSuperview];
        }
    }
    
    [super viewWillDisappear:animated];
}

#pragma mark - UITableViewDelegate，UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试测试测试测试 %ld",indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestViewController *testController = [[TestViewController alloc] init];
    [self.navigationController pushViewController:testController animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"off===%f",offsetY);
    if (offsetY >-64) {
        //从刚开始滚动的时候改变导航颜色
        CGFloat alpha = (offsetY +64) / 64 ;
        alpha = MIN(alpha, 0.9);
        [self.navigationController.navigationBar js_setBackgroundColor:[[UIColor purpleColor] colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar js_setBackgroundColor:[UIColor clearColor]];
    }
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

@end
