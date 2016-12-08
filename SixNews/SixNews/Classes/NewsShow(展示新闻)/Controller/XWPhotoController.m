//
//  XWPhotoController.m
//  SixNews
//
//  Created by Dy on 15/12/3.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWPhotoController.h"

@interface XWPhotoController ()

@end

@implementation XWPhotoController

-(NSMutableArray *)replyArr
{

    if (_replyArr == nil)
    {
        _replyArr = [NSMutableArray array];
    }
    
    return _replyArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    
    //1.添加自定义的导航栏
    [self addNavChild];
    //2.添加自定义的scrollView  里面放图片
    [self setupScrollView];
    
    //3 添加新闻内容的view
    [self addPhotoContentView];
    //4.添加底部的view
    [self addBottomView];
    
    //5.内容请求
    [self setupRequest];
    //6.加载评论请求
    [self setupCommentRequest];
}
/*
 *   添加自定义的导航栏
 */
-(void)addNavChild
{
    //1.添加自定义的导航栏
    XWConstomNavBar *navBar=[[XWConstomNavBar alloc]init];
    navBar.backgroundColor=[UIColor clearColor];
    [self.view addSubview:navBar];
    self.navBar=navBar;
    //2.在自定义的导航栏上面添加按钮
    UIButton *backBtn=[[UIButton alloc]init];
    //icon_back_highlighted
    [backBtn setImage:[UIImage imageNamed:@"weather_back"] forState:UIControlStateNormal];
    //[backBtn setImage:[UIImage imageNamed:@"icon_back_highlighted"] forState:UIControlStateHighlighted];
    backBtn.frame=CGRectMake(0, (64-backBtn.currentImage.size.height), backBtn.currentImage.size.width, backBtn.currentImage.size.height);
    [self.navBar addSubview:backBtn];
    self.backBtn=backBtn;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //3.添加回复按钮
    UIButton *replyBtn=[[UIButton alloc]init];
    [replyBtn setBackgroundImage: [UIImage resizedImage:@"contentview_commentbacky" left:0.5 top:0.5] forState:UIControlStateNormal];
    [replyBtn setBackgroundImage:[UIImage resizedImage:@"contentview_commentbacky_selected"] forState:UIControlStateHighlighted];
    [replyBtn setTitle:self.newsModel.replyCount forState:UIControlStateNormal];
    replyBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    replyBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -5, 0, 5);
    
    CGSize replyS=[self.newsModel.replyCount sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    CGFloat replyW=replyS.width+20;
    CGFloat replyH=replyS.height+25;
    CGFloat replyX=navBar.width-replyW;
    CGFloat replyY=navBar.height-replyH;
    replyBtn.frame=CGRectMake(replyX, replyY, replyW, replyH);
    //点击事件
    [replyBtn addTarget:self action:@selector(replyClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:replyBtn];
    self.replyBtn=replyBtn;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  添加自定义的scrollView  里面放图片
-(void)setupScrollView
{
    UIScrollView *photoScrollView=[[UIScrollView alloc]init];
    photoScrollView.x=0;
    photoScrollView.width=self.view.width;
    photoScrollView.y=self.navBar.height;
    photoScrollView.height=self.view.height-self.navBar.height-50;
    photoScrollView.delegate=self;
    photoScrollView.showsHorizontalScrollIndicator = NO;
    photoScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:photoScrollView];
    self.photoScrollView=photoScrollView;
}


#pragma mark 添加新闻内容的view
-(void)addPhotoContentView
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    XWPhotoContentView *contentV=[[XWPhotoContentView alloc]init];
    
    contentV.x=0;
    contentV.y=self.view.height-50-80;
    [self.view addSubview:contentV];
    self.photoContentV=contentV;
}

#pragma mark 添加底部的view
-(void)addBottomView
{
    XWPhotoBottomView *photoView=[[XWPhotoBottomView alloc]init];
    
    photoView.x=0;
    photoView.y=self.view.height-photoView.height;
    
    [self.view addSubview:photoView];
    self.photoBottom=photoView;
}

#pragma mark 评论按钮点击事件
-(void)replyClick
{
    XWReplyController *reply=[[XWReplyController alloc]init];
    reply.replys=self.replyArr;
    reply.statusBar=@"status";
    [self.navigationController pushViewController:reply animated:YES];
}


#pragma mark  发送网络请求

-(void)setupRequest
{
    //1.取出关键字  54GI0096|78327
    NSString *one=self.newsModel.photosetID;
    //2.从第四个开始截取
    NSString *two=[one substringFromIndex:4];
    NSArray *three=[two componentsSeparatedByString:@"|"];
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",[three firstObject],[three lastObject]];
    
    [XWHttpTool getDetailWithUrl:url parms:nil success:^(id json) {
        XWPhotoModel *photoModel=[XWPhotoModel objectWithKeyValues:json];
        self.photoModel=photoModel;
        
        //1.显示内容到label
        [self setContentWithModel:photoModel];
        //2.显示图片到scrollView
        [self setImageViewWithModel:photoModel];
        
        
        
        
    } failture:^(id error) {
        //如果有错误就标示没有数据
        if(error){
            [self setLabelWithStr:@"没有数据"];
        }
        
    }];
    
}

