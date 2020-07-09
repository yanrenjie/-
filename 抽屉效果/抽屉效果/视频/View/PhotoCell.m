//
//  PhotoCell.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/9.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end

@implementation PhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.myImageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setImageWithImage:(UIImage *)image {
    self.myImageView.image = image;
}

@end
