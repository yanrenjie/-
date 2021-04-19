//
//  JieCustomePhotoViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/8/13.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "JieCustomePhotoViewController.h"
#import <Photos/Photos.h>

#define CUSTOMPHOTOTITLE @"今日油条"

@interface JieCustomePhotoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic, strong)UIImage *image;
@property(nonatomic, strong)UIButton *btn;

@end

@implementation JieCustomePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"liuyifei2"];
    _image = image;

    self.imageView.image = image;
}

// 获取之前的相册
- (PHAssetCollection *)fetchAssetCollection {
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in result) {
        if ([collection.localizedTitle isEqualToString:CUSTOMPHOTOTITLE]) {
            return collection;
        }
    }
    return nil;
}


// 保存图片到相册
- (IBAction)saveToPL:(UIButton *)sender {
    self.btn = sender;
    /**
     PHAuthorizationStatusNotDetermined = 0, // 用户还为做决定
     PHAuthorizationStatusRestricted,        // 家长控制，就是被拒绝
     PHAuthorizationStatusDenied,               // 被拒绝
     PHAuthorizationStatusAuthorized // 同意授权
     */
    PHAuthorizationStatus a_status = [PHPhotoLibrary authorizationStatus];
    // 弹框让用户选择
    if (a_status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus b_status) {
            if (b_status == PHAuthorizationStatusAuthorized) {
                [self saveAction];
            }
        }];
    }
    // 直接保存即可
    else if (a_status == PHAuthorizationStatusAuthorized) {
        [self saveAction];
    }
    // 拒绝操作, 提示用户打开授权
    else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请按照如下步骤进行操作" message:@"设置 --> 抽屉效果 --> 照片 --> 读取和写入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *notok = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:ok];
        [alert addAction:notok];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    [self saveAction];
}


- (void)saveAction {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.btn.enabled = YES;
    });
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 创建自己的自定义相册
        PHAssetCollectionChangeRequest *customRequest;
        
        PHAssetCollection *assetCollection = [self fetchAssetCollection];
        if (assetCollection) {
            customRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else {
            customRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:CUSTOMPHOTOTITLE];
        }
        
        // 保存图片到系统相册中
        PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:self.image];
        
        // 保存到自己的相册中
        PHObjectPlaceholder *placeholder = [assetRequest placeholderForCreatedAsset];
        [customRequest addAssets:@[placeholder]];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success && error == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.btn.enabled = YES;
            });
        }
    }];
}

@end
