//
//  PhotoListCell.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/10.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoListCell : UITableViewCell

- (void)setDataWithModel:(PHAssetCollection *)cellModel mask:(BOOL)mask;

- (void)setCellImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
