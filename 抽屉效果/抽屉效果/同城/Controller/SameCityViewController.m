//
//  SameCityViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/29.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "SameCityViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "AnnotaionModel.h"

@interface SameCityViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property(nonatomic, strong)CLLocationManager *manager;

@property(nonatomic, strong)MKMapView *mapView;
@end

@implementation SameCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 首先创建一个定位管理者
    self.manager = [[CLLocationManager alloc] init];
    
    // 请求受理权限
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.manager requestWhenInUseAuthorization];
    }
    
    // 设置代理
    self.manager.delegate = self;
    
    // 开始定位
    [self.manager startUpdatingLocation];
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    AnnotaionModel *model1 = [[AnnotaionModel alloc] init];
    model1.coordinate = CLLocationCoordinate2DMake(23.2343, 110.234);
    model1.title = @"广州市";
    model1.subtitle = @"广州市天河区五山路";
    [mapView addAnnotation:model1];
    _mapView = mapView;
    _mapView.delegate = self;
    
    [self.view addSubview:mapView];
}

// 当用户的位置更新完成之后调用，返回一组位置信息
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.count == 0) {
        return;
    }
    
    for (CLLocation *location in locations) {
        NSLog(@"%@", location);
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint p = [[touches anyObject] locationInView:self.mapView];
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:p toCoordinateFromView:self.mapView];
    
    AnnotaionModel *m = [[AnnotaionModel alloc] init];
    m.coordinate = coordinate;
    
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    CLLocation *l = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [coder reverseGeocodeLocation:l completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count != 0 && error == nil) {
            CLPlacemark *mark = placemarks.lastObject;
            m.title = mark.locality;
            m.subtitle = mark.name;
            return;
        }
    }];
    
    [self.mapView addAnnotation:m];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *reuseString = @"reuseString";
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseString];
    pin.pinTintColor = UIColor.greenColor;
//    pin.image = [UIImage imageNamed:@"liuyifei3"];
    return pin;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    NSLog(@"%.2f    =====     %.2f", view.annotation.coordinate.latitude, view.annotation.coordinate.longitude);
    [mapView removeAnnotation:view.annotation];
}

@end
