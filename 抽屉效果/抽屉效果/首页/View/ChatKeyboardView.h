//
//  ChatKeyboardView.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2021/4/19.
//  Copyright © 2021 Jackey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SendMessageBlock)(NSString *message);

@interface ChatKeyboardView : UIView

@property(nonatomic, strong)UITextField *sendTextField;

@property(nonatomic, copy)SendMessageBlock messageBlock;

@end

NS_ASSUME_NONNULL_END
