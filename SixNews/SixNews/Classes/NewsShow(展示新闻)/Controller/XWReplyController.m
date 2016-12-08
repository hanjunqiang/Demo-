//
//  XWReplyController.m
//  SixNews
//
//  Created by Dy on 15/12/3.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWReplyController.h"

@interface XWReplyController ()

@end

@implementation XWReplyController
static NSString *ID = @"replyStr";


- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置状态栏颜色
    self.view.backgroundColor=[UIColor whiteColor];
    //2.添加自定义的导航栏
    [self addChild];
    //3.添加tableView
    [self setupTableView];
}

/*
 *  添加子元素
 */

-(void)addChild
{
    //1.添加自定义的导航栏
    XWConstomNavBar *navBar=[[XWConstomNavBar alloc]init];
    [self.view addSubview:navBar];
    self.navBar=navBar;
    //2.在自定义的导航栏上面添加按钮
    UIButton *backBtn=[[UIButton alloc]init];
    //icon_back_highlighted
    [backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"icon_back_highlighted"] forState:UIControlStateHighlighted];
    backBtn.frame=CGRectMake(0, (64-backBtn.currentImage.size.height), backBtn.currentImage.size.width, backBtn.currentImage.size.height);
    [self.navBar addSubview:backBtn];
    self.backBtn=backBtn;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 添加tableView
-(void)setupTableView
{
    UITableView *tableView=[[UITableView alloc]init];
    //tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.frame=CGRectMake(0, self.navBar.height, self.view.width, self.view.height);
    //注册表单元
    [tableView registerNib:[UINib nibWithNibName:@"XWReplyCell" bundle:nil] forCellReuseIdentifier:ID];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    self.tableView=tableView;
}

/*
 *    返回多少组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

/*
 *    返回多少行
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.replys.count==0){
        return 1;
    }
    return self.replys.count;
}

#pragma mark 返回单元格
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XWReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[XWReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //如果没有评论
    if(self.replys.count==0){
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.text=@"暂无跟帖数据";
        return cell;
    }else{
        XWReplyModel *replyModel=self.replys[indexPath.row];
        cell.replyModel=replyModel;
    }
    
    return cell;
    
}

//返回表格单元头视图
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0){
        return [XWReplyHeaderView shareWithTitle:@"热门评论"];
    }
    
    return [XWReplyHeaderView shareWithTitle:@"最新评论"];
}
//返回头视图的高度
//返回每个headView的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


/*
 返回每一行的高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.replys.count == 0){
        return 60;
    }else{
        XWReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        XWReplyModel *model = self.replys[indexPath.row];
        
        cell.replyModel = model;
        [cell layoutIfNeeded];
        
        CGFloat y=cell.sayLabel.y;
        CGFloat h=cell.sayLabel.height;
        
        
        return y + h+ 16;
        
        
    }
    
}

/** 预估行高，这个方法可以减少上面方法的调用次数，提高性能 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

/*
 *  点击返回按钮的时候
 */

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIApplication *app = [UIApplication sharedApplication];
    app.statusBarStyle = UIStatusBarStyleDefault;
}

-(void)dealloc
{
    if(self.statusBar){
        //在控制器销毁的时候 设置回颜色
        UIApplication *app = [UIApplication sharedApplication];
        app.statusBarStyle = UIStatusBarStyleLightContent;
    }
    
}



@end
