//
//  CommonInputView.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/10.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "CommonInputView.h"

@interface CommonInputView ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation CommonInputView

+ (instancetype)commonInputView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}


- (void)inputViewIsFirstResponder:(BOOL)flag {
    if (flag) {
        [self.textView becomeFirstResponder];
    } else {
        [self.textView resignFirstResponder];
    }
}


- (IBAction)buttonClickAction:(UIButton *)sender {
    NSLog(@"%ld", sender.tag);
    if (self.commonInputBlock) {
        self.commonInputBlock(CommonInputTypeAt);
    }
}

@end
