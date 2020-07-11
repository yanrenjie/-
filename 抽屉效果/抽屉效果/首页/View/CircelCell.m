//
//  CircelCell.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/11.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "CircelCell.h"
#import "UIImage+extension.h"
#import "CircleModel.h"

@interface CircelCell ()
/// 用户头像
@property(nonatomic, strong)UIImageView *avertImageView;
/// 用户名
@property(nonatomic, strong)UILabel *usernameLabel;
/// 发表的内容
@property(nonatomic, strong)UILabel *contentLabel;
/// 图片背景图
@property(nonatomic, strong)UIView *imageBackView;
/// 发表的图片
@property(nonatomic, strong)NSMutableArray<UIImageView *> *imageViewArray;
/// 用户发表的定位
@property(nonatomic, strong)UIButton *locationButton;
/// 发表到现在的时间
@property(nonatomic, strong)UILabel *timeLabel;
/// 点击按钮，开始评论，点赞
@property(nonatomic, strong)UIButton *commonButton;
/// 点过赞的人
@property(nonatomic, strong)UILabel *likePersonLabel;
/// 分割线
@property(nonatomic, strong)UIView *lineView;

@property(nonatomic, strong)UIImageView *lastImageView;

@end

@implementation CircelCell

#pragma mark - 懒加载
- (UIImageView *)avertImageView {
    if (!_avertImageView) {
        _avertImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_avertImageView];
    }
    return _avertImageView;
}

- (UILabel *)usernameLabel {
    if (!_usernameLabel) {
        _usernameLabel = [[UILabel alloc] init];
        _usernameLabel.textColor = [UIColor adaptDarkModeWithColor:RGBColor(120, 134, 154) darkColor:RGBColor(104, 119, 154)];
        _usernameLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:_usernameLabel];
    }
    return _usernameLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.textColor = [UIColor adaptDarkModeWithColor:UIColor.blackColor darkColor:UIColor.whiteColor];
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UIView *)imageBackView {
    if (!_imageBackView) {
        _imageBackView = [[UIView alloc] init];
        [self.contentView addSubview:_imageBackView];
    }
    return _imageBackView;
}

- (NSMutableArray<UIImageView *> *)imageViewArray {
    if (!_imageViewArray) {
        _imageViewArray = [NSMutableArray array];
        for (int i = 0; i < 9; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.hidden = YES;
            [self.imageBackView addSubview:imageView];
            [_imageViewArray addObject:imageView];
        }
    }
    return _imageViewArray;
}

- (UIButton *)locationButton {
    if (!_locationButton) {
        _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationButton.adjustsImageWhenHighlighted = NO;
        [_locationButton setTitleColor:[UIColor adaptDarkModeWithColor:RGBColor(150, 161, 185) darkColor:RGBColor(82, 90, 102)] forState:UIControlStateNormal];
        _locationButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:_locationButton];
    }
    return _locationButton;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor adaptDarkModeWithColor:RGBColor(199, 199, 199) darkColor:RGBColor(87, 87, 87)];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIButton *)commonButton {
    if (!_commonButton) {
        _commonButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commonButton.adjustsImageWhenHighlighted = NO;
        [_commonButton setImage:[UIImage imageNamed:@"wechat_more"] forState:UIControlStateNormal];
        _commonButton.backgroundColor = [UIColor adaptDarkModeWithColor:RGBColor(247, 247, 247) darkColor:RGBColor(44, 44, 44)];
        _commonButton.layer.cornerRadius = 5;
        _commonButton.layer.masksToBounds = YES;
        [self.contentView addSubview:_commonButton];
    }
    return _commonButton;
}

