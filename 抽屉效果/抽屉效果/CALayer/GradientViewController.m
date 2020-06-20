//
//  GradientViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/18.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "GradientViewController.h"

@interface GradientViewController ()

@end

@implementation GradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.colors = @[(__bridge id)UIColor.redColor.CGColor, (__bridge id)UIColor.orangeColor.CGColor, (__bridge id)UIColor.yellowColor.CGColor, (__bridge id)UIColor.greenColor.CGColor, (__bridge id)UIColor.grayColor.CGColor, (__bridge id)UIColor.blueColor.CGColor, (__bridge id)UIColor.purpleColor.CGColor];
    layer.locations = @[@0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @1];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 1);
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
