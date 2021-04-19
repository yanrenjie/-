//
//  JieAnimationTransition.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/14.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "JieAnimationTransition.h"

@interface JieAnimationTransition ()<UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign)BOOL isPresent; // 是present还是dismiss操作

@end

@implementation JieAnimationTransition


#pragma mark - UIViewControllerAnimatedTransitioning
// 返回动画的执行时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}


// 当写了这个方法，就是说明，模态的动画是有程序员自己来提供
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (_isPresent) {
        [self presentAnimation:transitionContext];
    } else {
        [self dismissAnimation:transitionContext];
    }
}

// 程序员自己实现的present动画的操作
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [transitionContext.containerView addSubview:toView];
    
    toView.alpha = 0;
    toView.frame = CGRectMake(SW * 0.5, SH * 0.5, 0, 0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = CGRectMake(0, 0, SW, SH);
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

// 程序猿自己实现的dismiss动画操作
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.alpha = 0;
        fromView.frame = CGRectMake(SW * 0.5, SH * 0.5, 0, 0);
    } completion:^(BOOL finished) {
        [fromView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

#pragma mark - UIViewControllerTransitioningDelegate

// 返回提供present动画操作的动画对象
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _isPresent = YES;
    return self;
}

// 返回提供dismiss的动画对象
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _isPresent = NO;
    return self;
}
@end
