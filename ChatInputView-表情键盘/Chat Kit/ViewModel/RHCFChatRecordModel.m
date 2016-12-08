//
//  RHCFChatRecordModel.m
//  fusionWealthApp
//
//  Created by LeungChaos on 16/9/5.
//  Copyright © 2016年 rhcf. All rights reserved.
//

#import "RHCFChatRecordModel.h"
#import "RHCFRecord.h"

#import "UUProgressHUD.h"

@interface RHCFChatRecordModel ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, RHCFRecorderDelegate>

@property (weak, nonatomic) UIViewController * contro;

@property (weak, nonatomic) RHCFRecord * amrRecorder;

@property (weak, nonatomic) NSTimer *playTimer;

@property (assign, nonatomic) NSTimeInterval playTime;

@end

@implementation RHCFChatRecordModel

#pragma mark - 懒加载
- (RHCFRecord *)amrRecorder
{
    if (_amrRecorder == nil) {
        _amrRecorder = [RHCFRecord share];
        _amrRecorder.delegate = self;
    }
    return _amrRecorder;
}

+ (instancetype)recordModelWithControllerViewController:(UIViewController *)contro
{
    RHCFChatRecordModel *mod = [self new];
    mod.contro = contro;
    return mod;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.playTime = 0.0;
    }
    return self;
}

-(void)dealloc{
}


/* 录音 */
- (void)recordWithStatus:(RHCFRecordButtonStatus)status
{
    switch (status) {
        case RHCFRecordButtonStatusBegan:
            [self beginRecordVoice];
            break;
        case RHCFRecordButtonStatusCanceled:
            [self cancelRecordVoice];
            break;
        case RHCFRecordButtonStatusEnded:
            [self endRecordVoice];
            break;
        case RHCFRecordButtonStatusEntered:
            [self RemindDragEnter];
            break;
        case RHCFRecordButtonStatusExited:
            [self RemindDragExit];
            break;
        default:
            break;
    }
}

- (void)countVoiceTime
{
    self.playTime ++;
    if (self.playTime >= 60) {
        [self endRecordVoice];
    }
}

#pragma mark - 录音点击事件
- (void)beginRecordVoice
{
    [self.amrRecorder startRecord];
    //开始录音
    self.playTime = 0;
    self.playTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
    [UUProgressHUD show];
}

- (void)endRecordVoice
{
    if (self.playTimer) {
        [self.amrRecorder stopRecord];
        [self.playTimer invalidate];
    }
}

- (void)cancelRecordVoice
{
    if (self.playTimer) {
        [self.amrRecorder cancelRecord];
        [self.playTimer invalidate];
    }
    [UUProgressHUD dismissWithError:@"取消"];
}

- (void)RemindDragExit
{
    [UUProgressHUD changeSubTitle:@"取消发送"];
}

- (void)RemindDragEnter
{
    [UUProgressHUD changeSubTitle:@"上滑取消"];
}

#pragma mark - 功能键盘点击事件
- (void)buttonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self addCarema];
    } else if (buttonIndex == 1){
        [self openPicLibrary];
    }
}

-(void)addCarema{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.contro presentViewController:picker animated:YES completion:nil];
    }else{
        NSLog(@"Your device don't have camera");
    }
}

-(void)openPicLibrary{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.contro presentViewController:picker animated:YES completion:^{
        }];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(recordModelSendPicture:)]) {
            [self.delegate recordModelSendPicture:editImage];
        }
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - RHCFRecorderDelegate
- (void)beginConvert{
    NSLog(@"开始转换的代理");
}

//回调录音资料
- (void)endConvertWithData:(NSData *)voiceData
{
    [self.delegate recordModelSendVoice:voiceData time:self.playTime + 1];
    [UUProgressHUD dismissWithSuccess:@"成功"];
    
    //缓冲消失时间 (最好有block回调消失完成)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}

- (void)failRecord
{
    [UUProgressHUD dismissWithSuccess:@"录音时间过短"];
    //缓冲消失时间 (最好有block回调消失完成)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}



@end


