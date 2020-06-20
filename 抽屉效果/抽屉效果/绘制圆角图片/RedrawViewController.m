//
//  RedrawViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/18.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "RedrawViewController.h"
#import "RedrawView.h"

@interface RedrawViewController ()
@property (weak, nonatomic) IBOutlet RedrawView *redrawView;

@end

@implementation RedrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)begin:(id)sender {
    [self.redrawView beginAction];
}

- (IBAction)clear:(id)sender {
    [self.redrawView clearAction];
}

@end

