//
//  MyProgressViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/13.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "MyProgressViewController.h"
#import "MyProgressView.h"

@interface MyProgressViewController ()
@property (weak, nonatomic) IBOutlet MyProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (weak, nonatomic) IBOutlet UISlider *sliderView;

@end

@implementation MyProgressViewController
- (IBAction)sliderAction:(UISlider *)sender {
    self.valueLabel.text = [NSString stringWithFormat:@"%.2f%%", sender.value * 100];
    self.progressView.progressValue = sender.value;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.sliderView.value = 0;
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
