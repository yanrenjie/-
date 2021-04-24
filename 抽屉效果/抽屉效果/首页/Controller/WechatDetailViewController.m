//
//  WechatDetailViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2021/4/15.
//  Copyright © 2021 Jackey. All rights reserved.
//

#import "WechatDetailViewController.h"
#import "WechatView.h"
#import "MessageModel.h"
#import "ChatTextSendCell.h"
#import "ChatTextReciveCell.h"
#import "ChatKeyboardView.h"


@interface WechatDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property(nonatomic, strong)UITableView *chatTableView;
@property(nonatomic, strong)NSMutableArray *messageModelArray;
@property(nonatomic, strong)ChatKeyboardView *keyboardView;

@end

@implementation WechatDetailViewController

- (UITableView *)chatTableView {
    if (!_chatTableView) {
        _chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavH, SW, SH - NavH - TabH) style:UITableViewStylePlain];
        _chatTableView.delegate = self;
        _chatTableView.dataSource = self;
        _chatTableView.backgroundColor = RGBColor(237, 237, 237);
        _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_chatTableView registerClass:[ChatTextSendCell class] forCellReuseIdentifier:@"ChatTextSendCell"];
        [_chatTableView registerClass:[ChatTextReciveCell class] forCellReuseIdentifier:@"ChatTextReciveCell"];
    }
    return _chatTableView;
}

- (NSMutableArray *)messageModelArray {
    if (!_messageModelArray) {
        NSArray *textArray = @[
        @"这是初始聊天记录，然后发送消息，会随机生成本人或者对方的信息",
        @"这里只展示几条信息",
        @"后面的可以自己看着添加，想添加多少都行",
        @"我在多添加几行试试哈",
        @"我在多添加几行试试哈",
        @"我在多添加几行试试哈",
        @"我在多添加几行试试哈",
        @"我在多添加几行试试哈",
        @"我在多添加几行试试哈",
        @"我在多添加几行试试哈",
        @"我在多添加几行试试哈",
        @"我在多添加几行试试哈"];
        _messageModelArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < textArray.count; i++) {
            int j = arc4random_uniform(10);
            MessageModel *model = [[MessageModel alloc] init];
            model.messageContent = textArray[i];
            model.messageType = MessageType_Text;
            model.messageDerection = j % 2 == 0 ? MessageDerection_Recive : MessageDerection_Send;
            model.messageSize = [self chatContentSize:textArray[i]];
            [_messageModelArray addObject:model];
        }
    }
    return _messageModelArray;
}


- (ChatKeyboardView *)keyboardView {
    if (!_keyboardView) {
        _keyboardView = [[ChatKeyboardView alloc] init];
        _keyboardView.backgroundColor = RGBColor(245, 245, 245);
        __weak typeof(self) weakSelf = self;
        _keyboardView.messageBlock = ^(NSString * _Nonnull message) {
            __strong typeof(self) strongSelf = weakSelf;
            
            int j = arc4random_uniform(10);
            MessageModel *model = [[MessageModel alloc] init];
            model.messageContent = message;
            model.messageType = MessageType_Text;
            model.messageDerection = j % 2 == 0 ? MessageDerection_Recive : MessageDerection_Send;
            model.messageSize = [strongSelf chatContentSize:message];
            [strongSelf.messageModelArray addObject:model];
            
            [strongSelf.chatTableView reloadData];
            
            NSIndexPath *path = [NSIndexPath indexPathForRow:strongSelf.messageModelArray.count - 1 inSection:0];
            [strongSelf.chatTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        };
        [self.view addSubview:_keyboardView];
    }
    return _keyboardView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIMenuController
    
    self.view.backgroundColor = RGBColor(245, 245, 245);
    [self.view addSubview:self.chatTableView];
    
    self.keyboardView.frame = CGRectMake(0, SH - TabH, SW, 50);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardTypeChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSIndexPath *path = [NSIndexPath indexPathForRow:self.messageModelArray.count - 1 inSection:0];
        [self.chatTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    });
}


- (CGSize)chatContentSize:(NSString *)content {
    CGSize size = CGSizeMake(SW - 150, MAXFLOAT);
    CGSize newSize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
            NSFontAttributeName : [UIFont systemFontOfSize:17]
    } context:nil].size;
    return newSize;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageModel *model = self.messageModelArray[indexPath.row];
    if (model.messageDerection == MessageDerection_Send) {
        ChatTextSendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatTextSendCell"];
        cell.messageModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        ChatTextReciveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatTextReciveCell"];
        cell.messageModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MessageModel *model = self.messageModelArray[indexPath.row];
    return model.messageSize.height + 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.keyboardView.sendTextField isFirstResponder]) {
        [self.keyboardView.sendTextField resignFirstResponder];
        self.keyboardView.frame = CGRectMake(0, SH - TabH, SW, 50);
        NSIndexPath *path = [NSIndexPath indexPathForRow:self.messageModelArray.count - 1 inSection:0];
        
        [tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}
    

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.keyboardView isFirstResponder]) {
        [self.keyboardView.sendTextField resignFirstResponder];
        
        self.keyboardView.frame = CGRectMake(0, SH - TabH, SW, 50);
        NSIndexPath *path = [NSIndexPath indexPathForRow:self.messageModelArray.count - 1 inSection:0];
        
        [self.chatTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}


- (void)keyboardTypeChanged:(NSNotification *)notification {
    NSValue *value = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    NSNumber *time = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    CGRect rect = value.CGRectValue;
    CGFloat duration = time.floatValue;
    CGPoint originP = rect.origin;
    
    __block CGFloat h = rect.size.height;
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.keyboardView.frame;
        // 键盘隐藏
        if (originP.y == SH) {
            self.keyboardView.frame = CGRectMake(0, SH - TabH, SW, 50);
            // 恢复到初始位置
            self.chatTableView.frame = CGRectMake(0, NavH, SW, SH - NavH - TabH);
        } else {
            // 键盘弹出
            self.keyboardView.frame = CGRectMake(0, originP.y - frame.size.height, SW, frame.size.height);
            
            // 更新键盘弹出后chatTableView的位置
            self.chatTableView.frame = CGRectMake(0, NavH, SW, SH - NavH - h - 50);
        }
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:self.messageModelArray.count - 1 inSection:0];
        
        [self.chatTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.keyboardView.sendTextField resignFirstResponder];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
