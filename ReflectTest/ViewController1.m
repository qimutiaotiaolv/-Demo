//
//  ViewController.m
//  ReflectTest
//
//  Created by yangyanxiang on 16/8/30.
//  Copyright © 2016年 yangyanxiang. All rights reserved.
//

#import "ViewController1.h"
#import "UMessagePushUtil.h"

@interface CustomerView ()
@end


@implementation CustomerView
@synthesize _fieldString;
-(void) printSelf{
    NSLog(@"这是CustomerView,内置参数_fieldString:%@",_fieldString);
}
-(void) printSelfWithParam:(NSString*) param{
    NSLog(@"这是CustomerView,内置参数_fieldString:%@,外传参数:%@",_fieldString,param);
}
@end

@interface ViewController1 ()

@end

@implementation ViewController1

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     [[UMessagePushUtil SharedUMPushUtil] jumpcenterWhenOpenApp];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}




-(void) reflect_test{
    //1.获取实例的Class
    Class objclass = [UIView class];
    CustomerView *objView = [[CustomerView alloc] init];
    Class class1 = [objView class];
    Class class2 = [CustomerView class];
    Class class3 = NSClassFromString(@"CustomerView");
    NSLog(@"class1: %@, class2: %@, class3: %@",class1,class2,class3);
    NSLog(@"class1 == class2? :%d",class1 == class2);
    NSLog(@"class1 == objclass? :%d",class1 == objclass);
    CustomerView *objView2 = [[class1 alloc] init];
    [objView2 printSelf];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[UMessagePushUtil SharedUMPushUtil] jumpcenterWhenOpenApp];
    // Do any additional setup after loading the view, typically from a nib.
    [self reflect_test];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