- (UILabel *)likePersonLabel {
    if (!_likePersonLabel) {
        _likePersonLabel = [[UILabel alloc] init];
        _likePersonLabel.layer.cornerRadius = 5;
        _likePersonLabel.layer.masksToBounds = YES;
        _likePersonLabel.numberOfLines = 0;
        _likePersonLabel.backgroundColor = [UIColor adaptDarkModeWithColor:RGBColor(247, 247, 247) darkColor:RGBColor(47, 47, 47)];
        _likePersonLabel.textColor = [UIColor adaptDarkModeWithColor:RGBColor(120, 134, 154) darkColor:RGBColor(104, 119, 154)];
        _likePersonLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_likePersonLabel];
    }
    return _likePersonLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor adaptDarkModeWithColor:RGBColor(235, 235, 235) darkColor:RGBColor(37, 37, 37)];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    weak(self)
    [self.avertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(defaultCircleMargin);
        make.width.height.mas_equalTo(defaultCircleAvertWidth);
    }];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.avertImageView.mas_right).offset(defaultCircleMargin);
        make.top.equalTo(weakSelf.avertImageView.mas_top);
        make.height.mas_equalTo(20);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.usernameLabel.mas_left);
        make.top.equalTo(weakSelf.usernameLabel.mas_bottom).offset(defaultCircleMargin);
        make.right.offset(-defaultCircleMargin);
    }];
    
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.usernameLabel.mas_left);
        make.right.offset(-(defaultCircleMargin * 2 + defaultCircleAvertWidth));
        make.top.equalTo(weakSelf.contentLabel.mas_bottom).offset(defaultCircleMargin);
    }];
        
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            // 如果不存在，则为第一张图片
            if (!weakSelf.lastImageView) {
                make.left.top.mas_equalTo(0);
            } else {
                // 判断是否需要换行
                if (idx % 3 == 0) {
                    make.left.mas_equalTo(0);
                    make.top.equalTo(weakSelf.lastImageView.mas_bottom).offset(5);
                } else {
                    make.left.equalTo(weakSelf.lastImageView.mas_right).offset(5);
                    make.top.equalTo(weakSelf.lastImageView);
                }
            }
            make.height.width.mas_equalTo(defaultCircleImageWidth);
        }];
        weakSelf.lastImageView = obj;
    }];
    
    [self.locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.usernameLabel.mas_left);
        make.top.equalTo(weakSelf.imageBackView.mas_bottom).offset(defaultCircleMargin);
        make.height.mas_equalTo(20);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.usernameLabel.mas_left);
        make.top.equalTo(weakSelf.locationButton.mas_bottom).offset(defaultCircleMargin);
        make.height.mas_equalTo(20);
    }];
    
    [self.commonButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-defaultCircleMargin);
        make.size.mas_equalTo(CGSizeMake(30, 20));
        make.centerY.equalTo(weakSelf.timeLabel);
    }];
    
    [self.likePersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.usernameLabel.mas_left);
        make.right.offset(-defaultCircleMargin);
        make.top.equalTo(weakSelf.commonButton.mas_bottom).offset(defaultCircleMargin);
        make.bottom.offset(-20);
        make.height.mas_equalTo(20);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}


- (void)setCellModel:(CircleModel *)cellModel {
    UIImage *image = [UIImage imageNamed:cellModel.avert];
    self.avertImageView.image = [image cornerImageWithRadius:10 imageSize:CGSizeMake(defaultCircleAvertWidth, defaultCircleAvertWidth)];
    self.usernameLabel.text = cellModel.username;
    self.contentLabel.text = cellModel.content;
    self.timeLabel.text = cellModel.time;
    self.likePersonLabel.text = cellModel.likePersonString;
    [self.locationButton setTitle:cellModel.location forState:UIControlStateNormal];
    for (int i = 0; i < cellModel.images.count; i++) {
        NSString *imageName = cellModel.images[i];
        UIImageView *obj = self.imageViewArray[i];
        obj.image = [UIImage imageNamed:imageName];
    }
    
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= cellModel.images.count) {
            obj.hidden = YES;
        } else {
            obj.hidden = NO;
        }
    }];
    
    [self.likePersonLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(cellModel.likePersonHeight);
    }];
}

@end
