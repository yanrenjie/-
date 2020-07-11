//
//  NSString+extension.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/25.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (extension)

- (NSString *)stringToBase64Encoding;


- (NSString *)base64StringToString;


- (CGSize)computeTextSizeWithOriginSize:(CGSize)originSize fontSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
