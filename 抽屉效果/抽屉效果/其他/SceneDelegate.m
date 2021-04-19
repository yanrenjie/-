#import "SceneDelegate.h"
#import "JieTabBarController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIWindowScene *windowScreen = (UIWindowScene *)scene;
    self.window.windowScene = windowScreen;
    [self.window makeKeyAndVisible];
    
    JieTabBarController *vc = [[JieTabBarController alloc] init];
    self.window.rootViewController = vc;
    self.window.backgroundColor = UIColor.whiteColor;
}


@end
