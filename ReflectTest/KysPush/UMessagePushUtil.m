//
//  UMessage.m
//  ReflectTest
//
//  Created by yangyanxiang on 16/9/7.
//  Copyright © 2016年 yangyanxiang. All rights reserved.
//

#import "UMessagePushUtil.h"
#import "CustomerVC.h"

static UMessagePushUtil *PUSHUTIL_INSTANCE = nil;
@implementation UMessagePushUtil
@synthesize _umUtilCurViewController;
@synthesize _storyboardName;
@synthesize _userInfo;

-(void) alertMessage:(NSString*)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

-(void) initWithUmengAppKey:(NSString*) AppKey storyboardName:(NSString*)storyboardName launchOptions: (NSDictionary *) opts{
    NSString* umAppKey = AppKey;
    self._storyboardName = storyboardName;
    //set AppKey and LaunchOptions
    [UMessage startWithAppkey:umAppKey launchOptions:opts];
    [UMessage setAutoAlert:NO];
//    [UMessage debu]
    //    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
        
    } else{
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //UIApplicationLaunchOptionsRemoteNotificationKey
    NSDictionary *userInfo = (NSDictionary*)opts[UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo != nil){
        self._userInfo = userInfo;
//        [self jumpcenterWhenOpenApp];
    }
    
    //for log
    [UMessage setLogEnabled:YES];
}

- (void) didRegisterForRemoteNotifications:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken aliasName: (NSString*)alias aliasType:(NSString*)type{
    NSLog(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
    [UMessage registerDeviceToken:deviceToken];
    NSLog(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
    if(alias != nil && type != nil){
        [self addAlias:alias aliasType:type];
    }
    id deviceInfoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* appVersion = deviceInfoDict[@"CFBundleShortVersionString"];
    appVersion = [appVersion stringByAppendingString:@"_bata"];
    [self addTags:appVersion];
}


- (void) addTags:(id)tags{
    [UMessage removeAllTags:^(id responseObject, NSInteger remain, NSError *error) {
        [UMessage addTag:tags response:^(id responseObject, NSInteger remain, NSError *error) {
            if (error != nil){
                NSLog(@"%@",error);
            }else{
                NSLog(@"%@",responseObject);
            }
            
        }];
        if (error != nil){
            NSLog(@"%@",error);
        }else{
            NSLog(@"%@",responseObject);
        }
    }];
    
}

- (void) addAlias:(NSString*)alias aliasType:(NSString*)type{
    if (![alias isEqualToString:@"nil"]){
        id deviceInfoDict = [[NSBundle mainBundle] infoDictionary];
        NSString* appVersion = deviceInfoDict[@"CFBundleShortVersionString"];
        appVersion = [appVersion stringByAppendingString:@"_bata"];
        [self addTags:appVersion];
        [UMessage setAlias:alias type:type response:^(id responseObject, NSError *error) {
            if (error != nil){
                NSLog(@"%@",error);
            }else{
                NSLog(@"%@",responseObject);
            }
            
        }];
        
        
    }
}


-(void) jumpcenterWhenOpenApp{
    if(self._userInfo != nil){
        [self jumpFrom:0 userInfo:self._userInfo];
    }
}




- (void) didReceiveRemote:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [UMessage didReceiveRemoteNotification:userInfo];
    self._userInfo = userInfo;
    [self jumpFrom:1 userInfo:userInfo];
}

- (void) didFailToRegisterForRemote:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    if(1 == buttonIndex){
        [self jumpWithRemoteNotification:self._userInfo storyboardName:self._storyboardName];
    }

}

/**
 * 0: 直接跳转 1：打开UIAlert
 * from:
 *      0) 直接跳转
 *      1）UIalert
 */
