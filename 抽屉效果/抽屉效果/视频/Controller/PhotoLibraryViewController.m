//
//  PhotoLibraryViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/9.
//  Copyright © 2020 Jackey. All rights reserved.
//  自定义获取系统相册图库里面的图片和视频进行编辑显示


#import "PhotoLibraryViewController.h"
#import <Photos/Photos.h>
#import "PhotoCell.h"
#import "PhotoNavigationView.h"
#import "PhotoTabView.h"
#import "PhotoListCell.h"

#define CellImageSize  CGSizeMake((SW - 6) / 4, (SW - 6) / 4)

@interface PhotoLibraryViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)PhotoNavigationView *navView;
@property(nonatomic, strong)PhotoTabView *tabView;

@property(nonatomic, strong)UICollectionView *collectionView;

@property(nonatomic, strong)NSMutableArray<PHAssetCollection *> *photoListArray;
@property(nonatomic, strong)NSMutableArray<UIImage *> *currentImageArray;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, assign)NSInteger seletedIndex;
@property(nonatomic, strong)NSMutableArray<UIImage *> *listImageArray;

@end

@implementation PhotoLibraryViewController

#pragma mark - 懒加载
- (NSMutableArray<UIImage *> *)currentImageArray {
    if (!_currentImageArray) {
        _currentImageArray = [NSMutableArray array];
    }
    return _currentImageArray;
}

- (NSMutableArray<PHAssetCollection *> *)photoListArray {
    if (!_photoListArray) {
        _photoListArray = [[NSMutableArray alloc] init];
    }
    return _photoListArray;
}

- (NSMutableArray<UIImage *> *)listImageArray {
    if (!_listImageArray) {
        _listImageArray = [NSMutableArray array];
    }
    return _listImageArray;
}

- (PhotoNavigationView *)navView {
    if (!_navView) {
        _navView = [PhotoNavigationView photoNavigationView];
        _navView.frame = CGRectMake(0, 0, SW, NavH);
        __weak typeof(self) weakSelf = self;
        // 点击取消按钮
        _navView.cancelAction = ^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
        // 点击最近项目，切换相册
        _navView.recentProjectBlock = ^(UIButton * _Nonnull btn, BOOL flag) {
            [UIView animateWithDuration:0.35 animations:^{
                if (flag) {
                    weakSelf.tableView.frame = CGRectMake(0, NavH, SW, SH - NavH - TabH - 60);
                } else {
                    weakSelf.tableView.frame = CGRectMake(0, NavH, SW, 0);
                }
            }];
        };
    }
    return _navView;
}


- (PhotoTabView *)tabView {
    if (!_tabView) {
        _tabView = [PhotoTabView photoTabView];
        _tabView.frame = CGRectMake(0, SH - TabH, SW, TabH);
    }
    return _tabView;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 2;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CellImageSize;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SW, SH) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = UIColor.blackColor;
        [_collectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoCell"];
        _collectionView.contentInset = UIEdgeInsetsMake(NavH, 0, TabH, 0);
        _collectionView.bounces = NO;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavH, SW, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"PhotoListCell" bundle:nil] forCellReuseIdentifier:@"PhotoListCell"];
        _tableView.bounces = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tabView];
    [self.view addSubview:self.tableView];
    
    // 获取系统相册列表
    [self getPictureList];
    
    // 首先获取第一个列表中所有的图片信息
    [self getImageFromAssetCollectionWithCollection:self.photoListArray.firstObject];
    
    // 获取每个列表中的第一张图片
    for (PHAssetCollection *collection in self.photoListArray) {
        [self getListImageWithCollection:collection];
    }
    
    [self.tableView reloadData];
}



#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.currentImageArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    [cell setImageWithImage:self.currentImageArray[indexPath.row]];
    return cell;
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photoListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoListCell"];
    if (self.photoListArray.count != 0) {
        PHAssetCollection *collection = self.photoListArray[indexPath.row];
        [cell setDataWithModel:collection mask:(indexPath.row == self.seletedIndex) ? YES : NO];
    }
    if (self.listImageArray.count != 0) {
        [cell setCellImage:self.listImageArray[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.seletedIndex = indexPath.row;
    PHAssetCollection *collection = self.photoListArray[indexPath.row];
    [self getImageFromAssetCollectionWithCollection:collection];
    [UIView animateWithDuration:0.35 animations:^{
        tableView.frame = CGRectMake(0, NavH, SW, 0);
    }];
    
    [self.navView setButtonTitleWithString:collection.localizedTitle];
    [self.navView recentButtonClickOut];
    [self.tableView reloadData];
}


#pragma mark - 修改模态弹出样式为全屏，不是iOS13之后的半屏
- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationFullScreen;
}


#pragma mark - 从系统相册信息
- (void)getPictureList {
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:YES];
    NSSortDescriptor *sort2 = [NSSortDescriptor sortDescriptorWithKey:@"estimatedAssetCount" ascending:YES];
    options.sortDescriptors = @[sort1, sort2];
    PHFetchResult<PHAssetCollection *> *result1 = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAny options:options];
    [result1 enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.estimatedAssetCount != INT64_MAX) {
            [self.photoListArray addObject:obj];
        }
    }];
    
    PHFetchResult<PHAssetCollection *> *result2 = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:options];

    [result2 enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.estimatedAssetCount != INT64_MAX) {
            [self.photoListArray addObject:obj];
        }
    }];
}


// 根据相册列表获取对应文件夹中的照片
- (void)getImageFromAssetCollectionWithCollection:(PHAssetCollection *)collection {
    [self.currentImageArray removeAllObjects];
    PHFetchResult<PHAsset *> *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    [fetchResult enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        [[PHImageManager defaultManager] requestImageForAsset:obj targetSize:CellImageSize contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [self.currentImageArray addObject:result];
            // 主线程刷新UI
            [NSOperationQueue.mainQueue addOperationWithBlock:^{
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentImageArray.count - 1 inSection:0];
                [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
            }];
        }];
    }];
}


- (void)getListImageWithCollection:(PHAssetCollection *)collection {
    PHFetchResult<PHAsset *> *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    [fetchResult enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        [[PHImageManager defaultManager] requestImageForAsset:obj targetSize:CellImageSize contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [self.listImageArray addObject:result];
            return;
        }];
    }];
}


//  切换不同相册目录的时候，然后更新目录列表UI及数据
- (void)updateListViewFrame {
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.35 animations:^{
        self.tableView.frame = CGRectMake(0, NavH, SW, 0);
    }];
    [self.navView recentButtonClickOut];
}

@end
