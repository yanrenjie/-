//
//  ClockViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/16.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "ClockViewController.h"

@interface ClockViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *clockImageView;
@property(nonatomic, strong)CALayer *secondHandLayer;
@property(nonatomic, strong)CALayer *minimumHandLayer;
@property(nonatomic, strong)CALayer *hourHandLayer;
@property(nonatomic, strong)CALayer *blackLayer;
@property(nonatomic, strong)NSTimer *timer;

@end

@implementation ClockViewController

- (CALayer *)secondHandLayer {
    if (!_secondHandLayer) {
        _secondHandLayer = [CALayer layer];
        _secondHandLayer.backgroundColor = UIColor.redColor.CGColor;
        _secondHandLayer.frame = CGRectMake(0, 0, 1, 100);
        _secondHandLayer.anchorPoint = CGPointMake(0.5, 1);
        _secondHandLayer.position = CGPointMake(self.clockImageView.bounds.size.width / 2, self.clockImageView.bounds.size.height / 2);
    }
    return _secondHandLayer;
}


- (CALayer *)minimumHandLayer {
    if (!_minimumHandLayer) {
        _minimumHandLayer = [CALayer layer];
        _minimumHandLayer.backgroundColor = UIColor.blackColor.CGColor;
        _minimumHandLayer.frame = CGRectMake(0, 0, 3, 80);
        _minimumHandLayer.anchorPoint = CGPointMake(0.5, 1);
        _minimumHandLayer.position = CGPointMake(self.clockImageView.bounds.size.width / 2, self.clockImageView.bounds.size.height / 2);

    }
    return _minimumHandLayer;
}


- (CALayer *)hourHandLayer {
    if (!_hourHandLayer) {
        _hourHandLayer = [CALayer layer];
        _hourHandLayer.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.7].CGColor;
        _hourHandLayer.frame = CGRectMake(0, 0, 3, 60);
        _hourHandLayer.anchorPoint = CGPointMake(0.5, 1);
        _hourHandLayer.position = CGPointMake(self.clockImageView.bounds.size.width / 2, self.clockImageView.bounds.size.height / 2);
    }
    return _hourHandLayer;
}


- (CALayer *)blackLayer {
    if (!_blackLayer) {
        _blackLayer = [CALayer layer];
        _blackLayer.backgroundColor = UIColor.blackColor.CGColor;
        _blackLayer.cornerRadius = 5;
        _blackLayer.frame = CGRectMake(0, 0, 10, 10);
        _blackLayer.position = CGPointMake(self.clockImageView.bounds.size.width / 2, self.clockImageView.bounds.size.width / 2);
    }
    return _blackLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加时，分，秒针，因为不需要进行交互，直接使用CALayer操作
    [self addHand];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(run) userInfo:nil repeats:YES];
    self.timer = timer;
    
    // 获取当前时间的时分秒数据，通过日历组件来获取
    /**
     NSCalendar *calendar = [NSCalendar currentCalendar];
     NSDateComponents *component = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
     NSInteger h = component.hour;
     NSInteger m = component.minute;
     NSInteger s = component.second;
     */

    
    // 获取当前时间
    NSString *currentTime = [self getCurrentTime];
    
    // 设置默认时间
    [self setDefaultTime:currentTime];
}


- (void)addHand {
    [self.clockImageView.layer addSublayer:self.hourHandLayer];
    [self.clockImageView.layer addSublayer:self.minimumHandLayer];
    [self.clockImageView.layer addSublayer:self.secondHandLayer];
    [self.clockImageView.layer addSublayer:self.blackLayer];
}


- (void)run {
    CGFloat angle1 = M_PI * 2 / 60;
    CGFloat angle2 = M_PI * 2 / (60 * 60);
    CGFloat angle3 = M_PI * 2 / (60 * 60 * 12);
    self.secondHandLayer.transform = CATransform3DRotate(self.secondHandLayer.transform, angle1, 0, 0, 1);

    self.minimumHandLayer.transform = CATransform3DRotate(self.minimumHandLayer.transform, angle2, 0, 0, 1);

    self.hourHandLayer.transform = CATransform3DRotate(self.hourHandLayer.transform, angle3, 0, 0, 1);
}


- (NSString *)getCurrentTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *time = [formatter stringFromDate:date];
    return [time substringFromIndex:11];
}


- (void)setDefaultTime:(NSString *)time {
    NSArray *array = [time componentsSeparatedByString:@":"];
    NSInteger hour = [array.firstObject integerValue] % 12;
    NSInteger min = [array[1] integerValue];
    NSInteger sec = [array.lastObject integerValue];
    
    CGFloat angle1 = M_PI * 2 / 12 * hour + M_PI * 2 / (12 * 60) * min + M_PI * 2 / (60 * 60 * 12) * sec;
    CGFloat angle2 =  M_PI * 2 / 60 * min + M_PI * 2 / (60 * 60) * sec;
    CGFloat angle3 = M_PI * 2 / 60 * sec;
    
    [CATransaction setDisableActions:NO];
    
    self.hourHandLayer.transform = CATransform3DRotate(self.hourHandLayer.transform, angle1, 0, 0, 1);
    self.minimumHandLayer.transform = CATransform3DRotate(self.minimumHandLayer.transform, angle2, 0, 0, 1);
    self.secondHandLayer.transform = CATransform3DRotate(self.secondHandLayer.transform, angle3, 0, 0, 1);
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

@end
