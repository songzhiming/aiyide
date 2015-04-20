//
//  LoginViewController.m
//  aiyide
//
//  Created by 宋志明 on 15-4-20.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "HomeViewController.h"
#import "Tool.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 设置uitextfield
    self.phoneField.leftView        = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.passwordField.leftView     = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.phoneField.leftViewMode    = UITextFieldViewModeAlways;
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    self.phoneField.delegate        = self;
    self.passwordField.delegate     = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.phoneField == textField) {
        [self.passwordField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

- (IBAction)ClickLoginButton:(UIButton *)sender {
    if (self.phoneField.text.length > 0 && self.passwordField.text.length > 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        NSLog(@"手机号或者密码不能为空");
    }
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
- (IBAction)clickBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickLogin:(UIButton *)sender {
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



@end
