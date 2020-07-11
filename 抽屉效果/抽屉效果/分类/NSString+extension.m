//
//  NSString+extension.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/25.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "NSString+extension.h"

@implementation NSString (extension)

- (NSString *)stringToBase64Encoding {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:kNilOptions];
}


- (NSString *)base64StringToString {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:kNilOptions];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


- (CGSize)computeTextSizeWithOriginSize:(CGSize)originSize fontSize:(CGFloat)fontSize {
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSDictionary *dict = @{
        NSFontAttributeName : font
    };
    return [self boundingRectWithSize:originSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

@end
