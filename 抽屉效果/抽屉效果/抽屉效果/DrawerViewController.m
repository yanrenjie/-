//
//  DrawerViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/13.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "DrawerViewController.h"
#import "SettingViewController.h"
#import "MyGirlViewController.h"

#define SW UIScreen.mainScreen.bounds.size.width
#define SH UIScreen.mainScreen.bounds.size.height
#define DEFAULTOFFSET -244
#define MYGIRLHEIGHT 200

@interface DrawerViewController ()<SettingViewControllerProtocol>

@property(nonatomic, strong)UIView *mainView;

@property(nonatomic, strong)UIView *leftView;

@end

@implementation DrawerViewController

#pragma mark - 懒加载
- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:self.view.bounds];
        _mainView.backgroundColor = UIColor.blueColor;
    }
    return _mainView;
}


- (UIView *)leftView {
    if (!_leftView) {
        _leftView = [[UIView alloc] initWithFrame:self.view.bounds];
        _leftView.backgroundColor = UIColor.orangeColor;
    }
    return _leftView;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.hidden = YES;
}

// 可以滑动的View是mainView，蓝色的背景色，不能滑动的View是leftView，背景颜色是橙色的
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildView];
    [self addGesture];
    
    // 添加设置界面控制器和控制器View
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    settingVC.view.frame = self.view.bounds;
    settingVC.delegate = self;
    [self.leftView addSubview:settingVC.view];
    [self addChildViewController:settingVC];
}


- (void)addChildView {
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.mainView];
}


- (void)addGesture {
    // 给rightView添加一个拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.mainView addGestureRecognizer:pan];
}


#pragma mark - 手势方法
// 拖拽手势
- (void)panAction:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self.mainView];
    
    // 平移
    // 让蓝色的mainView平移
    CGRect frame = self.mainView.frame;
    frame.origin.x += point.x;
    self.mainView.frame = frame;
    // 如果是滑出左边，进行复位，不让滑动
    if (self.mainView.frame.origin.x <= 0) {
        self.mainView.frame = self.view.bounds;
    }
    
    // 缩放
    // 最大缩放为原来的80%，即0.8， 差值为原来1.0的0.2，即最大差值为0.2
    // 当X的值等于屏幕宽度时，为变化最大值0.2
    CGFloat scale = self.mainView.frame.origin.x / SW * 0.2;
    scale = 1 - scale;
    self.mainView.transform = CGAffineTransformMakeScale(scale, scale);
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (self.mainView.frame.origin.x < SW * 0.5) {
            [UIView animateWithDuration:0.25 animations:^{
                self.mainView.frame = self.view.bounds;
            }];
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame = self.mainView.frame;
                frame.origin.x = SW * 0.8;
                frame.origin.y = SH * 0.2 / 2;
                frame.size.width = SW * 0.8;
                frame.size.height = SH * 0.8;
                self.mainView.frame = frame;
            }];
        }
    }
    
    // 进行清零操作
    [pan setTranslation:CGPointZero inView:self.mainView];
}

- (void)computeScale:(CGFloat)offset {
    
}


// 捏合手势
- (void)pinchAaction:(UIGestureRecognizer *)pinch {
    
}


- (void)tapAction:(UITapGestureRecognizer *)tap {
    [UIView animateWithDuration:.25 animations:^{
        self.mainView.frame = self.view.bounds;
    }];
}


#pragma mark - 方法
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.hidden = NO;
}


#pragma mark - SettingViewControllerProtocol
- (void)drawerBackAction {
    [UIView animateWithDuration:.25 animations:^{
        self.mainView.frame = self.view.bounds;
    }];
}

@end
