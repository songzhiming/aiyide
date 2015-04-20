//
//  LoginViewController.m
//  aiyide
//
//  Created by 宋志明 on 15-4-20.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//到注册页面
- (IBAction)registerAction:(id)sender {
    RegisterViewController *registerVc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVc animated:YES];
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
