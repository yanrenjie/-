//
//  HomeViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/29.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *titleArray;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
}


@end
