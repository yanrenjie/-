//
//  WechatView.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2021/4/15.
//  Copyright © 2021 Jackey. All rights reserved.
//

#import "WechatView.h"

@implementation WechatView

- (instancetype)initWithMessageType:(MessageType)type messageDerection:(MessageDerection)derection {
    if (self = [super init]) {
        _messageType = type;
        _messageDerection = derection;
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    CGFloat x = 10, y = 15, a = 10, r = 10;
    // 接受到消息
    if (self.messageDerection == MessageDerection_Send) {
        if (self.messageType == MessageType_Text) {
            [path moveToPoint:CGPointMake(r, 0)];
            [path addLineToPoint:CGPointMake(w - x - r, 0)];
            [path addArcWithCenter:CGPointMake(w - x - r, r) radius:r startAngle:-M_PI_2 endAngle:0 clockwise:YES];
            [path addLineToPoint:CGPointMake(w - x, y)];
            [path addLineToPoint:CGPointMake(w, y + a / 2)];
            [path addLineToPoint:CGPointMake(w - x, y + a)];
            [path addArcWithCenter:CGPointMake(w - x - r, h - r) radius:r startAngle:0 endAngle:M_PI_2 clockwise:YES];
            [path addLineToPoint:CGPointMake(r, h)];
            [path addArcWithCenter:CGPointMake(r, h - r) radius:r startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
            [path addLineToPoint:CGPointMake(0, r)];
            [path addArcWithCenter:CGPointMake(r, r) radius:r startAngle:M_PI endAngle:-M_PI_2 clockwise:YES];
            [RGBColor(169, 232, 122) set];
        } else {
            
        }
    } else {
        if (self.messageType == MessageType_Text) {
            [path moveToPoint:CGPointMake(x + r, 0)];
            [path addLineToPoint:CGPointMake(w - r, 0)];
            [path addArcWithCenter:CGPointMake(w - r, r) radius:r startAngle:-M_PI_2 endAngle:0 clockwise:YES];
            [path addLineToPoint:CGPointMake(w, h - r)];
            [path addArcWithCenter:CGPointMake(w - r, h - r) radius:r startAngle:0 endAngle:M_PI_2 clockwise:YES];
            [path addLineToPoint:CGPointMake(x + r, h)];
            [path addArcWithCenter:CGPointMake(x + r, h - r) radius:r startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
            [path addLineToPoint:CGPointMake(x, y + a)];
            [path addLineToPoint:CGPointMake(0, y + a / 2)];
            [path addLineToPoint:CGPointMake(x, y)];
            [path addLineToPoint:CGPointMake(x, r)];
            [path addArcWithCenter:CGPointMake(x + r, r) radius:r startAngle:M_PI endAngle:-M_PI_2 clockwise:YES];
            [UIColor.whiteColor set];
        } else {
            
        }
    }
    
    [path closePath];
    [path fill];
}

@end
