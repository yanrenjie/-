//
//  PhotoTabView.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/9.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "PhotoTabView.h"

@implementation PhotoTabView

+ (instancetype)photoTabView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

@end
