//
//  GraffitiBoardViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/15.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "GraffitiBoardViewController.h"
#import "GraffitiBoardView.h"

@interface GraffitiBoardViewController ()
@property (weak, nonatomic) IBOutlet GraffitiBoardView *boardView;

@end

@implementation GraffitiBoardViewController
// 清屏
- (IBAction)clear:(UIButton *)sender {
    [self.boardView clearAction];
}

// 撤销
- (IBAction)back:(UIButton *)sender {
    [self.boardView backAction];
}

// 橡皮擦
- (IBAction)xiangpica:(UIButton *)sender {
    [self.boardView xiangpicaAction];
}


- (IBAction)setPencilColor:(UIButton *)sender {
    [self.boardView setPencilColor:sender.backgroundColor];
}


- (IBAction)setPencilWidth:(UISlider *)sender {
    [self.boardView setPencilWidth:sender.value];
}


- (IBAction)save:(id)sender {
    [self.boardView saveAction];
}

- (IBAction)photoLibrary:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end
