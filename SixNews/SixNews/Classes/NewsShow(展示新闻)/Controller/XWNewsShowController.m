//
//  XWNewsShowController.m
//  SixNews
//
//  Created by Dy on 15/12/3.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWNewsShowController.h"

@interface XWNewsShowController ()

@end

@implementation XWNewsShowController
-(NSMutableArray *)arrayList
{
    if (_arrayList ==nil) {
        
        _arrayList = [NSMutableArray array];
    }
    
    return _arrayList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //添加头部视图
    [self addHeaderView];
    
    self.update = YES;
    [self.tableView addHeaderWithTarget:self action:@selector(loadData)];
    [self.tableView addFooterWithTarget:self action:@selector(loaMoreData)];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //开始刷新
    if (self.update == YES) {
        [self.tableView headerBeginRefreshing];
        self.update = NO;
    }
    
    
}

- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
}

#pragma mark 添加头部视图

-(void)addHeaderView
{
    XWHeaderView *headerV=[[XWHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 230)];
    headerV.delegate=self;
    self.tableView.tableHeaderView=headerV;
    self.headerV=headerV;
}

#pragma mark 头视图的代理方法
-(void)headerView:(XWHeaderView *)headerView newsModel:(XWNewsModel *)newsModel
{
    //如果有多上图片的话
    if(newsModel.imgextra.count){
        XWPhotoController *photoVc=[[XWPhotoController alloc]init];
        photoVc.newsModel=newsModel;
        [self.navigationController pushViewController:photoVc animated:YES];
        
    }else{
        
        XWDetailContentController *detail=[[XWDetailContentController alloc]init];
        detail.newsModel=newsModel;  //传递模型
        [self.navigationController pushViewController:detail animated:YES];
        
        
    }
}

/*
 下拉刷新
 */
-(void)loadData
{
    _networkCount++;
    //判断有没有网络
    if([XWBaseMethod connectionInternet]==NO && _networkCount>1){
        [XWBaseMethod showErrorWithStr:@"网络断开了" toView:self.view];
        
    }
    
    NSString *url = [NSString stringWithFormat:@"/nc/article/%@/0-20.html",self.urlString];
    [self loadDataForType:1 withURL:url];
}

/*
 ***  上拉加载更多的数据
 */
-(void)loaMoreData
{
    
    NSString *url = [NSString stringWithFormat:@"/nc/article/%@/%d-20.html",self.urlString,
                     (int)(self.arrayList.count - self.arrayList.count%10)];
    
    [self loadDataForType:2 withURL:url];
    //判断有没有网络
    if([XWBaseMethod connectionInternet]==NO){
        [XWBaseMethod showErrorWithStr:@"网络断开了" toView:self.view];
        [self.tableView footerEndRefreshing];
    }
}

// ------公共方法
- (void)loadDataForType:(int)type withURL:(NSString *)url
{
    //如果idStr有值得话，就是下拉请求新数据 就缓存，如果不是就不缓存。
    NSString *idStr=nil;
    if(type==1){
        idStr=[[self.urlString componentsSeparatedByString:@"/"] lastObject];
        
    }
    
    [XWHttpTool getWithUrl:url  parms:nil  idStr:idStr networkCount:self.networkCount  success:^(id json) {
        
        NSArray *arrModel=[XWNewsModel objectArrayWithKeyValuesArray:json];
        
        //下拉刷新的方法
        if(type==1){
            //清空模型里面的所有数据
            [self.arrayList removeAllObjects];
            //存放headerView数据的数组
            NSMutableArray *headerArr=[NSMutableArray arrayWithCapacity:4];
            
            for(XWNewsModel *newModel in arrModel){
                //1.不包括头部新闻的全部数据 (第一个数据是头数据)
                if(headerArr.count<=3){
                    [headerArr addObject:newModel];
                }
                //2.新闻列表的数据
                XWNewsFrameModel *frameModel=[[XWNewsFrameModel alloc]init];
                frameModel.newsModel=newModel;
                [self.arrayList addObject:frameModel];
                
            }
            
            //传递数据给headerView
            self.headerV.arr=headerArr;
            
            [self.tableView headerEndRefreshing];
            [self.tableView reloadData];
            
        }else if(type==2){  //上啦刷新
            
            NSMutableArray *temp=[NSMutableArray array];
            for(XWNewsModel *newModel in arrModel){
                XWNewsFrameModel *frameModel=[[XWNewsFrameModel alloc]init];
                frameModel.newsModel=newModel;
                [temp addObject:frameModel];
            }
            [self.arrayList addObjectsFromArray:temp];
            
            [self.tableView footerEndRefreshing];
            [self.tableView reloadData];
        }
        
    } failture:^(id error) {
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        NSLog(@"%@",error);
    }];
}

#pragma mark 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayList.count;
}
#pragma mark 返回表格单元
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XWNewsFrameModel *frameModel=self.arrayList[indexPath.row];
    
    XWNewsCell *cell = [XWNewsCell cellWithTableView:tableView Identifier:@"newshow"];
    

    cell.frameModel=frameModel;
    
    return cell;
    
}

#pragma mark 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XWNewsFrameModel *frameModel=self.arrayList[indexPath.row];
    return frameModel.cellH;
}

/** 预估行高，这个方法可以减少上面方法的调用次数，提高性能 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

/****  单元个的点击事件  **/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 刚选中又马上取消选中，格子不变色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XWNewsFrameModel *frameModel=self.arrayList[indexPath.row];
    XWNewsModel *newsModel=frameModel.newsModel;
    if(newsModel.imgextra.count){
        XWPhotoController *photoVc=[[XWPhotoController alloc]init];
        photoVc.newsModel=newsModel;
        [self.navigationController pushViewController:photoVc animated:YES];
        
    }else{
        
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
        
        //取出对应的模型
        XWNewsFrameModel *frameModel=self.arrayList[indexPath.row];
        XWDetailContentController *detail=[[XWDetailContentController alloc]init];
        detail.newsModel=frameModel.newsModel;  //传递模型
        
        [self.navigationController pushViewController:detail animated:YES];
        
        
    }
    
    
}



-(void)dealloc
{
    // NSLog(@"hhhhh");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
