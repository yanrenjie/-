//
//  VideoView.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/28.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoModel;
NS_ASSUME_NONNULL_BEGIN

@interface VideoView : UIView

@property(nonatomic, strong)NSArray<VideoModel *> *modelArray;

- (void)pausePlay;

- (void)startPlay;

@end

NS_ASSUME_NONNULL_END
