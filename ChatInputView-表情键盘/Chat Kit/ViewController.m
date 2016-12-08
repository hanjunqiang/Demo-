//
//  ViewController.m
//  Chat Kit
//
//  Created by LeungChaos on 16/8/29.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "ViewController.h"
#import "RHCFChatInputView.h"
#import "RHCFChatRecordModel.h"
#import "NSString+Emoji.h"

@interface ViewController ()<RHCFChatInputViewDelegate,RHCFChatRecordModelDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) RHCFChatInputView *inpView;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (nonatomic ,strong) RHCFChatRecordModel * recordModel;/**< 录音、菜单*/

@property (nonatomic ,strong) UITableView * tableView;

@end

@implementation ViewController

- (IBAction)aaa:(UIButton *)sender forEvent:(UIEvent *)event {
    sender.selected = !sender.selected;
    if (sender.selected) {
        //TODO:隐藏的时候计算有问题
        NSLog(@"TODO:隐藏的时候计算有问题");
        [_inpView hideDown];
    } else {
        [_inpView showUp];
    }
    
}

#pragma mark - Lazy
- (UIView *)inputView{
    if (!_inpView) {
        RHCFChatInputView *view = [RHCFChatInputView chatInputViewWithStyle:0];
        view.delegate = self;
        [view addToView:self.view];
        _inpView = view;
    }
    return _inpView;
}

- (RHCFChatRecordModel *)recordModel
{
    if (_recordModel == nil) {
        _recordModel = [RHCFChatRecordModel recordModelWithControllerViewController:self]
        ;
        _recordModel.delegate = self;
    }
    return _recordModel;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUI];
}

- (void)loadUI{
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.inputView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(264.0);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.inputView.mas_top);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_inpView endEditing:YES];
}

- (void)inputViewDidInputAtSign:(RHCFChatInputView *)inputView
{
    [inputView inputText:@"@ninininin "];
}

#pragma mark - RHCFChatInputViewDelegate
#pragma mark 选择菜单
- (void)inputView:(RHCFChatInputView *)inputView clickMenuItemAtIndex:(NSInteger)index
{
    NSLog(@"%@---%ld",inputView,index);
    [self.recordModel buttonAtIndex:index];
}

#pragma mark 录音按钮相关
- (void)inputView:(RHCFChatInputView *)inputView recodeBtnForStatus:(RHCFRecordButtonStatus)status
{
    NSLog(@"%@---%ld",inputView,status);
    [self.recordModel recordWithStatus:status];
}

#pragma mark 发送文字
- (void)inputView:(RHCFChatInputView *)inputView sendText:(NSString *)text
{
    NSLog(@"发送文字:%@",text);
    self.lab.attributedText = [text stringToAttributedStringWithFont:[UIFont systemFontOfSize:17] emojiSize:25];
}

- (void)inputView:(RHCFChatInputView *)inputView positionChangedRect:(CGRect)rect
{
    NSLog(@"-=-=位置改变了=-=-");
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    [self tableViewScrollToBottom];
}

#pragma mark - RHCFChatRecordModelDelegate
#pragma mark 发送图片
- (void)recordModelSendPicture:(UIImage *)image
{
    NSLog(@"假装开始上传图片:%@",image);
}

#pragma mark 发送语音
- (void)recordModelSendVoice:(NSData *)voice time:(NSTimeInterval)second
{
    NSLog(@"假装开始上传录音文件,时长:%d",(int)second);
}


#pragma mark - 假装有数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"testCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"NO.%zi",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self tableViewScrollToBottom];
}

#pragma mark - 滑动到底部
- (void)tableViewScrollToBottom{
    [self.tableView reloadData];
    if ([self.tableView numberOfRowsInSection:0] == 0) return;
    NSInteger count = [self.tableView numberOfRowsInSection:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end
