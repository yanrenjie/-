//
//  VideoPlayerManager.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/29.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "VideoPlayerManager.h"

@interface VideoPlayerManager ()

@end

@implementation VideoPlayerManager

- (AVPlayer *)player {
    if (!_player) {
        _player = [[AVPlayer alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        [_player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _player;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus value = [change[@"new"] integerValue];
        switch (value) {
            case AVPlayerItemStatusReadyToPlay:
                [self.player play];
                break;
            case AVPlayerItemStatusUnknown:
            
            break;
            case AVPlayerItemStatusFailed:
        
                break;
                
            default:
                break;
        }
    }
}


- (void)changeVideoWithURLString:(NSString *)urlString {
    [self pausePlay];
    NSString *path = [[NSBundle mainBundle] pathForResource:urlString ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    AVAsset *asset = [AVAsset assetWithURL:url];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    [self startPlay];
}


- (void)startPlay {
    [self.player play];
}


- (void)pausePlay {
    [self.player pause];
}

- (void)videoPlayEnd {
    [self.player seekToTime:kCMTimeZero];
    [self startPlay];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
