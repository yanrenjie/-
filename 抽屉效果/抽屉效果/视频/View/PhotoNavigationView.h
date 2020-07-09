//
//  PhotoNavigationView.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/9.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoNavigationView : UIView

+ (instancetype)photoNavigationView;

@property(nonatomic, copy)void (^cancelAction)(void);

@property(nonatomic, copy)void (^recentProjectBlock)(UIButton *btn, BOOL flag);

- (void)recentButtonClickOut;

- (void)setButtonTitleWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
