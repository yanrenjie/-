//
//  CircleModel.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/11.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleModel : NSObject

@property(nonatomic, strong)NSString *avert;
@property(nonatomic, strong)NSString *username;
@property(nonatomic, strong)NSString *content;
@property(nonatomic, strong)NSString *time;
@property(nonatomic, strong)NSString *location;
@property(nonatomic, strong)NSArray *likes;
@property(nonatomic, strong)NSArray *images;
@property(nonatomic, strong)NSString *likePersonString;

@property(nonatomic, assign)CGFloat contentHeight;      // 用户发的文本内容的高度
@property(nonatomic, assign)CGFloat likePersonHeight;   // 点赞的人所占的高度
@property(nonatomic, assign)CGFloat imagesHeight;       // 图片的高度
@property(nonatomic, assign)CGFloat cellHeight;         // cell的总高度

+ (instancetype)circleModelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
