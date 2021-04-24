//
//  BarrageModel.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2021/4/25.
//  Copyright © 2021 Jackey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BarrageModel : NSObject

@property(nonatomic, copy)NSString *barrageContent;     // 弹幕内容
@property(nonatomic, assign)NSInteger rowNumber;        // 行号
@property(nonatomic, assign)CGFloat scrollSpeed;        // 滚动速度
@property(nonatomic, assign)CGSize contentSize;        // 弹幕的宽高

@end

NS_ASSUME_NONNULL_END
