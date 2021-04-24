//
//  HomeViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/29.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "HomeViewController.h"
#import "JieAnimationTransition.h"
#import "JieAnitionTransitionViewController.h"
#import "WechatDetailViewController.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *titleArray;
@property(nonatomic, strong)JieAnimationTransition *jieTransition;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"转场动画" style:UIBarButtonItemStylePlain target:self action:@selector(jieAnimationTransition)];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];
}


- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[
            @{
                @"title" : @"获取系统相册内容自定义展示",
                @"vcname" : @"PhotoLibraryViewController"
            },
            @{
                @"title" : @"新闻详情页评论框改变",
                @"vcname" : @"NewsDetailViewController"
            },
            @{
                @"title" : @"仿微信朋友圈暗黑模式适配",
                @"vcname" : @"DarkModeViewController"
            },
            @{
                @"title" : @"聊天详情",
                @"vcname" : @"WechatDetailViewController"
            },
            @{
                @"title" : @"弹幕",
                @"vcname" : @"BarrageViewController"
            }
        ];
    }
    return _titleArray;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SW, SH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    NSDictionary *dict = self.titleArray[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.titleArray[indexPath.row];
    NSString *vcname = dict[@"vcname"];
    Class name = NSClassFromString(vcname);
    UIViewController *vc = (UIViewController *)[name new];
    if (indexPath.row == 0) {
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    /*
    if (indexPath.row == 3) {
        WechatDetailViewController *wechatVC = (WechatDetailViewController *)vc;
        // 设置返回按钮标题或者样式（自定义样式）
        // 设置文字标题
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(zhuangbi)];
        
        wechatVC.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"self_back"];
        wechatVC.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"self_back"];
    }
     */
}


- (void)zhuangbi {
    NSLog(@"装逼");
}


#pragma mark - 自定义转场动画
- (JieAnimationTransition *)jieTransition {
    if (!_jieTransition) {
        _jieTransition = [JieAnimationTransition new];
    }
    return _jieTransition;
}

- (void)jieAnimationTransition {
    JieAnitionTransitionViewController *jieVC = [[JieAnitionTransitionViewController alloc] init];
    // 设置模态弹出样式为自定义的样式
    jieVC.modalPresentationStyle = UIModalPresentationCustom;
    // 设置执行动画的代理对象，该对象必须要实现UIViewControllerTransitioningDelegate协议
    jieVC.transitioningDelegate = self.jieTransition;
    [self presentViewController:jieVC animated:YES completion:nil];
}

@end
