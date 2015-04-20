//
//  AppDelegate.m
//  aiyide
//
//  Created by 宋志明 on 15-4-20.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    HomeViewController *homeViewController  = [[HomeViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homeViewController];
    nav.navigationBar.hidden = YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}



- (void)testRegister{
//    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=/"1.0/" encoding=/"utf-8/"?>/n"
//                              "<soap:Envelope xmlns:xsi=/"http://www.w3.org/2001/XMLSchema-instance/" xmlns:xsd=/"http://www.w3.org/2001/XMLSchema/" xmlns:soap=/"http://schemas.xmlsoap.org/soap/envelope//">/n"
//                              "<soap:Body>/n"
//                              "<Test xmlns=/"http://jinlong.ctc.com/">/n"
//                              "<userID>%@</userID>/n"
//                              "</Test>/n"
//                              "</soap:Body>/n"
//                              "</soap:Envelope>/n",@"JINLONG"
//                              ];
//    NSString * msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
//    //设置请求地址
//    NSURL * url = [NSURL URLWithString:@"http://www.ieget.cn/WebService.asmx?op=insertRegisterIos"];
//    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
//    //加请求头文件
//    [urlRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [urlRequest addValue: @"http://service.xiva.com/login" forHTTPHeaderField:@"SOAPAction"];
//    [urlRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//    //设置请求方式
//    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    NSURLResponse *reponse;
//    NSError * error = nil;
//    //接受返回数据
//    NSData  * responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&reponse error:&error];
//    NSMutableString * 
//    result = [[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"Return String is========>%@",result);  

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
