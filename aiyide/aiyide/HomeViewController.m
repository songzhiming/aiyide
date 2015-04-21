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
@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *QRpicView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picViewW;
@property (weak, nonatomic) IBOutlet UIView *QRBgView;

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
