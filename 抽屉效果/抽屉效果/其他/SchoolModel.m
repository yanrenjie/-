//
//  SchoolModel.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/22.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "SchoolModel.h"
#import <objc/runtime.h>

@implementation SchoolModel

+ (instancetype)schoolWithDict:(NSDictionary *)dict {
    SchoolModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"schoolID"];
    }
}


- (NSString *)description {
    NSString *des = @"";
    unsigned int count = 0;
    // 获取所有的属性
    objc_property_t *propertys = class_copyPropertyList([self class], &count);
    // 便利所有的属性
    for (int i = 0; i < count; i++) {
        objc_property_t p = propertys[i];
        const char *propertyCharName = property_getName(p);
        // 将C语言字符串转化为OC字符串
        NSString *key = [[NSString alloc] initWithUTF8String:propertyCharName];
        // 根据字符串获取get方法
        SEL getMethod = NSSelectorFromString(key);
        // 获取对应的值
        NSString *value = [self performSelector:getMethod];
        des = [NSString stringWithFormat:@"  [%@ = %@] ", key, value];
    }
    NSData *desData = [des dataUsingEncoding:NSUTF8StringEncoding];
    NSString *newString = [[NSString alloc] initWithData:desData encoding:NSUTF8StringEncoding];
    
    return newString;
}


- (NSString *)firstCharBigLetter:(NSString *)originString {
    NSString *fistLetter = [[originString substringToIndex:1] uppercaseString];
    NSString *result = [originString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:fistLetter];
    return result;
}

@end
