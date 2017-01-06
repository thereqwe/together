//
//  AppDelegate.m
//  Together
//
//  Created by Yue Shen on 2017/1/4.
//  Copyright © 2017年 Yue Shen. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "SYLActivityMapViewController.h"
#import "SYLMessageViewController.h"
#import "SYLSetupViewController.h"
@interface AppDelegate ()
{
    BaseNavigationController *navi;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.backgroundColor = [UIColor whiteColor];
    self.window = window;
    SYLActivityMapViewController *vc0 = [SYLActivityMapViewController new];
    SYLMessageViewController *vc1 = [SYLMessageViewController new];
    SYLSetupViewController *vc2 = [SYLSetupViewController new];
    UITabBarController *tab = [[UITabBarController alloc]init];
    [tab setViewControllers:@[vc0,vc1,vc2]];
    navi = [[BaseNavigationController alloc] initWithRootViewController:tab];
    [navi setNavigationBarHidden:YES];
    window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    [self setupEnv];
    return YES;
}

- (void)setupEnv {
    [AMapServices sharedServices].apiKey = @"e590b8299c0475aaff1e3d58e3c22964";
    [[AMapServices sharedServices] setEnableHTTPS:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
