//
//  GraffitiBoardView.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/15.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GraffitiBoardView : UIView

// 清屏
- (void)clearAction;

// 撤销
- (void)backAction;

// 橡皮擦
- (void)xiangpicaAction;

// 设置颜色
- (void)setPencilColor:(UIColor *)color;

// 设置笔的粗细
- (void)setPencilWidth:(CGFloat)width;

// 保存
- (void)saveAction;

// 相册
- (void)photoLibrary;

@end

NS_ASSUME_NONNULL_END
