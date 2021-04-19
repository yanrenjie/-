//
//  ChatKeyboardView.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2021/4/19.
//  Copyright © 2021 Jackey. All rights reserved.
//

#import "ChatKeyboardView.h"

@interface ChatKeyboardView ()<UITextFieldDelegate>

@property(nonatomic, strong)UIImageView *voiceImageView;
@property(nonatomic, strong)UIImageView *emojiImageView;
@property(nonatomic, strong)UIImageView *moreImageView;

@end

@implementation ChatKeyboardView

- (UIImageView *)voiceImageView {
    if (!_voiceImageView) {
        _voiceImageView = [[UIImageView alloc] init];
        _voiceImageView.image = [UIImage imageNamed:@"chat_keyboard_voice"];
        [self addSubview:_voiceImageView];
    }
    return _voiceImageView;
}

- (UITextField *)sendTextField {
    if (!_sendTextField) {
        _sendTextField = [[UITextField alloc] init];
        _sendTextField.layer.cornerRadius = 3;
        _sendTextField.layer.masksToBounds = YES;
        _sendTextField.backgroundColor = UIColor.whiteColor;
        _sendTextField.returnKeyType = UIReturnKeySend;
        _sendTextField.delegate = self;
        [self addSubview:_sendTextField];
    }
    return _sendTextField;
}

- (UIImageView *)emojiImageView {
    if (!_emojiImageView) {
        _emojiImageView = [[UIImageView alloc] init];
        _emojiImageView.image = [UIImage imageNamed:@"chat_keyboard_emoji"];
        [self addSubview:_emojiImageView];
    }
    return _emojiImageView;
}

- (UIImageView *)moreImageView {
    if (!_moreImageView) {
        _moreImageView = [[UIImageView alloc] init];
        _moreImageView.image = [UIImage imageNamed:@"chat_keyboard_more"];
        [self addSubview:_moreImageView];
    }
    return _moreImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.voiceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(10);
            make.height.width.mas_equalTo(30);
        }];
        
        [self.sendTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(5);
            make.left.equalTo(self.voiceImageView.mas_right).offset(10);
            make.height.mas_equalTo(40);
        }];
        
        [self.emojiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.voiceImageView);
            make.height.width.mas_equalTo(30);
            make.left.equalTo(self.sendTextField.mas_right).offset(10);
            make.right.equalTo(self.moreImageView.mas_left).offset(-10);
        }];
        
        [self.moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.voiceImageView);
            make.height.width.mas_equalTo(30);
            make.right.offset(-10);
        }];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"点击了send按钮");
    if (self.messageBlock) {
        self.messageBlock(textField.text);
        textField.text = @"";
    }
    return YES;
}

@end
