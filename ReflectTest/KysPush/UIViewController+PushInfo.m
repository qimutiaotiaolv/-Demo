//
//  UIViewController+PushInfo.m
//  ReflectTest
//
//  Created by yangyanxiang on 16/9/7.
//  Copyright © 2016年 yangyanxiang. All rights reserved.
//

#import "UIViewController+PushInfo.h"

@implementation UIViewController (PushInfo)
-(void)viewWillAppear:(BOOL)animated{
    Class selfClass = [self class];
    Class tabClass = [UITabBarController class];
    Class navClass = [UINavigationController class];
    Class inputClass = [UIInputViewController class];
    Class windowClass = NSClassFromString(@"UIInputWindowController");
    Class alertClass = [UIAlertController class];
    Class _alertClass = NSClassFromString(@"_UIAlertShimPresentingViewController");
    Class followingControllerClass = NSClassFromString(@"UIApplicationRotationFollowingController");
    if(selfClass == tabClass || selfClass == navClass || selfClass == inputClass || selfClass == windowClass || selfClass == alertClass || selfClass == _alertClass || selfClass == followingControllerClass){
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SET_CUR_VC" object:self];
}
-(void)viewDidAppear:(BOOL)animated{
    Class selfClass = [self class];
    Class tabClass = [UITabBarController class];
    Class navClass = [UINavigationController class];
    Class inputClass = [UIInputViewController class];
    Class windowClass = NSClassFromString(@"UIInputWindowController");
    Class alertClass = [UIAlertController class];
    Class _alertClass = NSClassFromString(@"_UIAlertShimPresentingViewController");
    Class followingControllerClass = NSClassFromString(@"UIApplicationRotationFollowingController");
    if(selfClass == tabClass || selfClass == navClass || selfClass == inputClass || selfClass == windowClass || selfClass == alertClass || selfClass == _alertClass || selfClass == followingControllerClass){
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SET_CUR_VC" object:self];
}

-(void)viewDidDisappear:(BOOL)animated{
    Class selfClass = [self class];
    Class tabClass = [UITabBarController class];
    Class navClass = [UINavigationController class];
    Class inputClass = [UIInputViewController class];
    Class windowClass = NSClassFromString(@"UIInputWindowController");
    Class alertClass = [UIAlertController class];
    Class _alertClass = NSClassFromString(@"_UIAlertShimPresentingViewController");
    Class followingControllerClass = NSClassFromString(@"UIApplicationRotationFollowingController");
    if(selfClass == tabClass || selfClass == navClass || selfClass == inputClass || selfClass == windowClass || selfClass == alertClass || selfClass == _alertClass || selfClass == followingControllerClass){
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SET_CUR_VC" object:nil];
}
@end
