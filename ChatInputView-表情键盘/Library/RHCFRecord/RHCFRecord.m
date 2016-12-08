//
//  RHCFRecord.m
//  fusionWealthApp
//
//  Created by rhcf_wujh on 16/7/27.
//  Copyright © 2016年 rhcf. All rights reserved.
//

#import "RHCFRecord.h"

#import "VoiceConverter.h"

@interface RHCFRecord ()

@property (nonatomic, strong) AVAudioRecorder * recorder;
//@property (nonatomic, strong) AVAudioPlayer   * player;
@property (nonatomic, strong) NSString        * recordFilePath;
@property (nonatomic, strong) NSString        * amrFilePath;
@property (nonatomic ,strong) NSString        * convertedPath;

@end

@implementation RHCFRecord

+(RHCFRecord *)share {
    static dispatch_once_t pred;
    static RHCFRecord *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[RHCFRecord alloc] init];
    });
    return shared;
}

#pragma mark - getter
//- (AVAudioPlayer *)player{
//    if (!_player) {
//        _player = [[AVAudioPlayer alloc]init];
//    }
//    return _player;
//}

- (NSString *)recordFilePath{
    if (!_recordFilePath) {
        _recordFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"chat_message_tmp.wav"];
    }
    return _recordFilePath;
}

- (NSString *)amrFilePath{
    if (!_amrFilePath) {
        _amrFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"chat_message_tmp.amr"];
    }
    return _amrFilePath;
}

- (NSString *)convertedPath{
    if (!_convertedPath) {
        _convertedPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"chat_message_tmp_new.wav"];
    }
    return _convertedPath;
}

#pragma mark - Public Method
- (void)startRecord{
    [self deleteFileWithPath:self.recordFilePath];
    [self deleteFileWithPath:self.amrFilePath];
    self.recorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:self.recordFilePath] settings:[VoiceConverter GetAudioRecorderSettingDict] error:nil];
    if ([self.recorder prepareToRecord]) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        if ([self.recorder record]) {
            NSLog(@"开始录音");
        }
    }
}

- (void)stopRecord{
    double cTime = _recorder.currentTime;
    [_recorder stop];
    
    if (cTime > 1) {
        [self audio_WAVToAmr];
    }else {
        
        [_recorder deleteRecording];
        
        if ([_delegate respondsToSelector:@selector(failRecord)]) {
            [_delegate failRecord];
        }
    }
}

- (void)cancelRecord{
    [_recorder stop];
    [_recorder deleteRecording];
}


#pragma mark - Private Method
- (void)audio_WAVToAmr{
    NSLog(@"audio_WAVToAmr转换开始");
    if (_delegate && [_delegate respondsToSelector:@selector(beginConvert)]) {
        [_delegate beginConvert];
    }
    if ([VoiceConverter ConvertWavToAmr:self.recordFilePath amrSavePath:self.amrFilePath]) {
        NSLog(@"wav To amr Success");
        if (_delegate && [_delegate respondsToSelector:@selector(endConvertWithData:)]) {
            NSData *voiceData = [NSData dataWithContentsOfFile:[self amrFilePath]];
            [_delegate endConvertWithData:voiceData];
        }
    }
    else {
        NSLog(@"警告：录音转换失败");
    }
}

- (void)deleteFileWithPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager removeItemAtPath:path error:nil])
    {
        NSLog(@"删除以前的录音文件:%@",path);
    }
}
#pragma mark 获取音频文件信息
- (NSString *)getVoiceFileInfoByPath:(NSString *)aFilePath convertTime:(NSTimeInterval)aConTime{
    
    NSInteger size = [self getFileSize:aFilePath]/1024;
    NSString *info = [NSString stringWithFormat:@"文件名:%@\n文件大小:%ldkb\n",aFilePath.lastPathComponent,(long)size];
    
    NSRange range = [aFilePath rangeOfString:@"wav"];
    if (range.length > 0) {
        AVAudioPlayer *play = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:aFilePath] error:nil];
        info = [info stringByAppendingFormat:@"文件时长:%f\n",play.duration];
    }
    
    if (aConTime > 0)
        info = [info stringByAppendingFormat:@"转换时间:%f",aConTime];
    return info;
}
#pragma mark 获取文件大小
- (NSInteger) getFileSize:(NSString*) path{
    NSFileManager * filemanager = [[NSFileManager alloc]init];
    if([filemanager fileExistsAtPath:path]){
        NSDictionary * attributes = [filemanager attributesOfItemAtPath:path error:nil];
        NSNumber *theFileSize;
        if ( (theFileSize = [attributes objectForKey:NSFileSize]) )
            return  [theFileSize intValue];
        else
            return -1;
    }
    else{
        return -1;
    }
}


@end
