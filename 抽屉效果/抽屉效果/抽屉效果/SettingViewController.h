//
//  SettingViewController.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/13.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SettingViewControllerProtocol <NSObject>

- (void)drawerBackAction;

@end

@interface SettingViewController : UIViewController

@property(nonatomic, weak)id<SettingViewControllerProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
