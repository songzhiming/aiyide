//
//  RegisterViewController.m
//  aiyide
//
//  Created by 宋志明 on 15-4-20.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "RegisterViewController.h"
#import "SoapHelper.h"
#import "ASIHTTPRequest.h"
#import "SoapXmlParseHelper.h"
#import "SoapHelper.h"
#import "AppHelper.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *surePasswordTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//注册
- (IBAction)onclickRegister:(id)sender {
    NSLog(@"=======同步请求开始======\n");

    [self.view endEditing:YES];
    if([self.phoneNoTextField.text hasPrefix:@"1"] && self.phoneNoTextField.text.length == 11){
        if (self.passwordTextField.text.length == 0 || self.surePasswordTextField.text.length == 0) {
            [self showMessage:@"请输入密码"];
        }else{
            if(![self.passwordTextField.text isEqualToString:self.surePasswordTextField.text]){
                [self showMessage:@"密码输入不一致"];
            }else{
                NSMutableArray *arr=[NSMutableArray array];
                [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.phoneNoTextField.text,@"PhoneNo", nil]];
                [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.passwordTextField.text,@"Passwords", nil]];
                NSString *soapMsg=[SoapHelper arrayToDefaultSoapMessage:arr methodName:@"insertRegisterIos"];
                //执行同步并取得结果
                ServiceHelper *helper = [[ServiceHelper alloc] initWithDelegate:self];
                [AppHelper showHUD:@"loading"];
                [helper asynServiceMethod:@"insertRegisterIos" soapMessage:soapMsg];
                //将xml使用SoapXmlParseHelper类转换成想要的结果
       
                
            }
        }
        
    }else{
        NSLog(@"===111===%lu",(unsigned long)self.phoneNoTextField.text.length);
        [self showMessage:@"您输入不是手机号码"];
    }
    

    
    

}


#pragma mark -
#pragma mark 异步请求结果
-(void)finishSuccessRequest:(NSString*)xml{
    
    //将xml使用SoapXmlParseHelper类转换成想要的结果
    
    NSLog(@"异步请求返回的xml:\n%@\n",xml);
    NSLog(@"=======异步请求结束======\n");
    if([xml isEqualToString:@"1"]){//注册失败
        [self showMessage:@"注册失败"];
    }else if ([xml hasSuffix:@"已注册"]){
        [self showMessage:@"该手机号码已注册"];
    }else{
        [self showAlert:@"注册成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [AppHelper removeHUD];//移除动画
}
-(void)finishFailRequest:(NSError*)error{
    NSLog(@"异步请发生失败:%@\n",[error description]);
    [AppHelper removeHUD];//移除动画
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//  返回按钮
- (IBAction)onclickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showMessage:(NSString *)msg
{
    UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}



//
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
