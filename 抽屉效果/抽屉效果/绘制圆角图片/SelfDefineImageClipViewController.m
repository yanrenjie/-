//
//  SelfDefineImageClipViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/14.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "SelfDefineImageClipViewController.h"

@interface SelfDefineImageClipViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic, assign)CGPoint startPoint;
@property(nonatomic, assign)CGPoint endPoint;
@property(nonatomic, strong)UIView *coverView;

@end

@implementation SelfDefineImageClipViewController

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.alpha = 0.5;
        _coverView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_coverView];
    }
    return _coverView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)clipAction:(UIPanGestureRecognizer *)sender {
    // 获取起始点
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint startPoint = [sender locationInView:self.imageView];
        self.startPoint = startPoint;
    }
    // 手指滑动过程中
    else if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint endPoint = [sender locationInView:self.imageView];
        self.endPoint = endPoint;
        
        CGFloat offsetX = self.endPoint.x - self.startPoint.x;
        CGFloat offsetY = self.endPoint.y - self.startPoint.y;
        
        // 活动类似电脑桌面鼠标按住画框的方式
        CGRect rect;
        if (offsetX < 0) {
            if (offsetY < 0) {
                rect = CGRectMake(self.endPoint.x, self.endPoint.y, fabs(offsetX), fabs(offsetY));
            } else {
                rect = CGRectMake(self.endPoint.x, self.startPoint.y, fabs(offsetX), fabs(offsetY));
            }
        } else {
            if (offsetY < 0) {
                rect = CGRectMake(self.startPoint.x, self.endPoint.y, fabs(offsetX), fabs(offsetY));
            } else {
                rect = CGRectMake(self.startPoint.x, self.startPoint.y, fabs(offsetX), fabs(offsetY));
            }
        }
        self.coverView.frame = rect;
    }
    // 获取结束点
    else if (sender.state == UIGestureRecognizerStateEnded) {
        [self clipImage];
        
        [self.coverView removeFromSuperview];
        self.coverView = nil;
    }
}


- (void)clipImage {
//    UIImage *image = self.imageView.image;
//    UIGraphicsBeginImageContext(self.imageView.frame.size);
//
//    // 设置裁剪区域
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.coverView.frame];
//    [path addClip];
//
//    [image drawInRect:self.imageView.bounds];
//
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    self.imageView.image = newImage;
//
//    // 将图片转化为流数据写入文件
//    NSData *data = UIImagePNGRepresentation(newImage);
//
//    // 将文件保存到指定文件当中，同步方式保存
//    [data writeToFile:@"/Users/yanrenhao/Desktop/OC/ComprehensiveProject/抽屉效果/ScreenShot/clipImage.png" atomically:YES];
    
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0.0);
    UIRectClip(self.coverView.frame);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.imageView.layer renderInContext:context];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    self.imageView.image = newImage;
    
    NSData *data = UIImagePNGRepresentation(newImage);

    // 将文件保存到指定文件当中，同步方式保存
    [data writeToFile:@"/Users/yanrenhao/Desktop/OC/ComprehensiveProject/抽屉效果/ScreenShot/clipImage.png" atomically:YES];
}


@end