#pragma mark 加载评论请求
-(void)setupCommentRequest
{
    //NSString *url2 = @"http://comment.api.163.com/api/json/post/list/new/hot/photoview_bbs/PHOT1ODB009654GK/0/10/10/2/2";
    NSString *url2 = @"http://comment.api.163.com/api/json/post/list/new/hot/3g_bbs/B53H4MN200963VRO/0/10/10/2/2";
    
    [XWHttpTool getDetailWithUrl:url2 parms:nil success:^(id json) {
        
        if(json[@"hotPosts"]!=[NSNull null]){
            for(NSDictionary *dict in json[@"hotPosts"]){
                XWReplyModel *replyModel=[[XWReplyModel alloc]init];
                
                replyModel.name=dict[@"1"][@"u"]?dict[@"1"][@"u"]:nil;
                if(dict[@"1"][@"u"]){
                    replyModel.name=@"火星网友";
                }
                replyModel.address=dict[@"1"][@"f"]?dict[@"1"][@"f"]:nil;
                replyModel.say=dict[@"1"][@"b"]?dict[@"1"][@"b"]:nil;
                
                if(dict[@"1"][@"v"]){
                    replyModel.suppose=dict[@"1"][@"v"];
                }
                
                //把模型添加到数组
                [self.replyArr addObject:replyModel];
                //NSLog(@"%@",dict[@"1"][@"v"]);
            }
        }
        
        
    } failture:^(id error) {
        NSLog(@"网络评论----->%@",error);
    }];
    
}

#pragma mark 添加新闻图片
- (void)setImageViewWithModel:(XWPhotoModel *)photoModel
{
    NSUInteger count = self.photoModel.photos.count;
    
    for (int i = 0; i < count; i++) {
        UIImageView *photoImgView = [[UIImageView alloc]init];
        photoImgView.height = self.photoScrollView.height;
        photoImgView.width = self.photoScrollView.width;
        photoImgView.y = -30;
        photoImgView.x = i * photoImgView.width;
        
        // 图片的显示格式为合适大小
        photoImgView.contentMode= UIViewContentModeTopLeft;
        photoImgView.contentMode= UIViewContentModeScaleAspectFit;
        
        
        [self.photoScrollView addSubview:photoImgView];
        
    }
    //设置第一张图片
    [self setImgWithIndex:0];
    
    self.photoScrollView.contentOffset = CGPointZero;
    self.photoScrollView.contentSize = CGSizeMake(self.photoScrollView.width * count, 0);
    self.photoScrollView.pagingEnabled = YES;
}


/** 懒加载添加图片！这里才是设置图片 */
- (void)setImgWithIndex:(NSInteger)i
{
    
    UIImageView *photoImgView = nil;
    
    photoImgView = self.photoScrollView.subviews[i];
    
    XWPhotoDetailModel  *detailModel = self.photoModel.photos[i];
    
    // 如果这个相框里还没有照片才添加
    if (photoImgView.image == nil) {
        
        [XWBaseMethod loadImageWithImg:photoImgView url:detailModel.imgurl placeImg:@"photoview_image_default_white"];
    }
    
}

#pragma mark 显示新闻内容到view
-(void)setContentWithModel:(XWPhotoModel*)photoModel
{
    self.photoContentV.titleLabel.text = photoModel.setname;
    
    // 设置新闻内容
    [self setContentWithIndex:0];
    
    NSString *countNum = [NSString stringWithFormat:@"1/%ld",photoModel.photos.count];
    self.photoContentV.numLabel.text=countNum;
}

#pragma mark 设置新闻内容
-(void)setContentWithIndex:(NSInteger)index
{
    NSString *content = [self.photoModel.photos[index] note];
    NSString *contentTitle = [self.photoModel.photos[index] imgtitle];
    if (content.length != 0) {
        self.photoContentV.contentText.text = content;
    }else{
        self.photoContentV.contentText.text  = contentTitle;
    }
}


#pragma mark 当没有数据的时候调用的方法
-(void)setLabelWithStr:(NSString*)str
{
    XWNetworkLabel *label=[[XWNetworkLabel alloc]init];
    label.textStr=str;
    label.backgroundColor=[UIColor clearColor];
    label.textColor=[UIColor whiteColor];
    label.x=(self.photoScrollView.width-label.width)*0.5;
    label.y=(self.photoScrollView.height-label.height)*0.4;
    [self.photoScrollView addSubview:label];
    
}

/** 滚动完毕时调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = self.photoScrollView.contentOffset.x / self.photoScrollView.width;
    
    // 添加图片
    [self setImgWithIndex:index];
    
    // 添加文字
    NSString *countNum = [NSString stringWithFormat:@"%d/%zd",index+1,self.photoModel.photos.count];
    self.photoContentV.numLabel.text = countNum;
    
    // 添加内容
    [self setContentWithIndex:index];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)dealloc
{
    // NSLog(@"photo被释放了");
}


@end
