//
//  HomeViewController.m
//  aiyide
//
//  Created by 宋志明 on 15-4-20.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "QRCodeViewController.h"
#import "QRCodeGenerator.h"


#import "SoapHelper.h"
#import "ZXMultiFormatWriter.h"
#import "ZXImage.h"


@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *QRpicView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picViewW;
@property (weak, nonatomic) IBOutlet UIView *QRBgView;
@property (weak, nonatomic) IBOutlet UILabel *phoneTextField;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self picViewWidth];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString       *QRString = [defaults valueForKey:@"15117956216"];
    if (QRString) {
        self.QRpicView.hidden= NO;
        self.QRpicView.image = [QRCodeGenerator qrImageForString:QRString imageSize:self.picViewW.constant];
    }else{
        self.QRpicView.hidden= YES;
    }
    
    [self test];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.phoneTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"phoneNo"];
}
- (IBAction)changeClick:(id)sender {

}
- (void)picViewWidth{
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    if (h == 480) {
        self.picViewH.constant = 175;
        self.picViewW.constant = 175;
    }
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
}
//到扫码页面
- (IBAction)scanCodeAction:(id)sender {
    if (self.phoneTextField.text.length == 0) {
        [self showMessage:@"请先登录"];
    }
    QRCodeViewController *scanCodeViewController  = [[QRCodeViewController alloc]init];
    scanCodeViewController.complete                 = ^(NSString *result){
        self.QRpicView.hidden= NO;
        self.QRpicView.image = [QRCodeGenerator qrImageForString:result imageSize:self.picViewW.constant];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:result forKey:@"15117956216"];
        [defaults synchronize];
    };
    [self.navigationController pushViewController:scanCodeViewController animated:YES];
}


- (void)showMessage:(NSString *)msg
{
    UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


- (void)test{
    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:@"6922233623211"
                                  format:kBarcodeFormatCode128
                                   width:100
                                  height:50
                                   error:&error];
    if (result) {
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage ];
        NSLog(@"%@",image);
        UIImage *imag=[UIImage imageWithCGImage:image];
        self.QRpicView.image=imag;
        
        // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
    } else {
        NSString *errorMessage = [error localizedDescription];
        
    }
    
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
