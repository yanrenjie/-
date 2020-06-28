//
//  SmallVideoViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/28.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "SmallVideoViewController.h"
#import "VideoView.h"

@interface SmallVideoViewController ()

@property(nonatomic, strong)UIImageView *imageView;

@end

@implementation SmallVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    VideoView *videoView = [[VideoView alloc] initWithFrame:CGRectMake(0, -44, SW, SH - 83 + 44)];
    videoView.backgroundColor = UIColor.redColor;
    [self.view addSubview:videoView];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 300, SW, 250);
    }
    return _imageView;
}

// 获取视频第一帧
//- (UIImage*)getVideoPreViewImage {
//    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:self.set];
//
//    assetGen.appliesPreferredTrackTransform = YES;
//    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
//    NSError *error = nil;
//    CMTime actualTime;
//    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
//    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
//    CGImageRelease(image);
//    return videoImage;
//}

@end
