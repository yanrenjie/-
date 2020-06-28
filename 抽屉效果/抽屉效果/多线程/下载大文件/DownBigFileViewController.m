//
//  DownBigFileViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/23.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "DownBigFileViewController.h"
#import "MyProgressView.h"
#import <AVFoundation/AVFoundation.h>

@interface DownBigFileViewController ()<NSURLSessionDataDelegate>
@property (weak, nonatomic) IBOutlet MyProgressView *progressView;

@property(nonatomic, strong)NSFileHandle *handle;

@property(nonatomic, assign)NSInteger totalSize;
@property(nonatomic, assign)NSInteger currentSize;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property(nonatomic, strong)AVPlayer *player;
@property(nonatomic, strong)AVPlayerItem *item;
@property(nonatomic, strong)NSURLSession *session;
@property(nonatomic, strong)NSURLSessionDataTask *dataTask;

@end

@implementation DownBigFileViewController

- (NSURLSession *)session {
    if (!_session) {
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        _session = session;
    }
    return _session;
}


- (NSURLSessionDataTask *)dataTask {
    if (!_dataTask) {
        NSURL *url = [NSURL URLWithString:@"http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        // 设置请求范围
        /**
         Range:
         bytes=0-100            下载从开头到100个字节返回内的数据
         bytes=-100             下载从开头到100个字节返回内的数据
         bytes=100-4000         下载从100开始到4000范围内的数据
         bytes=4000-            下载从4000开始到最后的数据
         */
        NSString *string = [NSString stringWithFormat:@"bytes=%ld-", self.currentSize];
        [request setValue:string forHTTPHeaderField:@"Range"];
        
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request];
        _dataTask = dataTask;
    }
    return _dataTask;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"love4.mp4"];
    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    self.currentSize = [dict fileSize];
    
//    CGFloat value = 1.0 * self.currentSize / self.totalSize;
//    self.progressView.progressValue = value;
//    self.progressLabel.text = [NSString stringWithFormat:@"已下载%.2f%%", value * 100];
    NSLog(@"%@", dict);
}

// 要实现三个代理方法，并监听下载进度
// 接收到响应的时候调用
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    // 获取总的下载数据的大小
    self.totalSize = response.expectedContentLength + self.currentSize;
    
    
    NSLog(@"%ld", self.totalSize);
    
    // [response suggestedFilename]， 获取URL最后一个节点的名称，作为文件名
    // 创建文件路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"love4.mp4"];
    NSLog(@"%@", filePath);
    // 根据路径创建文件
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    // 创建一个文件b句柄,句柄默认是指向文件的开始的，这里需要将指针指向上次取消的位置
    _handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    // 移动指针到上次的位置或者移动到文件的末尾
    // 移动到文件的末尾
    [_handle seekToEndOfFile];
    // 移动指针到指定的位置
//    [_handle seekToFileOffset:self.currentSize];
    // 要允许请求
    completionHandler(NSURLSessionResponseAllow);
}


// 接受到数据就调用，这个方法会调用很多次
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    self.currentSize += data.length;
    CGFloat value = 1.0 * self.currentSize / self.totalSize;
    self.progressView.progressValue = value;
    [self.handle writeData:data];
    self.progressLabel.text = [NSString stringWithFormat:@"已下载%.2f%%", value * 100];
}


// 下载完成或者下载出错的时候调用
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    [self.handle closeFile];
    if (error == nil) {
        NSLog(@"下载完毕，请尽情观看");
        [self playAction];
    } else {
        if (error.code == -999) {
            NSLog(@"下载已经被取消了");
        }
    }
}


#pragma mark - 文件的下载，取消，恢复等操作
// 开始下载
- (IBAction)startDownload:(id)sender {
    [self.dataTask resume];
}
// 暂停下载
- (IBAction)suspendDownload:(id)sender {
    [self.dataTask suspend];
}
// 取消下载， 暂停取消下载后，是不能恢复继续下载的,要实现断点继续下载，应该在请求头里面设置请求数据的范围
- (IBAction)cancelDownload:(id)sender {
    [self.dataTask cancel];
    
    // 已经取消了的任务，不能重新再执行，为了保证继续执行，应该将任务情况，然后重新创建
    self.dataTask = nil;
}
// 恢复继续下载
- (IBAction)resumeDownload:(id)sender {
    [self.dataTask resume];
}

- (void)playAction {
    // 创建文件路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//    NSString *filePath1 = [path stringByAppendingPathComponent:@"love1.mp4"];
//    NSString *filePath2 = [path stringByAppendingPathComponent:@"love2.mp4"];
//    NSData *data1 = [NSData dataWithContentsOfFile:filePath1];
//    NSData *data2 = [NSData dataWithContentsOfFile:filePath2];
//    NSMutableData *newData = [NSMutableData dataWithData:data1];
//    [newData appendData:data2];
//    [newData writeToFile:[path stringByAppendingPathComponent:@"love3.mp4"] atomically:YES];
    
    NSURL *url = [NSURL fileURLWithPath:[path stringByAppendingPathComponent:@"love4.mp4"]];
//    NSURL *url1 = [NSURL URLWithDataRepresentation:newData relativeToURL:url];
//    NSURL *url = [NSURL fileURLWithPath:filePath];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    layer.backgroundColor = UIColor.lightGrayColor.CGColor;
    layer.frame = CGRectMake(0, 0, SW, 174);
    [self.view.layer addSublayer:layer];
    [player play];

    self.player = player;
    self.item = item;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.player) {
        [self.player pause];
        [self.item cancelPendingSeeks];
        self.player = nil;
        self.item = nil;
    }
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.session finishTasksAndInvalidate];
}

- (void)dealloc {
    NSLog(@"%@", [self class]);
}


// https://8xgqu.com/mp4/ecb7cf83b18446ed859126ddad0c6128.mp4

//https://8xgqu.com/mp4/b7b564b011894e1cae044fcbe0500552.mp4

@end
