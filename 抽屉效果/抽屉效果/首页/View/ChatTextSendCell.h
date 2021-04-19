//
//  ChatTextCell.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2021/4/18.
//  Copyright © 2021 Jackey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageModel;

NS_ASSUME_NONNULL_BEGIN

@interface ChatTextSendCell : UITableViewCell

@property(nonatomic, strong)MessageModel *messageModel;

@end

NS_ASSUME_NONNULL_END
