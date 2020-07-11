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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    self.commonTabView.frame = CGRectMake(0, SH - TabH, SW, TabH);
    self.commonInputView.frame = CGRectMake(0, SH, SW, 155);
}


- (void)keyboardShow:(NSNotification *)notification {
    NSLog(@"----------   %@", notification.userInfo);
}

- (void)keyboardHidden:(NSNotification *)notification {
    NSLog(@"+++++++++++   %@", notification.userInfo);
}

- (void)dealloc {
    NSLog(@"dealloc  ----   %@  ---- 成功啦， 哈哈哈😂", [self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
