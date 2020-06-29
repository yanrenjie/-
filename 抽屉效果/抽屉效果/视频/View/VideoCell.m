//
//  VideoCell.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/28.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "VideoCell.h"
#import "VideoModel.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIImageView *playImageView;
@property (weak, nonatomic) IBOutlet UIImageView *followImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *musicLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
@property (weak, nonatomic) IBOutlet UIButton *forwardBtn;

@end

@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.playImageView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellModel:(VideoModel *)cellModel {
    _cellModel = cellModel;
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", cellModel.videoId]];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    if (image) {
        self.bgImageView.image = image;
    } else {
        [self getVideoPreViewImage:cellModel.videoURL];
    }
    
    self.headImageView.image = [UIImage imageNamed:_cellModel.headImageName];
    if (_cellModel.like) {
        [_likeBtn setImage:[UIImage imageNamed:@"hart_p"] forState:UIControlStateNormal];
    } else {
        [_likeBtn setImage:[UIImage imageNamed:@"hart_n"] forState:UIControlStateNormal];
    }
    
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%ld", _cellModel.likeNumber] forState:UIControlStateNormal];
    [self.replyBtn setTitle:[NSString stringWithFormat:@"%ld", _cellModel.replyNumber] forState:UIControlStateNormal];
    [self.forwardBtn setTitle:[NSString stringWithFormat:@"%ld", _cellModel.forwordNumber] forState:UIControlStateNormal];
    self.userNameLabel.text = _cellModel.userName;
    self.contentLabel.text = _cellModel.content;
}

- (void)hiddenBgImageView {
    [UIView animateWithDuration:0.25 animations:^{
        self.bgImageView.alpha = 0;
    }];
}


- (void)showBgImageView {
    self.bgImageView.alpha = 1;
}


// 获取视频第一帧
- (void)getVideoPreViewImage:(NSString *)urlString {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:urlString];
        AVAsset *asset = [AVAsset assetWithURL:url];
        AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];

        assetGen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.bgImageView.image = videoImage;
        });
        
        // 缓存图片
        NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
        NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", self.cellModel.videoId]];
        NSLog(@"%@", filePath);
        NSData *imageData = UIImageJPEGRepresentation(videoImage, 0.1);
        [imageData writeToFile:filePath atomically:NO];
    });
}

@end
