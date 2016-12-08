//
//  XWDetailContentController.m
//  SixNews
//
//  Created by Dy on 15/12/3.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWDetailContentController.h"

@interface XWDetailContentController ()

@end

@implementation XWDetailContentController

-(NSMutableArray *)replyArr
{
    if(_replyArr==nil){
        _replyArr=[NSMutableArray array];
    }
return _replyArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置状态栏颜色
    self.view.backgroundColor=[UIColor whiteColor];
    
    //2.添加导航栏上面的子元素
    [self addChild];
    //3.添加webView
    [self setupWebView];
    //4. 添加底部的评论view
    [self setupBottomComment];
    //5.添加发送评论的输入框
    [self setupSendView];
    //6.发送网络请求
    [self setupRequest];
    //7.网络评论发送请求
    [self setupCommentRequest];
    
    // 监听有没有网络
    
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


#pragma mark 添加webView
-(void)setupWebView
{
    //判断有没有网络
    if([XWBaseMethod connectionInternet]==NO){
        XWNetworkLabel *label=[[XWNetworkLabel alloc]init];
        label.textStr=@"网络断开，请重新加载";
        label.x=(ScreenWidth-label.width)*0.5;
        label.y=self.view.height*0.45;
        [self.view addSubview:label];
        return;
    }
    
    UIWebView *webView=[[UIWebView alloc]init];
    webView.backgroundColor=[UIColor whiteColor];
    webView.delegate=self;
    webView.x=0;
    webView.y=self.navBar.height;
    webView.width=self.view.width;
    webView.height=self.view.height-self.navBar.height-40;
    [self.view insertSubview:webView atIndex:1];
    self.webView=webView;
    //  NSLog(@"%@",NSStringFromCGRect(self.navBar.frame));
}

#pragma mark 添加底部的评论view
-(void)setupBottomComment
{
    CGFloat bottomX=0;
    CGFloat bottomH=40;
    CGFloat bottomW=self.view.width;
    CGFloat bottomY=self.view.height-bottomH;
    XWDetailBottomView *bottom=[[XWDetailBottomView alloc]initWithFrame:CGRectMake(bottomX, bottomY, bottomW, bottomH)];
    bottom.delegate=self;
    [self.view addSubview:bottom];
    self.commentView=bottom;
    
}

#pragma mark 底部view的代理方法
-(void)detailBottom:(XWDetailBottomView *)detailView tag:(DetailButtonType)tag
{
    
    switch (tag) {
        case DetailCommentType:
        {
            //1.添加一个遮盖层
            UIButton *cover=[[UIButton alloc]initWithFrame:self.view.bounds];
            [cover setBackgroundColor:XWColorRGBA(0, 0, 0, 0.6)];
            cover.tag=coverTag;
            [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view insertSubview:cover belowSubview:self.writeReply];
            //2.输入框获取焦点
            [self.writeReply.inputText becomeFirstResponder];
        }
            break;
        case DetailShareType:
        {
            NSLog(@"DetailShareType");
        }
            break;
    }
}


#pragma mark 添加发送评论的输入框
-(void)setupSendView
{
    XWWriteReply *write=[[XWWriteReply alloc]init];
    write.delegate=self; //实现代理
    write.x=0;
    write.y=self.view.height;
    [self.view addSubview:write];
    self.writeReply=write;
    //监听文本框值的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:write.inputText];
}
#pragma mark 文本框的输入值发生改变的时候
-(void)textChange
{
    if(self.writeReply.inputText.text.length>0){
        [self.writeReply.send setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [self.writeReply.send setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

#pragma mark 文本输入框的代理方法
-(void)writeReply:(XWWriteReply *)write mbuttonType:(mButtonType)tag
{
    switch (tag) {
        case SendButton:
        {
            if(self.writeReply.inputText.text.length>0){
                self.writeReply.title.hidden=YES;
                //添加一个动画
                [UIView animateWithDuration:1.5 animations:^{
                    
                    self.writeReply.tip.hidden=NO;
                    //有一个等待时间
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.writeReply.tip.hidden=YES;
                        self.writeReply.title.hidden=NO;
                    });
                } ];
                
            }
            
        }
            break;
        case CancelButton:
        {
            // 移除覆盖层
            UIButton *cover=(UIButton*)[self.view viewWithTag:coverTag];
            [cover removeFromSuperview];
            [self coverClick:cover];
            
            [self.writeReply.inputText resignFirstResponder]; //失去焦点
        }
    }
}

#pragma mark 发送网络请求
-(void)setupRequest
{
    //判断有没有网络
    if([XWBaseMethod connectionInternet]==NO){
        
        return;
    }
    
    [XWBaseMethod showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.newsModel.docid];
    
    [XWHttpTool getDetailWithUrl:url parms:nil success:^(id json) {
        //把数据转成模型
        self.detailModel=[XWDetailModel initWithDic:json[self.newsModel.docid]];
        //webView加载网页数据
        [self loadWebViewData];
        [XWBaseMethod hideHUDAddedTo:self.view animated:YES];
    } failture:^(id error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark webView加载网页数据
-(void)loadWebViewData
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"detail.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body>"];
    //添加新闻内容
    [html appendString:[self addBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.webView loadHTMLString:html baseURL:nil];
}

- (NSString *)addBody
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detailModel.title];
    [body appendFormat:@"<div class=\"time\">%@ &nbsp;&nbsp %@</div>",self.detailModel.ptime,self.detailModel.soure];
    
    if (self.detailModel.body != nil) {
        [body appendString:self.detailModel.body];
    }
    // 遍历img
    for (XWDetailImgModel *detailImgModel in self.detailModel.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [detailImgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModel.src];
        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        [body replaceOccurrencesOfString:detailImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}


#pragma mark 发送网络评论的网络请求
-(void)setupCommentRequest
{
    //判断有没有网络
    if([XWBaseMethod connectionInternet]==NO)  return;
    
    NSString *url2 = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.newsModel.boardid,self.newsModel.docid];
    // NSLog(@"%@",url2);
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

/*
 *  webView的代理方法
 */


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

/*
 *  点击返回按钮的时候
 */

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//视图将要出现的时候

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIApplication *app = [UIApplication sharedApplication];
    app.statusBarStyle = UIStatusBarStyleDefault;
    
    //监听键盘的变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //将要隐藏的时候
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillClose:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
}

#pragma mark 键盘将要出现
-(void)keyboardWillShow:(NSNotification*)note
{
    
    
    CGRect keyboardF=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration=[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //改变发送框的frame
    [UIView animateWithDuration:duration animations:^{
        self.writeReply.transform=CGAffineTransformMakeTranslation(0, -(keyboardF.size.height+self.writeReply.height));
        
    }];
}

#pragma mark 遮盖层按钮的点击
-(void)coverClick:(UIButton*)cover
{
    [cover removeFromSuperview]; //移除按钮
    [self.writeReply.inputText resignFirstResponder];
}

#pragma mark 键盘将要隐藏
-(void)keyboardWillClose:(NSNotification*)note
{
    //移除遮盖层
    // [self.cover removeFromSuperview];
    
    double duration=[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        
        self.writeReply.transform=CGAffineTransformIdentity;
        
    }];
}


#pragma mark 评论按钮点击的时候

-(void)replyClick
{
    XWReplyController *reply=[[XWReplyController alloc]init];
    reply.replys=self.replyArr;
    // NSLog(@"%@",self.replyArr);
    [self.navigationController pushViewController:reply animated:YES];
    
}



-(void)dealloc
{
    //在控制器销毁的时候 设置回颜色
    UIApplication *app = [UIApplication sharedApplication];
    app.statusBarStyle = UIStatusBarStyleLightContent;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}@end
