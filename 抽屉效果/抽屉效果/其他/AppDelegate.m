//
//  AppDelegate.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/13.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "AppDelegate.h"
#import "ThreadViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    if (@available(iOS 13, *)) {
//        return YES;
//    } else {
//        ViewController *vc = [[ViewController alloc] init];
//        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:vc];
//        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//        [self.window makeKeyAndVisible];
//        self.window.backgroundColor = UIColor.whiteColor;
//        self.window.rootViewController = naVC;
//    }
//    ThreadViewController *vc = [ThreadViewController new];
//    extern int _jie;
//    extern NSString *_jie_name;
//    _jie = 300;
//    _jie_name = @"Le Bron James";
//    NSLog(@"%d  ------   %@", _jie, _jie_name);
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
