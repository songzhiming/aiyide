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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *space;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    helper = [[ServiceHelper alloc] initWithDelegate:self];
    // Do any additional setup after loading the view from its nib.
    // 设置uitextfield
    self.phoneField.leftView        = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.passwordField.leftView     = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.phoneField.leftViewMode    = UITextFieldViewModeAlways;
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    self.phoneField.delegate        = self;
    self.passwordField.delegate     = self;
    
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    if (h == 480) {
        self.space.constant = -10;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.phoneField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"phoneNo"];
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
        if ([self.phoneField.text hasPrefix:@"1"] && self.phoneField.text.length == 11) {
            NSMutableArray *arr=[NSMutableArray array];
            [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.phoneField.text,@"PhoneNo", nil]];
            [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.passwordField.text,@"Passwords", nil]];
            NSString *soapMsg=[SoapHelper arrayToDefaultSoapMessage:arr methodName:@"SelectLoginIos"];
            //执行同步并取得结果
            [AppHelper showHUD:@"loading"];
            [helper asynServiceMethod:@"SelectLoginIos" soapMessage:soapMsg];
            //将xml使用SoapXmlParseHelper类转换成想要的结果
        }else{
            [self showMessage:@"请输入正确的手机号码"];
        }

        
        
        
       
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
    if([xml isEqualToString:@"-1"]){//登陆失败
        [self showMessage:@"登陆失败"];
    }else{
        [self showAlert:@"登陆成功"];
        [[NSUserDefaults standardUserDefaults]setValue:self.phoneField.text forKey:@"phoneNo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)showMessage:(NSString *)msg
{
    UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)finishFailRequest:(NSError*)error{
    NSLog(@"异步请发生失败:%@\n",[error description]);
    [self showAlert:@"请求发生失败"];
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

- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}


- (void)showAlert:(NSString *) _message{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
}

@end
