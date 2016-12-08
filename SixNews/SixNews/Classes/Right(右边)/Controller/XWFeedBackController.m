//
//  XWFeedBackController.m
//  SixNews
//
//  Created by 祁 on 15/11/30.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWFeedBackController.h"
#import "MyTextView.h"

//意见输入框的y
#define mytextViewY 70
//意见输入框的x
#define mytextViewX 5
//意见输入框的y

@interface XWFeedBackController ()

@property (nonatomic,weak) MyTextView *mytextView;
@property (nonatomic,weak) UITextField *phoneInput; //手机号输入框
@end

@implementation XWFeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // 1.添加输入框
    [self addTextView];
    //2.设置导航栏上面的按钮
    [self setupNavButton];
    //3.添加输入手机号的框
    [self setupPhoneInput];

}
#pragma mark 添加输入框
- (void)addTextView {
    self.title=@"意见反馈";
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat tX=mytextViewX;
    CGFloat tY=mytextViewY;
    CGFloat tH=0;
    if(iPhone4){
        tH=120;
    }else{
        tH=200;
    }
    CGFloat tW=ScreenWidth-tX*2;
    CGRect frame=CGRectMake(tX, tY, tW, tH);
    MyTextView *mytextView=[[MyTextView alloc]initWithFrame:frame];
    mytextView.selectedRange=NSMakeRange(0,0) ;   //起始位置
    mytextView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    mytextView.layer.borderWidth=0.5;
    mytextView.placeholder=@"请留下您的宝贵意见";
    [self.view addSubview:mytextView];
    self.mytextView=mytextView;
}

#pragma mark 设置导航栏上面的按钮
-(void)setupNavButton
{
    //1.添加右边的导航栏的按钮
    UIBarButtonItem *rightItem=[UIBarButtonItem itemWithRightIcon:@"search_close_btn" highIcon:nil target:self action:@selector(quit)];
    self.navigationItem.rightBarButtonItem=rightItem;
    //2.添加右边的按钮
    UIBarButtonItem *leftitem=[UIBarButtonItem itemWithLeftTitle:@"发送" target:self action:@selector(send)];
    self.navigationItem.leftBarButtonItem=leftitem;
    
}

#pragma mark 添加输入手机号的框
-(void)setupPhoneInput
{
    CGFloat inputPhoneY=CGRectGetMaxY(self.mytextView.frame)+mytextViewX;
    CGFloat inputPhoneX=mytextViewX;
    CGFloat inputPhoneW=self.mytextView.width;
    CGFloat inputPhoneH=30;
    
    UITextField *inputPhone=[[UITextField alloc]initWithFrame:CGRectMake(inputPhoneX, inputPhoneY, inputPhoneW, inputPhoneH)];
    inputPhone.borderStyle=UITextBorderStyleNone;
    inputPhone.font=[UIFont systemFontOfSize:15];
    inputPhone.placeholder=@"手机号/Email:方便我们及时给您回复";
    inputPhone.layer.borderColor=[UIColor lightGrayColor].CGColor;
    inputPhone.layer.borderWidth=0.5;
    
    inputPhone.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 30)];
    inputPhone.leftViewMode=UITextFieldViewModeAlways;
    
    [self.view addSubview:inputPhone];
}
#pragma mark 发送按钮点击的方法
-(void)send
{
    
    self.mytextView.text=@"";
    self.phoneInput.text=@"";
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.mytextView becomeFirstResponder];
}

-(void)quit
{
    if(self.dismissType){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

@end
