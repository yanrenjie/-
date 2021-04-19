//
//  ChatTextReciveCell.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2021/4/18.
//  Copyright © 2021 Jackey. All rights reserved.
//

#import "ChatTextReciveCell.h"
#import "WechatView.h"
#import "MessageModel.h"

@interface ChatTextReciveCell ()

@property(nonatomic, strong)WechatView *chatView;

@property(nonatomic, strong)UILabel *contentLabel;

@property(nonatomic, strong)UIImageView *userImageView;

@end

@implementation ChatTextReciveCell

- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.layer.cornerRadius = 3;
        _userImageView.layer.masksToBounds = YES;
    }
    return _userImageView;
}

- (WechatView *)chatView {
    if (!_chatView) {
        _chatView = [[WechatView alloc] initWithMessageType:MessageType_Text messageDerection:MessageDerection_Recive];
    }
    return _chatView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:17];
    }
    return _contentLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = RGBColor(237, 237, 237);
        [self.contentView addSubview:self.chatView];
        [self.chatView addSubview:self.contentLabel];
        
        [self.contentView addSubview:self.userImageView];
        
        [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.left.offset(10);
            make.width.height.mas_equalTo(40);
        }];
        
        [self.chatView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.left.offset(60);
            make.width.mas_equalTo(10);
            make.bottom.offset(-10);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.left.offset(20);
            make.bottom.right.offset(-10);
        }];
    }
    return self;
}

- (void)setMessageModel:(MessageModel *)messageModel {
    _messageModel = messageModel;
    [self.chatView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_messageModel.messageSize.width + 30);
    }];
    
    self.userImageView.image = [UIImage imageNamed:@"fei5"];
    
    self.contentLabel.text = messageModel.messageContent;
    
    // 更新完约束之后，然后需要重新绘制对话框背景图，不然会出现现实Bug问题
    [self.chatView setNeedsDisplay];
}

@end
