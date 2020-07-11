//
//  CommonInputView.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/10.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonInputView : UIView

+ (instancetype)commonInputView;

@property(nonatomic, copy)void (^commonInputBlock)(CommonInputType type);

- (void)inputViewIsFirstResponder:(BOOL)flag;

@end

NS_ASSUME_NONNULL_END
