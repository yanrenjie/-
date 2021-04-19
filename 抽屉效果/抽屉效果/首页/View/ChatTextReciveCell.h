//
//  ChatTextReciveCell.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2021/4/18.
//  Copyright © 2021 Jackey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MessageModel;

@interface ChatTextReciveCell : UITableViewCell

@property(nonatomic, strong)MessageModel *messageModel;

@end

NS_ASSUME_NONNULL_END
