//
//  SetRoundCornerImageWithShadowViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/15.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "SetRoundCornerImageWithShadowViewController.h"

@interface SetRoundCornerImageWithShadowViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SetRoundCornerImageWithShadowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.layer.cornerRadius = 15;
    self.imageView.layer.shadowColor = UIColor.redColor.CGColor;
    self.imageView.layer.shadowOffset = CGSizeMake(5, 5);
    self.imageView.layer.shadowRadius = 15;
    
    
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
