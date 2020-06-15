//
//  ViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/13.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong)NSArray *titleArray;

@end

@implementation ViewController

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[
            @[
                @{
                    @"title" : @"抽屉效果",
                    @"vcname" : @"DrawerViewController"
                },
                @{
                    @"title" : @"头部缩放以及吸附效果",
                    @"vcname" : @"MyGirlViewController"
                },
                @{
                    @"title" : @"自定义下载进度条",
                    @"vcname" : @"MyProgressViewController"
                },
                @{
                    @"title" : @"绘制圆角图片",
                    @"vcname" : @"RoundImageViewController"
                },
                @{
                    @"title" : @"自定义图片拖动裁剪",
                    @"vcname" : @"SelfDefineImageClipViewController"
                },
                @{
                    @"title" : @"涂鸦画板",
                    @"vcname" : @"GraffitiBoardViewController"
                },
                @{
                    @"title" : @"给图片设置阴影圆角",
                    @"vcname" : @"SetRoundCornerImageWithShadowViewController"
                }
            ]
        ];
    }
    return _titleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.2];
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.titleArray[section];
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    NSArray *array = self.titleArray[indexPath.section];
    NSDictionary *dict = array[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = self.titleArray[indexPath.section];
    NSDictionary *dict = array[indexPath.row];
    NSString *vcname = dict[@"vcname"];
    Class name = NSClassFromString(vcname);
    [self.navigationController pushViewController:[name new] animated:YES];
}

@end
