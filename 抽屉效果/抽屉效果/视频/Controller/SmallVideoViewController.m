//
//  SmallVideoViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/28.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "SmallVideoViewController.h"
#import "VideoView.h"
#import "VideoModel.h"

@interface SmallVideoViewController ()

@property(nonatomic, strong)VideoView *videoView;

@property(nonatomic, strong)UIImageView *imageView;

@property(nonatomic, strong)NSArray *videoModelArray;

@end

@implementation SmallVideoViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.videoView pausePlay];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.videoView startPlay];
}

- (NSArray *)videoModelArray {
    if (!_videoModelArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"videos.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in array) {
            VideoModel *model = [VideoModel videoModelWithDict:dict];
            [tempArray addObject:model];
        }
        _videoModelArray = tempArray;
    }
    return _videoModelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    VideoView *videoView = [[VideoView alloc] initWithFrame:CGRectMake(0, -44, SW, SH - 83 + 44)];
    videoView.modelArray = self.videoModelArray;
    videoView.backgroundColor = UIColor.redColor;
    [self.view addSubview:videoView];
    self.videoView = videoView;
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


@end
