//
//  VideoModel.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/29.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoModel : NSObject

@property(nonatomic, strong)NSString *videoId;
@property(nonatomic, strong)NSString *gbImageName;
// 是否关注
@property(nonatomic, assign)BOOL like;
// 点赞数
@property(nonatomic, assign)NSInteger likeNumber;
// 评论数
@property(nonatomic, assign)NSInteger replyNumber;
// 转发数
@property(nonatomic, assign)NSInteger forwordNumber;
// 用户头像
@property(nonatomic, strong)NSString *headImageName;
// 用户名
@property(nonatomic, strong)NSString *userName;
// 视频内容介绍
@property(nonatomic, strong)NSString *content;
// 配音头像
@property(nonatomic, strong)NSString *musicImageName;
// 配音音乐描述
@property(nonatomic, strong)NSString *musicContent;
// 视频URL地址
@property(nonatomic, strong)NSString *videoURL;


+ (instancetype)videoModelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
