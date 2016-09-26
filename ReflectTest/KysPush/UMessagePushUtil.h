//
//  UMessage.h
//  ReflectTest
//
//  Created by yangyanxiang on 16/9/7.
//  Copyright © 2016年 yangyanxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMessage.h>
#import <UIKit/UIApplication.h>


#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000
@interface UMessagePushUtil : NSObject<UIAlertViewDelegate>
@property(nonatomic,weak) UIViewController* _umUtilCurViewController;
@property(nonatomic,retain) NSString *_storyboardName;
@property(nonatomic,retain) NSDictionary* _userInfo;
-(void) initWithUmengAppKey:(NSString*) AppKey storyboardName:(NSString*)storyboardName launchOptions: (NSDictionary *) opts;
- (void) didRegisterForRemoteNotifications:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken aliasName: (NSString*)alias aliasType:(NSString*)type;
- (void) didReceiveRemote:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;
- (void) didFailToRegisterForRemote:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
- (void) addAlias:(NSString*)alias aliasType:(NSString*)type;
- (void) addTags:(id)tags;
- (void) jumpWithRemoteNotification:(NSDictionary *)userInfo storyboardName:(NSString*)storyboardName;
- (void) registeViewController:(UIViewController*)vc;
- (void) removeViewController;
-(void) notification_remote_push;
-(void) jumpcenterWhenOpenApp;
/**
 * 0: 直接跳转 1：打开UIAlert
 * from:
 *      0) 直接跳转
 *      1）UIalert
 */
- (void) jumpFrom:(NSUInteger)from userInfo:(NSDictionary *)userInfo;
+(id) SharedUMPushUtil;
@end


