//
//  CommentView.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/10.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "CommentView.h"

@interface CommentView ()

@end

@implementation CommentView

+ (instancetype)commentView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}



- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)setupUI {
    
}


- (IBAction)commonClick:(UITapGestureRecognizer *)sender {
    if (self.commonClickBlock) {
        self.commonClickBlock();
    }
}



- (IBAction)buttonClickAction:(UIButton *)sender {
    NSLog(@"%ld", sender.tag);
}


@end
