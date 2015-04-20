//
//  HomeViewController.m
//  aiyide
//
//  Created by 宋志明 on 15-4-20.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "ScanCodeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//到登陆页面
- (IBAction)loginAction:(id)sender {
    LoginViewController *loginViewController  = [[LoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    nav.navigationBarHidden     = YES;
    [self presentViewController:nav animated:YES completion:nil];
//    [self.navigationController pushViewController:loginViewController animated:YES];
    
}
//到扫码页面
- (IBAction)scanCodeAction:(id)sender {
    ScanCodeViewController *scanCodeViewController  = [[ScanCodeViewController alloc]init];
    [self.navigationController pushViewController:scanCodeViewController animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