- (void) jumpFrom:(NSUInteger)from userInfo:(NSDictionary *)userInfo{
    self._userInfo = userInfo;
    if(0 == from){
        [self jumpWithRemoteNotification:userInfo storyboardName:self._storyboardName];
    }
    else if(1 == from){
        NSString *message = @"";
        NSDictionary *apsData = (NSDictionary*)userInfo[@"aps"];
        if (apsData != nil){
            NSString *sound = apsData[@"sound"];
            NSString *alertMsg = apsData[@"alert"];
            message = alertMsg;
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}


- (void) jumpWithRemoteNotification:(NSDictionary *)userInfo storyboardName:(NSString*)storyboardName{
    /**
     * key: data
     * value: {"class":"UserViewController","instancefrom":"storyboard or code","method":"updateWithMode","propertys":{"type":"string or number or dict or array or model","value":"100 or \"stringvalue\" or {"key1":"value1","key2":"value2"} or ["v1","v2"] {"tocken":"akleiur8249","isvip":false}"},"modelname":"UserModel"}
     
     {"class":"CustomerVC","instancefrom":"storyboard","method":"updateWithModel","modelname":"UserModel","propertys":{"type":"model","modelname":"UserModel","value":{"_name":"用户01","_tocken":"010","_age":25}}}
     
     */
    
    if(self._umUtilCurViewController == nil){
        return;
    }
    
    NSDictionary *dataDict = userInfo[@"data"];
    if(dataDict == nil){
        return;
    }
    
    NSString *className = dataDict[@"class"];
    NSString *instancefrom = dataDict[@"instancefrom"];
    NSString *method = dataDict[@"method"];
    NSDictionary *propertysDict = dataDict[@"propertys"];
    UIViewController *subVC = nil;
    NSObject *paramObj = nil;
    if([@"storyboard" isEqualToString:instancefrom]){ //从故事板实例化
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
        subVC = [storyboard instantiateViewControllerWithIdentifier:className];
    }else if([@"code" isEqualToString:instancefrom]){ //通过代码实例化
        Class class = NSClassFromString(className);
        subVC = [[class alloc] init];
    }
    [subVC setHidesBottomBarWhenPushed:YES];
    [self._umUtilCurViewController.navigationController pushViewController:subVC animated:YES];
    NSString *paramType = propertysDict[@"type"];
    if([@"string" isEqualToString:paramType]){
        paramObj = propertysDict[@"value"];
    }else if([@"number" isEqualToString:paramType]){
        paramObj = propertysDict[@"value"];
    }else if([@"dict" isEqualToString:paramType]){
        paramObj = propertysDict[@"value"];
    }else if([@"array" isEqualToString:paramType]){
        paramObj = propertysDict[@"value"];
    }else if([@"model" isEqualToString:paramType]){
        NSDictionary *modelParamDict = (NSDictionary*)propertysDict[@"value"];
        NSString *modelName = propertysDict[@"modelname"];
        Class modelClass = NSClassFromString(modelName);
        paramObj = [[modelClass alloc] init];
        [modelParamDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([paramObj respondsToSelector:NSSelectorFromString(key)]) {
                [paramObj setValue:obj forKey:key];
            }
        }];
    }
    
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:",method]);
    [subVC performSelector:selector withObject:paramObj afterDelay:0.5];
    self._userInfo = nil;
}

- (void)notification_process_setCurVC:(NSNotification *)notification{
    UIViewController *curVC = notification.object;
    self._umUtilCurViewController = curVC;
}

- (void)notification_process_RemotePush:(NSNotification *)notification{
    [self jumpcenterWhenOpenApp];
}

- (void) registeViewController:(UIViewController*)vc{
    self._umUtilCurViewController = vc;
}
- (void) removeViewController{
    self._umUtilCurViewController = nil;
}

-(void) notification_remote_push{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"REMOTE_PUSH" object:nil];
}

+(id) SharedUMPushUtil{
    if(PUSHUTIL_INSTANCE == nil){
        PUSHUTIL_INSTANCE = [[UMessagePushUtil alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:PUSHUTIL_INSTANCE selector:@selector(notification_process_setCurVC:) name:@"SET_CUR_VC" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:PUSHUTIL_INSTANCE selector:@selector(notification_process_RemotePush:) name:@"REMOTE_PUSH" object:nil];
    }
    return PUSHUTIL_INSTANCE;
}

@end








