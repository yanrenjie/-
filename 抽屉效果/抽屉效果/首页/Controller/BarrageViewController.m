//
//  BarrageViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2021/4/25.
//  Copyright © 2021 Jackey. All rights reserved.
//

#import "BarrageViewController.h"
#import "BarrageModel.h"
#import "BarrageLabel.h"

@interface BarrageViewController ()

@property(nonatomic, strong)NSMutableArray<BarrageModel *> *barrageArray;

@property(nonatomic, strong)UIView *blackView; // 显示弹幕的黑色背景

@property(nonatomic, strong)NSTimer *barrageTimer; // 每隔指定时间向屏幕上添加一条弹幕
@property(nonatomic, strong)NSTimer *updateBarrageTimer; // 更新屏幕上的弹幕的位置

@property(nonatomic, assign)NSInteger barrageIndex; // 当前要添加到屏幕上的弹幕的角标

@property(nonatomic, strong)NSMutableArray<BarrageLabel *> *visiableBarrageArray;// 当前屏幕可见的所有弹幕

@end

@implementation BarrageViewController

- (NSMutableArray<BarrageModel *> *)barrageArray {
    if (!_barrageArray) {
        _barrageArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 50; i++) {
            BarrageModel *model = [[BarrageModel alloc] init];
            model.barrageContent = [NSString stringWithFormat:@"这是一条弹幕，序号是%d", i];
            model.rowNumber = i % 5;
            model.scrollSpeed = i % 2 + 1;
            model.contentSize = [self chatContentSize:model.barrageContent];
            [_barrageArray addObject:model];
        }
    }
    return _barrageArray;
}


- (NSTimer *)barrageTimer {
    if (!_barrageTimer) {
        _barrageTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(addBarrageAction) userInfo:nil repeats:YES];
    }
    return _barrageTimer;
}


- (NSTimer *)updateBarrageTimer {
    if (!_updateBarrageTimer) {
        _updateBarrageTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateFrameBarrageAction) userInfo:nil repeats:YES];
    }
    return _updateBarrageTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.barrageIndex = 0;
    
    [self.view addSubview:self.blackView];
    [self.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(200);
        make.top.offset(NavH);
    }];
    
    [self.barrageTimer fire];
    [self.updateBarrageTimer fire];
}

- (UIView *)blackView {
    if (!_blackView) {
        _blackView = [[UIView alloc] init];
        _blackView.backgroundColor = UIColor.blackColor;
    }
    return _blackView;
}


- (NSMutableArray<BarrageLabel *> *)visiableBarrageArray {
    if (!_visiableBarrageArray) {
        _visiableBarrageArray = [[NSMutableArray alloc] init];
    }
    return _visiableBarrageArray;
}

#pragma mark - 弹幕
- (void)addBarrageAction {
    BarrageModel *model = self.barrageArray[self.barrageIndex];
    
    BarrageLabel *label = [[BarrageLabel alloc] initWithFrame:CGRectMake(SW, model.rowNumber * 40, model.contentSize.width + 30, 40)];
    label.textColor = UIColor.whiteColor;
    label.text = model.barrageContent;
    label.barrageModel = model;
    [self.blackView addSubview:label];
    
    [self.visiableBarrageArray addObject:label];
    
    self.barrageIndex++;
    if (self.barrageIndex == self.barrageArray.count - 1) {
        self.barrageIndex = 0;
    }
}


- (void)updateFrameBarrageAction {
    NSLog(@"当前有------->     %ld     条可见弹幕", self.visiableBarrageArray.count);
    
    for (BarrageLabel *label in self.visiableBarrageArray) {
        CGRect frame = label.frame;
        frame.origin.x -= label.barrageModel.scrollSpeed;
        label.frame = frame;
    }
    
    for (int i = 0; i < self.visiableBarrageArray.count; i++) {
        BarrageLabel *label = self.visiableBarrageArray[i];
        if (label.frame.origin.x + label.frame.size.width <= 0) {
            [label removeFromSuperview];
            [self.visiableBarrageArray removeObject:label];
        }
    }
}


- (CGSize)chatContentSize:(NSString *)content {
    CGSize size = CGSizeMake(SW - 150, MAXFLOAT);
    CGSize newSize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
            NSFontAttributeName : [UIFont systemFontOfSize:17]
    } context:nil].size;
    return newSize;
}


#pragma mark - 菜单
/*
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyAction)];
    UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(forwardAction)];
    UIMenuItem *item3 = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(saveAction)];
    UIMenuItem *item4 = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteAction)];
    UIMenuItem *item5 = [[UIMenuItem alloc] initWithTitle:@"搜一搜" action:@selector(searchAction)];
    
    menuController.menuItems = @[item1, item2, item3, item4, item5];
    [menuController showMenuFromView:self.view rect:CGRectMake(50, 100, 200, 250)];
//    menuController.arrowDirection = UIMenuControllerArrowDefault;
    
    menuController.arrowDirection = UIMenuControllerArrowUp;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copyAction) || action == @selector(forwardAction)) {
        return YES;
    }
    return NO;
    
}


- (void)copyAction {
    NSLog(@"copyAction");
}

- (void)forwardAction {
    NSLog(@"forwardAction");
}

- (void)saveAction {
    NSLog(@"saveAction");
}

- (void)deleteAction {
    NSLog(@"deleteAction");
}

- (void)searchAction {
    NSLog(@"searchAction");
}
 */

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.barrageTimer invalidate];
    [self.updateBarrageTimer invalidate];
}


- (void)dealloc {
    NSLog(@"------- 弹幕结束");
}

@end
