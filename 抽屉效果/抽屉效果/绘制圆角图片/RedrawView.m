//
//  RedrawView.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/18.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "RedrawView.h"

@interface RedrawView ()

@property(nonatomic, strong)UIBezierPath *path;
@property(nonatomic, strong)CALayer *cellLayer;
@property(nonatomic, assign)CGPoint startP;
@property(nonatomic, strong)CAReplicatorLayer *replicatorLayer; // 复制层

@end


@implementation RedrawView

- (CAReplicatorLayer *)replicatorLayer {
    if (!_replicatorLayer) {
        _replicatorLayer = [CAReplicatorLayer layer];
        [self.layer addSublayer:_replicatorLayer];
    }
    return _replicatorLayer;
}


- (CALayer *)cellLayer {
    if (!_cellLayer) {
        _cellLayer = [CALayer layer];
        _cellLayer.backgroundColor = UIColor.whiteColor.CGColor;
        _cellLayer.cornerRadius = 5;
        [self.replicatorLayer addSublayer:_cellLayer];
    }
    return _cellLayer;
}


- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [UIColor.redColor set];
    [self.path stroke];
}


- (void)panAction:(UIPanGestureRecognizer *)pan {
    // 获取当前的点
    CGPoint currentP = [pan locationInView:self];
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.startP = currentP;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path setLineWidth:3];
        [path moveToPoint:currentP];
        self.path = path;
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        [self.path addLineToPoint:currentP];
        [self setNeedsDisplay];
    }
}


- (void)beginAction {
    self.replicatorLayer.frame = CGRectMake(0, 0, 10, 10);
    
    self.cellLayer.frame = CGRectMake(-10, -10, 10, 10);
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 5;
    animation.path = self.path.CGPath;
    [self.cellLayer addAnimation:animation forKey:nil];
    
    self.replicatorLayer.instanceCount = 20;
    self.replicatorLayer.instanceDelay = 0.25;
}


- (void)clearAction {
    [self.path removeAllPoints];
    [self setNeedsDisplay];
    [self.cellLayer removeFromSuperlayer];
    self.cellLayer = nil;
}

@end
