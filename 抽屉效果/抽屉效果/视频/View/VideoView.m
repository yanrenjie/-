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
        [self setupUI];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chanageBgImage) name:@"VideoWillPlayingNotification" object:nil];
    }
    return self;
}


- (void)setupUI {
    [self addSubview:self.tableView];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
    cell.cellModel = self.modelArray[indexPath.row];
    return cell;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = (NSInteger)(scrollView.contentOffset.y / self.tableView.frame.size.height);
    // 判断是否应该切换播放源
    if (index != self.currentVideoIndex) {
        VideoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentVideoIndex inSection:0]];
        [cell showBgImageView];
        [self.playerLayer removeFromSuperlayer];
        self.currentVideoIndex = index;
        VideoModel *model = self.modelArray[self.currentVideoIndex];
        [self.playerManager changeVideoWithURL:[NSURL URLWithString:model.videoURL]];
        VideoCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentVideoIndex inSection:0]];
        [cell1 hiddenBgImageView];
        [cell1.contentView.layer insertSublayer:self.playerLayer atIndex:0];
    }
}


- (void)setModelArray:(NSArray<VideoModel *> *)modelArray {
    _modelArray = modelArray;
    [self.tableView reloadData];
    VideoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.contentView.layer insertSublayer:self.playerLayer atIndex:0];
    VideoModel *model = self.modelArray.firstObject;
    [self.playerManager changeVideoWithURL:[NSURL URLWithString:model.videoURL]];
}

// 隐藏图片
- (void)chanageBgImage {
    VideoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentVideoIndex inSection:0]];
    [cell hiddenBgImageView];
}


@end
