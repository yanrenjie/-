//
//  CircleModel.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/11.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "CircleModel.h"

@implementation CircleModel

+ (instancetype)circleModelWithDict:(NSDictionary *)dict {
    CircleModel *model = [[CircleModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    
    // 计算文本的高度
    CGSize originSize = CGSizeMake(SW - defaultCircleMargin * 3 - defaultCircleAvertWidth, MAXFLOAT);
    CGSize size = [model.content computeTextSizeWithOriginSize:originSize fontSize:16];
    model.contentHeight = size.height == 0 ? 0 : size.height;
    
    // 计算照片所占的高度
    NSInteger row = (model.images.count - 1) / 3 + 1;
    CGFloat imagesHeight = (row - 1) * 5 + row * defaultCircleImageWidth;
    model.imagesHeight = imagesHeight;
    
    // 先获取点赞字符串
    NSString *temp = @"";
    if (model.likes.count != 0) {
        temp = @"❤️ ";
        for (NSString *string in model.likes) {
            if ([string isEqualToString:model.likes.lastObject]) {
                temp = [temp stringByAppendingFormat:@"%@", string];
            } else {
                temp = [temp stringByAppendingFormat:@"%@, ", string];
            }
        }
        
        model.likePersonString = temp;
        
        // 计算点赞的人所占的高度
        CGSize originSize1 = CGSizeMake(SW - defaultCircleAvertWidth - defaultCircleMargin * 3, MAXFLOAT);
        CGSize size1 = [model.likePersonString computeTextSizeWithOriginSize:originSize1 fontSize:14];
        model.likePersonHeight = size1.height == 0 ? 0 : size1.height;
    }
    
    CGFloat minHeight = defaultCircleMargin * 9 + 3 * defaultCircleMargin;
    if (model.content.length > 0 && model.images.count > 0) {
        minHeight += 10;
    }
    
    if (model.likePersonString.length > 0) {
        minHeight += 10;
    }
    model.cellHeight = minHeight + model.contentHeight + model.imagesHeight + model.likePersonHeight;
    
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
