//
//  MultiViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/19.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "MultiViewController.h"

@interface MultiViewController ()<UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *collectionView;

@property(nonatomic, strong)NSArray *vcNameArray;

@end

@implementation MultiViewController

- (NSArray *)vcNameArray {
    if (!_vcNameArray) {
        _vcNameArray = @[@"RoundImageViewController" , @"RoundImageViewController", @"RoundImageViewController", @"ClockViewController", @"RoundImageViewController"];
    }
    return _vcNameArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(SW, SH - NavH);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SW, SH - NavH) collectionViewLayout:layout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加collectionView
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:self.collectionView];
    
    // 添加子控制器
    [self addChildVC];
}


- (void)addChildVC {
    for (int i = 0; i < self.vcNameArray.count; i++) {
        Class VC = NSClassFromString(self.vcNameArray[i]);
        [self addChildViewController:[VC new]];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIViewController *VC = self.childViewControllers[indexPath.row];
    VC.view.backgroundColor = UIColor.brownColor;
    VC.view.frame = CGRectMake(0, 0, SW, SH - NavH);
    [cell.contentView addSubview:VC.view];
    
    return cell;
}

@end
