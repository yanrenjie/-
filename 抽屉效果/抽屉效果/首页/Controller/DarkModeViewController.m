//
//  DarkModeViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/11.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "DarkModeViewController.h"
#import "CircelCell.h"
#import "CircleModel.h"

@interface DarkModeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray<CircleModel *> *modelArray;

@end

@implementation DarkModeViewController

#pragma mark - 懒加载

- (NSMutableArray<CircleModel *> *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"circle" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:path];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in array) {
            CircleModel *model = [CircleModel circleModelWithDict:dict];
            [_modelArray addObject:model];
        }
    }
    return _modelArray;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SW, SH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 120;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:CircelCell.class forCellReuseIdentifier:@"CircelCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CircelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CircelCell"];
    cell.cellModel = self.modelArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CircleModel *model = self.modelArray[indexPath.row];
    return model.cellHeight;
}


@end
