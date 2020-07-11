//
//  CommentView.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/10.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentView : UIView

@property(nonatomic, copy)void (^commonClickBlock)(void);

@property(nonatomic, copy)void (^commonButtonBlock)(CommonType type);

+ (instancetype)commentView;

@end

NS_ASSUME_NONNULL_END
