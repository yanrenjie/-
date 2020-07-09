//
//  JieTabBarController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/29.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "JieTabBarController.h"

@interface JieTabBarController ()

@end

@implementation JieTabBarController

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *vcNameArrary = @[@"HomeViewController", @"SameCityViewController", @"SmallVideoViewController", @"MineViewController", @"NotesViewController"];
        NSMutableArray *vcArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < vcNameArrary.count; i++) {
            UIViewController *vc = [NSClassFromString(vcNameArrary[i]) new];
            if (i == 2) {
                vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:[vcNameArrary[i] substringToIndex:[vcNameArrary[i] length] - 14] image:[UIImage imageNamed:[NSString stringWithFormat:@"%ld_n", i]] tag:1000 + i];
                vc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%ld_p", i]];
                [vcArray addObject:vc];
            } else {
                UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:vc];
                naVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:[vcNameArrary[i] substringToIndex:[vcNameArrary[i] length] - 14] image:[UIImage imageNamed:[NSString stringWithFormat:@"%ld_n", i]] tag:1000 + i];
                naVC.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%ld_p", i]];
                [vcArray addObject:naVC];
            }
        }
        self.viewControllers = [vcArray copy];
    }
    return self;
}

@end
