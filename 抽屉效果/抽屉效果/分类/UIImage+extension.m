//
//  UIImage+extension.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/11.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "UIImage+extension.h"

@implementation UIImage (extension)

- (UIImage *)cornerImage {
    return [self drawImageWithRadius:self.size.height * 0.5 imageSize:self.size];
}


- (UIImage *)cornerImageWithRadius:(CGFloat)radius {
    return [self drawImageWithRadius:radius imageSize:self.size];
}

- (UIImage *)cornerImageWithRadius:(CGFloat)radius imageSize:(CGSize)imageSize {
    return [self drawImageWithRadius:radius imageSize:imageSize];
}


- (UIImage *)drawImageWithRadius:(CGFloat)radius imageSize:(CGSize)imageSize {
    UIGraphicsBeginImageContext(imageSize);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageSize.width, imageSize.height) cornerRadius:radius];
    [path addClip];
    [self drawAtPoint:CGPointZero];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
