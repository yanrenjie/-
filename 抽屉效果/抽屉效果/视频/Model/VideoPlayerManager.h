//
//  VideoPlayerManager.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/29.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayerManager : NSObject

@property(nonatomic, strong)AVPlayer *player;

- (void)pausePlay;

- (void)startPlay;

- (void)changeVideoWithURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
