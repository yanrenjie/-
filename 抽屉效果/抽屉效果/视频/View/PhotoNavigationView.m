//
//  PhotoNavigationView.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/9.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "PhotoNavigationView.h"

@interface PhotoNavigationView ()

@property(nonatomic, assign)BOOL flag;
@property (weak, nonatomic) IBOutlet UIButton *recentBtn;
@property(nonatomic, assign)CGFloat defaultAngle;

@end

@implementation PhotoNavigationView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.recentBtn.adjustsImageWhenHighlighted = NO;
    self.defaultAngle = 0;
}

+ (instancetype)photoNavigationView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (IBAction)cancelAction:(id)sender {
    if (self.cancelAction) {
        self.cancelAction();
    }
}


- (IBAction)recentProject {
    [self recentButtonClick];
}


- (void)recentButtonClickOut {
    [self recentButtonClick];
}


- (void)recentButtonClick {
    self.flag = !self.flag;
    UIImageView *imageView = self.recentBtn.imageView;
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 0.2;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = @(self.flag ? 0 : M_PI);
    animation.toValue = @(self.flag ? M_PI : M_PI * 2);
    [imageView.layer addAnimation:animation forKey:@"recentProject"];
    if (self.recentProjectBlock) {
        self.recentProjectBlock(self.recentBtn, self.flag);
    }
}

- (void)setButtonTitleWithString:(NSString *)string {
    [self.recentBtn setTitle:string forState:UIControlStateNormal];
}

- (void)dealloc {
    NSLog(@"dealloc  ----   %@  ---- 成功啦， 哈哈哈😂", [self class]);
    [self.recentBtn.imageView.layer removeAllAnimations];
}

@end
