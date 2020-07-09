//
//  AVCaptureViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/9.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "AVCaptureViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AVCaptureViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureFileOutputRecordingDelegate, AVCaptureAudioDataOutputSampleBufferDelegate>

@property(nonatomic, strong)AVCaptureSession *session;
@property(nonatomic, strong)dispatch_queue_t videoQueue;
@property(nonatomic, strong)dispatch_queue_t audioQueue;
@property(nonatomic, strong)AVCaptureConnection *videoConnetion;
@property(nonatomic, strong)AVCaptureConnection *audioConnection;
@property(nonatomic, strong)AVCaptureMovieFileOutput *fileVideoOutput;
@property(nonatomic, strong)AVCaptureDeviceInput *videoInput;

@end

@implementation AVCaptureViewController

#pragma mark - 懒加载
- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}

- (dispatch_queue_t)videoQueue {
    if (!_videoQueue) {
        _videoQueue = dispatch_queue_create("com.jackey.video", DISPATCH_QUEUE_CONCURRENT);
    }
    return _videoQueue;
}

- (dispatch_queue_t)audioQueue {
    if (!_audioQueue) {
        _audioQueue = dispatch_queue_create("com.jackey.audio", DISPATCH_QUEUE_CONCURRENT);
    }
    return _audioQueue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
}


#pragma mark - 开始捕捉会话
- (void)startCapture {
    // 设置视频捕捉会话
    [self setupVideoCapture];
    
    // 设置音频捕捉会话信息
    [self setupAudioCapture];
    
    // 开始捕捉会话
    [self.session startRunning];
    
    // 开始记录写入文件, 注意，这里只是写入了视频数据，没有写入音频数据
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"movie.mp4"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    [self.fileVideoOutput startRecordingToOutputFileURL:url recordingDelegate:self];
}


// 设置视频捕捉
- (void)setupVideoCapture {
    // 1、获取输入设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
    
    // 2、获取输入源
    AVCaptureDeviceInput *videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    self.videoInput = videoInput;
    
    // 3、给捕捉会话设置输入源
    [self.session addInput:videoInput];
    
    // 4、给捕捉会话设置输出源
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    [output setSampleBufferDelegate:self queue:self.audioQueue];
    // 用来区别当接受到数据的时候，区别是视频数据，还是音频数据
    AVCaptureConnection *connection = [output connectionWithMediaType:AVMediaTypeVideo];
    self.videoConnetion = connection;
    
    // 输出文件中
    AVCaptureMovieFileOutput *fileVideoOutput = [[AVCaptureMovieFileOutput alloc] init];
    AVCaptureConnection *fileConnetion = [fileVideoOutput connectionWithMediaType:AVMediaTypeVideo];
    // 设置文件的写入文件的稳定性
    fileConnetion.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
    [self.session addOutput:fileVideoOutput];
    _fileVideoOutput = fileVideoOutput;
    
    [self.session addOutput:output];
    
    // 5、给用户创建一个可以预览的图片
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:previewLayer atIndex:0];
}


// 设置音频捕捉
- (void)setupAudioCapture {
    // 获取输入设备
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
    // 设置输入源
    AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];
    [self.session addInput:audioInput];
    
    // 设置输出源
    AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc] init];
    [audioOutput setSampleBufferDelegate:self queue:self.audioQueue];
    [self.session addOutput:audioOutput];
    
    AVCaptureConnection *audioConnection = [audioOutput connectionWithMediaType:AVMediaTypeAudio];
    self.audioConnection = audioConnection;
}


- (void)stopCapture {
    if (self.session.isRunning) {
        [self.session stopRunning];
    }
}


#pragma mark - 切换摄像头，前置摄像头和后置摄像头
- (void)switchCameraPosition {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:self.videoInput.device.position == AVCaptureDevicePositionBack ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 切换摄像头的时候，需要配置
    [self.session beginConfiguration];
    // 移除之前的视频输入源
    [self.session removeInput:self.videoInput];
    // 重新添加一个输入源
    [self.session addInput:input];
    
    // 提交配置信息
    [self.session commitConfiguration];
    
    // 将新的输入源赋值进行引用
    self.videoInput = input;
}


#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
// 接受到采集的数据调用的方法
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    // 接收到视频数据
    if (connection == self.videoConnetion) {
        
    }
    // 接受到音频数据
    else if (connection == self.audioConnection) {
        
    }
}


#pragma mark - AVCaptureFileOutputRecordingDelegate
// 开始写入文件的时候，调用的方法
- (void)captureOutput:(AVCaptureFileOutput *)output didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections {
    NSLog(@"开始写入");
}

- (void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(NSError *)error {
    NSLog(@"写入完毕");
}

@end
