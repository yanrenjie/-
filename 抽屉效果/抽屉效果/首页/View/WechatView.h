//
//  WechatView.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2021/4/15.
//  Copyright © 2021 Jackey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WechatView : UIView

@property(nonatomic, assign)MessageType messageType;
@property(nonatomic, assign)MessageDerection messageDerection;

- (instancetype)initWithMessageType:(MessageType)type messageDerection:(MessageDerection)derection;

@end

NS_ASSUME_NONNULL_END
