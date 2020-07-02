//
//  MusicView.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/2.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "MusicView.h"

@interface MusicView ()

@property(nonatomic, strong)UIView *mucisBgView;
@property(nonatomic, strong)UIImageView *userImageView;
@property(nonatomic, strong)CALayer *musicLayer1;
@property(nonatomic, strong)CALayer *musicLayer2;
@property(nonatomic, strong)CALayer *musicLayer3;

@end

@implementation MusicView

- (UIView *)mucisBgView {
    if (!_mucisBgView) {
        _mucisBgView = [[UIView alloc] init];
        _mucisBgView.backgroundColor = RGBColor(52, 52, 52);
        _mucisBgView.layer.masksToBounds = YES;
        _mucisBgView.layer.cornerRadius = 25;
    }
    return _mucisBgView;
}


- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.layer.masksToBounds = YES;
        _userImageView.layer.cornerRadius = 15;
        _userImageView.image = [UIImage imageNamed:@"liuyifei3"];
    }
    return _userImageView;
}

- (CALayer *)musicLayer1 {
    if (!_musicLayer1) {
        _musicLayer1 = [CALayer layer];
        _musicLayer1.contents = (id)[UIImage imageNamed:@"music_b"].CGImage;
        [self addKeyPathForLayer:_musicLayer1 key:@"musicLayer1" delay:0];
    }
    return _musicLayer1;
}

- (CALayer *)musicLayer2 {
    if (!_musicLayer2) {
        _musicLayer2 = [CALayer layer];
        _musicLayer2.contents = (id)[UIImage imageNamed:@"music_b"].CGImage;
        [self addKeyPathForLayer:_musicLayer2 key:@"musicLayer2" delay:1];
    }
    return _musicLayer2;
}

- (CALayer *)musicLayer3 {
    if (!_musicLayer3) {
        _musicLayer3 = [CALayer layer];
        _musicLayer3.contents = (id)[UIImage imageNamed:@"music_a"].CGImage;
        [self addKeyPathForLayer:_musicLayer3 key:@"musicLayer3" delay:2];
    }
    return _musicLayer3;
}

- (void)addKeyPathForLayer:(CALayer *)musicLayer key:(NSString *)key delay:(CGFloat)delay {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.frame.size.width / 4 * 3, self.frame.size.height - 5)];
    [path addQuadCurveToPoint:CGPointMake(0, self.frame.size.width / 4) controlPoint:CGPointMake(0, self.frame.size.height)];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *b = [CABasicAnimation animation];
    b.keyPath = @""
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.duration = 3;
    animation.repeatCount = INT_MAX;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [musicLayer addAnimation:animation forKey:key];
    });
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = UIColor.clearColor;
    [self addSubview:self.mucisBgView];
    [self.mucisBgView addSubview:self.userImageView];
    
    [self.layer addSublayer:self.musicLayer1];
    [self.layer addSublayer:self.musicLayer2];
    [self.layer addSublayer:self.musicLayer3];
    
    self.mucisBgView.frame = CGRectMake(self.frame.size.width / 2 - 10, self.frame.size.width / 2 - 10, self.frame.size.width / 2, self.frame.size.width / 2);
    
    self.userImageView.frame = CGRectMake(10, 10, self.mucisBgView.frame.size.width - 20, self.mucisBgView.frame.size.width - 20);
    
    self.musicLayer1.frame = CGRectMake(self.frame.size.width - self.frame.size.width / 4 - 15, self.frame.size.height - 10, 10, 10);
    self.musicLayer2.frame = CGRectMake(self.frame.size.width - self.frame.size.width / 4 - 15, self.frame.size.height - 10, 10, 10);
    self.musicLayer3.frame = CGRectMake(self.frame.size.width - self.frame.size.width / 4 - 15, self.frame.size.height - 10, 10, 10);
}


- (void)dealloc {
    [self.musicLayer1 removeAnimationForKey:@"musicLayer1"];
    [self.musicLayer2 removeAnimationForKey:@"musicLayer2"];
    [self.musicLayer3 removeAnimationForKey:@"musicLayer3"];
}

@end
