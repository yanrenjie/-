//
//  JieAnitionTransitionViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/14.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "JieAnitionTransitionViewController.h"

@interface JieAnitionTransitionViewController ()

@end

@implementation JieAnitionTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemPinkColor;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
