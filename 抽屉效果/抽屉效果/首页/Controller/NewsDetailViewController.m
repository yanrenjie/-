//
//  NewsDetailViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/10.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "CommentView.h"
#import "CommonInputView.h"

@interface NewsDetailViewController ()

@property(nonatomic, strong)CommentView *commonTabView;
@property(nonatomic, strong)CommonInputView *commonInputView;

@end

@implementation NewsDetailViewController

#pragma mark - 懒加载
- (CommentView *)commonTabView {
    if (!_commonTabView) {
        weak(self)
        _commonTabView = [CommentView commentView];
        _commonTabView.commonClickBlock = ^{
            [weakSelf.commonInputView inputViewIsFirstResponder:YES];
        };
        _commonTabView.commonButtonBlock = ^(CommonType type) {
            
        };
        [self.view addSubview:_commonTabView];
    }
    return _commonTabView;
}


- (CommonInputView *)commonInputView {
    if (!_commonInputView) {
        weak(self)
        _commonInputView = [CommonInputView commonInputView];
        _commonInputView.commonInputBlock = ^(CommonInputType type) {
            [weakSelf.commonInputView inputViewIsFirstResponder:NO];
        };
        [self.view addSubview:_commonInputView];
    }
    return _commonInputView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardTypeChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.commonTabView.frame = CGRectMake(0, SH - TabH, SW, TabH);
    self.commonInputView.frame = CGRectMake(0, SH, SW, 155);
}


- (void)keyboardTypeChanged:(NSNotification *)notification {
    NSValue *value = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    NSNumber *time = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    CGRect rect = value.CGRectValue;
    CGFloat duration = time.floatValue;
    CGPoint originP = rect.origin;
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.commonInputView.frame;
        if (originP.y == SH) {
            frame.origin.y = SH;
            self.commonInputView.frame = frame;
        } else {
            self.commonInputView.frame = CGRectMake(0, originP.y - frame.size.height, SW, frame.size.height);
        }
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.commonInputView inputViewIsFirstResponder:NO];
}

- (void)dealloc {
    NSLog(@"dealloc  ----   %@  ---- 成功啦， 哈哈哈😂", [self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
