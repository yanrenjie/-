//
//  VideoView.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/28.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "VideoView.h"
#import "VideoPlayerManager.h"
#import "VideoCell.h"
#import "VideoModel.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoView ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, assign)CGFloat beginOffset;
@property(nonatomic, assign)CGFloat endOffset;
@property(nonatomic, assign)NSInteger pageIndex;
@property(nonatomic, assign)NSInteger currentVideoIndex;
@property(nonatomic, strong)VideoPlayerManager *playerManager;

@property(nonatomic, strong)AVPlayerLayer *playerLayer;

@end

@implementation VideoView

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SW, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = self.frame.size.height;
        [_tableView registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];
        _tableView.pagingEnabled = YES;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _tableView;
}


- (AVPlayerLayer *)playerLayer {
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.playerManager.player];
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _playerLayer.frame = self.bounds;
    }
    return _playerLayer;
}

- (VideoPlayerManager *)playerManager {
    if (!_playerManager) {
        _playerManager = [[VideoPlayerManager alloc] init];
    }
    return _playerManager;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.pageIndex = 0;
        self.currentVideoIndex = 0;
        [self addSubview:self.tableView];
    }
    return self;
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
    cell.cellModel = self.modelArray[indexPath.row];
    __weak typeof(self) weakSelf = self;
    cell.updatePlayStatus = ^(BOOL status) {
        if (status) {
            [weakSelf.playerManager pausePlay];
        } else {
            [weakSelf.playerManager startPlay];
        }
    };
    return cell;
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = (NSInteger)(scrollView.contentOffset.y / self.tableView.frame.size.height);
    // 判断是否应该切换播放源
    if (index != self.currentVideoIndex) {
        [self.playerLayer removeFromSuperlayer];
        self.currentVideoIndex = index;
        VideoModel *model = self.modelArray[self.currentVideoIndex];
        [self.playerManager changeVideoWithURLString:model.videoURL];
        
        VideoCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentVideoIndex inSection:0]];
        [cell1 addVideoPlayLayerAboveBgImageLayer:self.playerLayer];
    }
}


- (void)setModelArray:(NSArray<VideoModel *> *)modelArray {
    _modelArray = modelArray;
    [self.tableView reloadData];
    VideoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    VideoModel *model = self.modelArray.firstObject;
    [self.playerManager changeVideoWithURLString:model.videoURL];
    [cell addVideoPlayLayerAboveBgImageLayer:self.playerLayer];
}


- (void)pausePlay {
    [self.playerManager pausePlay];
}

- (void)startPlay {
    [self.playerManager startPlay];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 1、判断自己是否能响应事件
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) {
        return nil;
    }
    
    // 2、判断点是不是在自己身上
    if (![self pointInside:point withEvent:event]) {
        return nil;
    }
    
    // 3、从后往前遍历自己的子控件，把事件传递给子控件，调用子控件的hitTest方法
    int count = (int)self.subviews.count;
    for (int i = count - 1; i >= 0; i--) {
        // 获取子控件
        UIView *childView = self.subviews[i];
        
        // 把当前点的坐标转换为子控件的坐标系
        CGPoint newPoint = [self convertPoint:point toView:childView];
        
        UIView *fitView = [childView hitTest:newPoint withEvent:event];
        // 如果找到最合适的View，就返回
        if (fitView) {
            return fitView;
        }
    }
    
    // 子控件中都没找到，那就当前控件就是最合适的响应对象
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"1111");
}

@end
