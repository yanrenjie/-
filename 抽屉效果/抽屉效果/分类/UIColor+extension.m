//
//  UIColor+extension.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/11.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "UIColor+extension.h"

@implementation UIColor (extension)

+ (UIColor *)adaptDarkModeWithColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    UIColor *color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
        if (@available(iOS 13, *)) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return darkColor;
            }
        }
        return lightColor;
    }];
    return color;
}

@end
