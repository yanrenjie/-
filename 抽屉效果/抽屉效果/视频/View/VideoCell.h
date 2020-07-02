//
//  VideoCell.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/28.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UpdatePlayStatus)(BOOL);

@class VideoModel;

NS_ASSUME_NONNULL_BEGIN

@interface VideoCell : UITableViewCell

@property(nonatomic, strong)VideoModel *cellModel;

@property(nonatomic, copy)UpdatePlayStatus updatePlayStatus;

- (void)addVideoPlayLayerAboveBgImageLayer:(CALayer *)playLayer;

@end

NS_ASSUME_NONNULL_END
