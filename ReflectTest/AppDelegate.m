//
//  AppDelegate.m
//  ReflectTest
//
//  Created by yangyanxiang on 16/8/30.
//  Copyright © 2016年 yangyanxiang. All rights reserved.
//

#import "AppDelegate.h"
#import "UMessagePushUtil.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString *umengAppId = @"54ae3d8afd98c570b1000556";
//    [[UMessagePushUtil SharedUMPushUtil] initWithUmengAppKey:umengAppId launchOptions:launchOptions];
    [[UMessagePushUtil SharedUMPushUtil] initWithUmengAppKey:umengAppId storyboardName:@"Main" launchOptions:launchOptions];
    
    
    return YES;
}





- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
//    UMessagePushUtil.didRegisterForRemoteNotifications(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken, aliasName: aliasName, aliasType: AppData.sharedAppData()._umengPushType)
    NSString *aliasType = @"BAZIRIM_MESSAGE";
    NSString *aliasName = @"123456";
    [[UMessagePushUtil SharedUMPushUtil] didRegisterForRemoteNotifications:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken aliasName:aliasName aliasType:aliasType];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[UMessagePushUtil SharedUMPushUtil] didReceiveRemote:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"获取远程消息失败:%@",error);
//    [[UMessagePushUtil SharedUMPushUtil] application:application didFailToRegisterForRemoteNotificationsWithError:error];
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
//    [[UMessagePushUtil SharedUMPushUtil] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
