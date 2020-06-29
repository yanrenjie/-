//
//  VideoModel.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/29.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

+ (instancetype)videoModelWithDict:(NSDictionary *)dict {
    VideoModel *model = [[VideoModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
