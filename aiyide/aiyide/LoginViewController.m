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
#import "SoapHelper.h"
#import "ASIHTTPRequest.h"
#import "SoapXmlParseHelper.h"
#import "SoapHelper.h"
#import "AppHelper.h"
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
    [self.view endEditing:YES];
    if (self.phoneField.text.length > 0 && self.passwordField.text.length > 0) {
        NSMutableArray *arr=[NSMutableArray array];
        [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.phoneField.text,@"PhoneNo", nil]];
        [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.passwordField.text,@"Passwords", nil]];
        NSString *soapMsg=[SoapHelper arrayToDefaultSoapMessage:arr methodName:@"SelectLoginIos"];
        //执行同步并取得结果
        ServiceHelper *helper = [[ServiceHelper alloc] initWithDelegate:self];
        [AppHelper showHUD:@"loading"];
        [helper asynServiceMethod:@"SelectLoginIos" soapMessage:soapMsg];
        //将xml使用SoapXmlParseHelper类转换成想要的结果
        
        
        
       
    }else{
        NSLog(@"手机号或者密码不能为空");
        [self showMessage:@"手机号或者密码不能为空"];
    }
}
#pragma mark -
#pragma mark 异步请求结果
-(void)finishSuccessRequest:(NSString*)xml{
    
    //将xml使用SoapXmlParseHelper类转换成想要的结果
    
    NSLog(@"异步请求返回的xml:\n%@\n",xml);
    [AppHelper removeHUD];//移除动画
    NSLog(@"=======异步请求结束======\n");
    if([xml isEqualToString:@"-1"]){//登陆成功
        [self showMessage:@"登陆成功"];
         [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self showMessage:@"注册成功"];
    }
    
}

- (void)showMessage:(NSString *)msg
{
    UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)finishFailRequest:(NSError*)error{
    NSLog(@"异步请发生失败:%@\n",[error description]);
    [AppHelper removeHUD];//移除动画
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
