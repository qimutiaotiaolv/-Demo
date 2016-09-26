//
//  CustomerVC.m
//  ReflectTest
//
//  Created by yangyanxiang on 16/9/8.
//  Copyright © 2016年 yangyanxiang. All rights reserved.
//

#import "CustomerVC.h"

@implementation UserModel
@synthesize _age;
@synthesize _name;
@synthesize _tocken;
@end

@implementation CustomerVC
-(void) updateWithModel:(UserModel*)model{
    self._ageLabel.text = [NSString stringWithFormat:@"%d",model._age];
    self._nameLabel.text = model._name;
    self._tockenLabel.text = model._tocken;
}
@end
