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
    NSLog(@"12334==%@",self.passwordTextField.text);
    NSLog(@"12334==%@",self.surePasswordTextField.text);
    NSString *passWord = self.passwordTextField.text;
    NSString *surePassWord = self.surePasswordTextField.text;
    
    
    
    if([passWord isEqualToString:surePassWord]){
        [self showMessage:@"密码输入不一致"];
    }else{
        NSMutableArray *arr=[NSMutableArray array];
        [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.phoneNoTextField.text,@"PhoneNo", nil]];
        [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.passwordTextField.text,@"Passwords", nil]];
        NSString *soapMsg=[SoapHelper arrayToDefaultSoapMessage:arr methodName:@"insertRegisterIos"];
        //执行同步并取得结果
        ServiceHelper *helper = [[ServiceHelper alloc] initWithDelegate:self];
        NSString *xml=[helper syncServiceMethod:@"insertRegisterIos" soapMessage:soapMsg];
        
        //将xml使用SoapXmlParseHelper类转换成想要的结果
        if([xml isEqualToString:@"1"]){
            
        }else if([xml isEqualToString:@"-1"]){
        
        }else if ([xml isEqualToString:@""]){
        
        }
        
        
        NSLog(@"同步请求返回的xml:\n%@\n",xml);
        NSLog(@"=======同步请求结束======\n");
    }
    
    

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)showMessage:(NSString *)msg
{
    UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


@end
