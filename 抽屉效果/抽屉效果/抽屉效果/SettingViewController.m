//
//  SettingViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/13.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "SettingViewController.h"
#import "MyFileViewController.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong)NSArray *array;

@end

@implementation SettingViewController

- (NSArray *)array {
    if (!_array) {
        _array = @[
            @{
                @"title" : @"会员夏日特惠🍉",
                @"icon" : @"huiyuan"
            },
            @{
                @"title" : @"我的QQ钱包",
                @"icon" : @"qianbao"
            },
            @{
                @"title" : @"我的个性装扮",
                @"icon" : @"zhuangban"
            },
            @{
                @"title" : @"我的收藏",
                @"icon" : @"shoucang"
            },
            @{
                @"title" : @"我的相册",
                @"icon" : @"xiangce"
            },
            @{
                @"title" : @"我的文件",
                @"icon" : @"wenjian"
            },
            @{
                @"title" : @"免流量特权",
                @"icon" : @"mianliuliang"
            }
        ];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = self.array[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyFileViewController *myfileVC = [[MyFileViewController alloc] init];
    [self.navigationController pushViewController:myfileVC animated:YES];
    if ([self.delegate respondsToSelector:@selector(drawerBackAction)]) {
        [self.delegate drawerBackAction];
    }
}

@end
