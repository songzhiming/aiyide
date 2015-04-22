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
@property (weak, nonatomic) IBOutlet UILabel *barCodeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self picViewWidth];
    [self showQR];
}


// 显示二维码
- (void)showQR{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString       *phone    = [defaults valueForKey:@"phoneNo"];
    if (phone) {
        NSString       *QRString = [defaults valueForKey:phone];
        if (QRString) {
            self.QRBgView.hidden= NO;
            
            NSDate *now = [NSDate date];
            NSLog(@"now date is: %@", now);
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
            NSInteger year = [dateComponent year];
            NSInteger month = [dateComponent month];
            NSInteger day = [dateComponent day];
            NSInteger hour = [dateComponent hour];
            NSInteger minute = [dateComponent minute];
            NSInteger second = [dateComponent second];
            NSLog(@"year=%ldmonth=%ldday=%ldhour=%ldminute=%ldsecond=%ld",year,month,day,hour,minute,second);
            //扫描QR码数据+“@”+日小时分钟+手机号后10位。
            NSString *replaceString = [NSString stringWithFormat:@"%@%@%ld%ld%ld%@",QRString,@"@",day,hour,minute,[[[NSUserDefaults standardUserDefaults]objectForKey:@"phoneNo"] substringWithRange:NSMakeRange(1, 10)]];
            
            self.QRpicView.image = [QRCodeGenerator qrImageForString:replaceString imageSize:self.picViewW.constant];
            self.barCodeLabel.text = [NSString stringWithFormat:@"%@%@",@"条码:",QRString];
        }else{
            self.QRBgView.hidden= YES;
        }
    }else{
        self.QRBgView.hidden= YES;
    }
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.phoneTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"phoneNo"];
    UIButton *button = (UIButton *)[self.view viewWithTag:101];
    button.selected  = YES;
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
        return;
    }
    QRCodeViewController *scanCodeViewController  = [[QRCodeViewController alloc]init];
    scanCodeViewController.complete                 = ^(NSString *result){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:result forKey:[defaults valueForKey:@"phoneNo"]];
        [defaults synchronize];
        [self showQR];
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


//点击手机条形码
- (IBAction)onclickBarCode:(UIButton *)sender {
    if (self.phoneTextField.text.length == 0) {
        [self showMessage:@"请先登录"];
        return;
    }
    self.QRBgView.hidden = NO;
    self.barCodeLabel.text = @"条码:";
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:101];
    btn1.selected = btn.selected;
    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:self.phoneTextField.text
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
    sender.selected = YES;
    sender = (UIButton *)[self.view viewWithTag:101];
    sender.selected = NO;
    
}
//点击扫码条码
- (IBAction)onclickScanCode:(UIButton *)sender {
    [self showQR];
    sender.selected = YES;
    UIButton *disButton = (UIButton *)[self.view viewWithTag:100];
    disButton.selected = NO;
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
