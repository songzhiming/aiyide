//
//  AppDelegate.m
//  aiyide
//
//  Created by 宋志明 on 15-4-20.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "SoapHelper.h"
#import "ASIHTTPRequest.h"
#import "SoapXmlParseHelper.h"
#import "SoapHelper.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIViewController *vc = [[HomeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    nav.navigationBar.hidden = YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    [self testRegister];
    return YES;
}


- (void)testRegister{
    NSLog(@"=======同步请求开始======\n");
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"13285119044",@"PhoneNo", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"123",@"Passwords", nil]];
    NSString *soapMsg=[SoapHelper arrayToDefaultSoapMessage:arr methodName:@"insertRegisterIos"];
    //执行同步并取得结果
    ServiceHelper *helper = [[ServiceHelper alloc] initWithDelegate:self];
    NSString *xml=[helper syncServiceMethod:@"insertRegisterIos" soapMessage:soapMsg];
    
    //将xml使用SoapXmlParseHelper类转换成想要的结果
    
    NSLog(@"同步请求返回的xml:\n%@\n",xml);
    NSLog(@"=======同步请求结束======\n");
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
