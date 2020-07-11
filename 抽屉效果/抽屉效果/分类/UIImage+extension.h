//
//  UIImage+extension.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/11.
//  Copyright © 2020 Jackey. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (extension)

- (UIImage *)cornerImage;

- (UIImage *)cornerImageWithRadius:(CGFloat)radius;

- (UIImage *)cornerImageWithRadius:(CGFloat)radius imageSize:(CGSize)imageSize;

@end

NS_ASSUME_NONNULL_END
