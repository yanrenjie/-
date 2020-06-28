//
//  GraffitiBoardView.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/15.
//  Copyright © 2020 Jackey. All rights reserved.
//

// 涂鸦画板
#import "GraffitiBoardView.h"

@interface GraffitiBoardView ()

@property(nonatomic, strong)UIBezierPath *path;
@property(nonatomic, strong)NSMutableArray<UIBezierPath *> *pathArray;
@property(nonatomic, strong)UIColor *currentColor;
@property(nonatomic, assign)CGFloat currentWidth;
// 也可以给UIBezierPath扩充一个颜色属性，便于在drawRect方法中直接使用
@property(nonatomic, strong)NSMutableArray *colorArray;
@end


@implementation GraffitiBoardView

- (NSMutableArray<UIBezierPath *> *)pathArray {
    if (!_pathArray) {
        _pathArray = [[NSMutableArray alloc] init];
    }
    return _pathArray;
}


- (NSMutableArray *)colorArray {
    if (!_colorArray) {
        _colorArray = [[NSMutableArray alloc] init];
    }
    return _colorArray;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.currentColor = UIColor.redColor;
    self.currentWidth = 5;
    // 给画板添加一个拖拽手势
    [self addGestureAction];
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.currentColor = UIColor.redColor;
        self.currentWidth = 5;
        [self addGestureAction];
    }
    return self;
}


- (void)addGestureAction {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}


- (void)pan:(UIPanGestureRecognizer *)pan {
    // 获取当前点
    CGPoint currentPoint = [pan locationInView:self];
    
    // 记录开始的起点位置
    if (pan.state == UIGestureRecognizerStateBegan) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        self.path = path;
        [path setLineCapStyle:kCGLineCapRound];
        [path setLineJoinStyle:kCGLineJoinRound];
        [path setLineWidth:self.currentWidth];
        [self.colorArray addObject:self.currentColor];
        [self.path moveToPoint:currentPoint];
        [self.pathArray addObject:path];
    }
    // 手指在移动过程中
    else if (pan.state == UIGestureRecognizerStateChanged) {
        [self.path addLineToPoint:currentPoint];
        
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    for (int i = 0; i < self.pathArray.count; i++) {
        UIBezierPath *path = self.pathArray[i];
        UIColor *color = self.colorArray[i];
        [color set];
        [path stroke];
    }
}

- (void)clearAction {
    [self.pathArray removeAllObjects];
    [self.colorArray removeAllObjects];
    
    [self setNeedsDisplay];
}


- (void)backAction {
    if (self.pathArray.count > 0) {
        [self.pathArray removeLastObject];
        [self.colorArray removeLastObject];
        [self setNeedsDisplay];
    }
}


- (void)xiangpicaAction {
    self.currentColor = UIColor.whiteColor;
}


- (void)setPencilWidth:(CGFloat)width {
    self.currentWidth = width;
}

- (void)setPencilColor:(UIColor *)color {
    self.currentColor = color;
}


- (void)saveAction {
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
//    NSData *data = UIImagePNGRepresentation(image);
//    [data writeToFile:@"/Users/yanrenhao/Desktop/OC/ComprehensiveProject/抽屉效果/涂鸦/tuya.png" atomically:YES];
    UIGraphicsEndImageContext();
    
    // 把生成的图片保存到系统相册
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}


- (void)photoLibrary {
    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"保存到系统相册之后调用的方法必须是这个方法，不是自己随便乱写的方法");
}
//- (void)success {
//    NSLog(@"%s", __func__);
//}

@end
