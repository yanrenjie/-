//
//  MyProgressView.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/13.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "MyProgressView.h"

@interface MyProgressView ()

@end

@implementation MyProgressView

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self addObserver:self forKeyPath:@"progressValue" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self addObserver:self forKeyPath:@"progressValue" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    // 通过setNeedsDisplay方法，强制重绘制View
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.frame.size.width / 2, 10)];
    CGFloat endAngle = self.progressValue * 2 * M_PI - M_PI_2;
    [path addArcWithCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.width / 2) radius:(self.frame.size.width - 20) / 2 startAngle:-M_PI_2 endAngle:endAngle clockwise:YES];
    [[UIColor redColor] set];
    [path stroke];
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"progressValue"];
}

@end
