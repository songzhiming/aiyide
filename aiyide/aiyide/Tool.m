//
//  ChangeRootVC.m
//  aiyide
//
//  Created by WangZHW on 15/4/20.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "Tool.h"
#import "AppDelegate.h"
@implementation Tool
+ (void)changeRootControllerFromVC:(UIViewController *)FromVC toVC:(UIViewController *)toVC{
    AppDelegate *delegate = [Tool getAppDelegate];
    delegate.window.rootViewController = toVC;
}

+ (AppDelegate *)getAppDelegate{
   return  (AppDelegate *)[UIApplication sharedApplication].delegate;
}
@end
