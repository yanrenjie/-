//
//  MessageModel.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2021/4/18.
//  Copyright © 2021 Jackey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject

@property(nonatomic, strong)NSString *messageContent;
@property(nonatomic, assign)MessageType messageType;
@property(nonatomic, strong)NSString *pictureURL;
@property(nonatomic, strong)NSString *videoURL;
@property(nonatomic, strong)NSString *adsTitle;
@property(nonatomic, assign)MessageDerection messageDerection;
@property(nonatomic, assign)CGSize messageSize;

@end

NS_ASSUME_NONNULL_END
