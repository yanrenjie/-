//
//  MineViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/29.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "MineViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0200fb10000bq79p37m1hfat4s36r1g&ratio=720p&line=0
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"https://v3-tt.ixigua.com/6ace2026a588457e3ba3aec16e9aac41/5ef9cd0f/video/tos/cn/tos-cn-ve-15/d5df9d1f7e2242659492e7803f3c1b7d/?a=1768&br=3708&bt=1236&cr=0&cs=0&dr=0&ds=3&er=0&l=20200629181407010022027028070A800E&lr=default&mime_type=video_mp4&qs=0&rc=M2Q8N2c2NXl3dTMzaWkzM0ApNzs4ZzZmaTxoNzRmZ2g5M2dxa141L3NxbW5fLS0xLS9zc2EzMWItNl9hM2IwNjIyYTE6Yw%3D%3D&vl=&vr="]];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];
    [player play];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
