//
//  CustomerVC.h
//  ReflectTest
//
//  Created by yangyanxiang on 16/9/8.
//  Copyright © 2016年 yangyanxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+PushInfo.h"
//#import "UMessagePushUtil.h"
@interface UserModel : NSObject
@property(nonatomic,retain) NSString *_name;
@property(nonatomic,retain) NSString *_tocken;
@property(nonatomic) NSInteger _age;
@end


@interface CustomerVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *_tockenLabel;
@property (weak, nonatomic) IBOutlet UILabel *_ageLabel;
-(void) updateWithModel:(UserModel*)model;
@end
