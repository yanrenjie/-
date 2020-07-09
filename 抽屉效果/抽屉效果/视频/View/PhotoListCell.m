//
//  PhotoListCell.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/10.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "PhotoListCell.h"

@interface PhotoListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *maskImageView;

@end

@implementation PhotoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cellImageView.contentMode = UIViewContentModeScaleAspectFill;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setDataWithModel:(PHAssetCollection *)cellModel mask:(BOOL)mask {
    self.cellTitleLabel.text = cellModel.localizedTitle;
    self.cellCountLabel.text = [NSString stringWithFormat:@"(%ld)", cellModel.estimatedAssetCount];
    if (mask) {
        self.maskImageView.hidden = NO;
    } else {
        self.maskImageView.hidden = YES;
    }
}


- (void)setCellImage:(UIImage *)image {
    self.cellImageView.image = image;
}

@end
