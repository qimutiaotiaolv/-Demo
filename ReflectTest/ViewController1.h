//
//  ViewController.h
//  ReflectTest
//
//  Created by yangyanxiang on 16/8/30.
//  Copyright © 2016年 yangyanxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIViewController+PushInfo.h"
#import "UIViewController+PushInfo.h"
#import "UMessagePushUtil.h"
@interface CustomerView : UIView
@property(nonatomic,retain) NSString* _fieldString;
-(void) printSelf;
-(void) printSelfWithParam:(NSString*) param;
@end



@interface ViewController1 : UIViewController


@end

