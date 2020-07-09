//
//  SchoolModel.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/22.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SchoolModel : NSObject
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *province;
@property(nonatomic, strong)NSString *city;
@property(nonatomic, strong)NSNumber *schoolID;
@property(nonatomic, strong)NSArray *collages;

+ (instancetype)schoolWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
