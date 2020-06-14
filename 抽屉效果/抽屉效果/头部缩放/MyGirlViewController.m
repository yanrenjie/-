//
//  MyGirlViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/13.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "MyGirlViewController.h"

#define SW UIScreen.mainScreen.bounds.size.width
#define SH UIScreen.mainScreen.bounds.size.height
#define DEFAULTOFFSET -244
#define MYGIRLHEIGHT 200

@interface MyGirlViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UIImageView *mygirlImageView;
@property(nonatomic, strong)UIView *floatView;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UILabel *mygirlTitleView;

@end

@implementation MyGirlViewController

#pragma mark - 懒加载
- (UIImageView *)mygirlImageView {
    if (!_mygirlImageView) {
        _mygirlImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SW, 200)];
        _mygirlImageView.image = [UIImage imageNamed:@"mygirl"];
        _mygirlImageView.clipsToBounds = YES;
        _mygirlImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _mygirlImageView;
}


- (UIView *)floatView {
    if (!_floatView) {
        _floatView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, SW, 44)];
        _floatView.backgroundColor = UIColor.systemPinkColor;
    }
    return _floatView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SW, SH) style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(244, 0, 0, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 60;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        
    }
    return _tableView;
}

- (UILabel *)mygirlTitleView {
    if (!_mygirlTitleView) {
        _mygirlTitleView = [[UILabel alloc] init];
        _mygirlTitleView.text = @"Jackey和他的女朋友";
        [_mygirlTitleView sizeToFit];
        _mygirlTitleView.textColor = [UIColor colorWithWhite:0 alpha:0];
    }
    return _mygirlTitleView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.mygirlImageView];
    [self.view addSubview:self.floatView];
    
    if (@available(iOS 11.0, *)) {
       _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
       self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 凡是在导航控制器下的UIScrollView会自动设置一个上面的内边距（64/83）
    // 比方说，此处设置UITableView的frame是CGRectMake(0, 0, SW, SH)，但是UITableView的contentInset是{83/64, 0, 0, 0}
    // 设置UITableView的头部tableHeaderView（x, y, w）不受控件自己控制，无论坐标，宽度设置为多少，坐标都会清零，而宽会设置为UITableView的宽度
    /**
     如果不想让它设置内边距，可以通过以下方法进行取消
     if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
     } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
     }
     */
    
    // 隐藏导航控制器的导航条，直接隐藏，没有渐变效果
     self.navigationController.navigationBar.hidden = YES;
    
    // 设置导航条的透明度,导航条以及里面的子控件设置透明度是没有效果的，也不能隐藏
    // self.navigationController.navigationBar.alpha = 0;
    
    // 设置导航条的背景图片
    // 设置导航条的背景图片必须使用UIBarMetricsDefault
    UIColor *color = [UIColor colorWithWhite:1 alpha:0];
    UIImage *image = [self imageWithColor:color];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    // 如果说导航条的北极光你图片设置是nil，会自动帮你创建一个白色的半透明的图片设置为导航条的背景图片
    // 导航条下面的那根细线,是一个阴影图片，setShadowImage
    [self.navigationController.navigationBar setShadowImage:image];
    
    //
    self.navigationItem.titleView = self.mygirlTitleView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld分区-----第%ld行", (long)indexPath.section, (long)indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat tempOffset = scrollView.contentOffset.y - DEFAULTOFFSET;
    NSLog(@"%.2f", tempOffset);
    CGFloat mygirlH = MYGIRLHEIGHT - tempOffset;
    if (mygirlH <= 88) {
        mygirlH = 88;
    }
    CGRect rect = CGRectMake(0, 0, SW, mygirlH);
    self.mygirlImageView.frame = rect;
    self.floatView.frame = CGRectMake(0, mygirlH, SW, 44);
    
    // 动态计算alpha
    // 求变化的值
    // 最大值的方法
    // 1、最大值是多少
    // 2、什么情况下最多
    // 当tempOffset = 112时，alpha = 1,   112 = 200 - 88;
    // 当变化的值 = 固定的值 的时候为最大值
    
    
    CGFloat alpha = 1 * tempOffset / 112.0;
    // 如果当alpha = 1时，导航栏被改成了半透明效果的时候，则需要做如下判断
//    if (alpha >= 1) {
//        alpha = 0.99;
//    }
    
    // 根据一个颜色，生成一张图片
    UIColor *color = [UIColor colorWithWhite:1 alpha:alpha];
    UIImage *image = [self imageWithColor:color];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    self.mygirlTitleView.textColor = [UIColor.blackColor colorWithAlphaComponent:alpha];
}


- (UIImage *)imageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 拉取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 使用color填充上下文
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    // 渲染上下文
    CGContextFillRect(context, rect);
    
    // 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end

