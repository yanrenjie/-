//
//  RoundImageViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/14.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "RoundImageViewController.h"

@interface RoundImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@end

@implementation RoundImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self clipImageWithName:@"wife_thumb"];
    
    [self addWatermarkForImage:@"wife_thumb"];
    
    [self clipImageWithBorder:@"wife_thumb"];
}



#pragma mark - 图片裁剪
- (void)clipImageWithName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(image.size);
    
    // 设置裁剪路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    // 超出的部分会被裁减掉
    [path addClip];
    
    // 将图片绘制到上下文当中
    [image drawAtPoint:CGPointZero];
    
    // 从当前上下文中获取一个新的裁剪后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    self.imageView2.image = newImage;
}


// 给图片添加水印
- (void)addWatermarkForImage:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    NSString *watermarkString = @"我是水印字符串";
    
    // 开启一个位图上下文
    UIGraphicsBeginImageContext(image.size);
    
    [image drawAtPoint:CGPointZero];
    
    [watermarkString drawAtPoint:CGPointMake(0, image.size.height - 30) withAttributes:@{
        NSForegroundColorAttributeName : UIColor.redColor,
        NSFontAttributeName : [UIFont systemFontOfSize:18],
        NSStrokeWidthAttributeName : @5
    }];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.imageView1.image = newImage;
}


// 带有边框的图片的裁剪
- (void)clipImageWithBorder:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width + 20, image.size.height + 20));
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width + 20, image.size.height + 20)];
    [[UIColor orangeColor] setFill];
    [path1 fill];
    

    UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, image.size.width, image.size.height)];
    [path2 addClip];
    
    [image drawInRect:CGRectMake(10, 10, image.size.width, image.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    self.imageView.image = newImage;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self screenshotAction];
}

// 截屏操作
- (void)screenshotAction {
    // UIGraphicsGetCurrentContext(); // 当前获取不到上下文
    
    // 截屏的本质，也是生产一张图片
    // 1、开启图形上下文
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    // 把控制器View的内容绘制到上下文当中（上下文与layer之间是通过渲染的方式进行交互的）
    // 上面已经开启了一个上下文位图，现在可以获取上下文了，在开启上下文之前是不能获取上下文的
    CGContextRef ref = UIGraphicsGetCurrentContext();
    // 2、把layer层的内容绘制渲染到上下文当中
    // 此处可以指定某个View的layer进行渲染
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:ref];
    
    // 3、从上下文当中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    NSData *data = UIImagePNGRepresentation(image);
    
    // 将文件保存到指定文件当中，同步方式保存
    [data writeToFile:@"/Users/yanrenhao/Desktop/OC/抽屉效果/ScreenShot/screenShot.png" atomically:YES];
    
    // 4、关闭上下文
    UIGraphicsEndImageContext();
}

@end
