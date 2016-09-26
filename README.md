1.安装 UMengMessage SDK
Podfile:
	platform :ios, '7.0'
	source 'https://github.com/CocoaPods/Specs.git'
	inhibit_all_warnings!
	target 'ReflectTest' do
    pod 'iOS-UMengMessage', '~> 1.2.5'
	end

2.在appdelegate.m中引入UMessagePushUtil.h: #import "UMessagePushUtil.h"

3.在- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions中添加 [[UMessagePushUtil SharedUMPushUtil] initWithUmengAppKey:umengAppId storyboardName:@"Main" launchOptions:launchOptions];umengAppId为友盟的AppKey。

4.如需设置别名，则在- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken中添加[[UMessagePushUtil SharedUMPushUtil] didRegisterForRemoteNotifications:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken aliasName:aliasName aliasType:aliasType];aliasType为别名类型，aliasName为别名。

5.在所有需要跳转的ViewController引入UIViewController+PushInfo.h: #import "UIViewController+PushInfo.h"。如重写-(void)viewWillAppear:(BOOL)animated;-(void)viewDidAppear:(BOOL)animated;-(void)viewDidDisappear:(BOOL)animated;，需调用[super methodXXX]。


友盟传参示例：{"class":"CustomerVC","instancefrom":"storyboard","method":"updateWithModel","modelname":"UserModel","propertys":{"type":"model","modelname":"UserModel","value":{"_name":"用户01","_tocken":"010","_age":25}}}，key为data
