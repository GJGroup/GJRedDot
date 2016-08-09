//
//  AppDelegate.m
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/19.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import "AppDelegate.h"
#import "GJRedDot.h"
#import "GJRedDotRegister.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [GJRedDot registWithProfile:[GJRedDotRegister registProfiles] defaultShow:YES];
    [GJRedDot setDefaultRadius:4];
    [GJRedDot setDefaultColor:[UIColor orangeColor]];
    //set tab bar item icon
    UITabBarController *tabVC = (UITabBarController*)self.window.rootViewController;
    UITabBarItem *item2 = tabVC.tabBar.items[1];
    [item2 setImage:[[UIImage imageNamed:@"tabIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //set tab bar item red dot
    [self setRedDotKey:GJTabBar2 refreshBlock:^(BOOL show) {
        item2.showRedDot = show;
    } handler:self];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
