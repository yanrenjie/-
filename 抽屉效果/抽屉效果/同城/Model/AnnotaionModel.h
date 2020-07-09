//
//  AnnotaionModel.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/3.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnnotaionModel : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;

// Title and subtitle for use by selection UI.
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END
