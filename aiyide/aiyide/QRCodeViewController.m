//
//  QRCodeViewController.m
//  yjtos
//
//  Created by yuanph on 15-1-29.
//  Copyright (c) 2015年 RobuSoft. All rights reserved.
//

#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property(nonatomic,strong)AVCaptureDevice *device;
@property(nonatomic,strong)AVCaptureDeviceInput *input;
@property(nonatomic,strong)AVCaptureMetadataOutput *output;
@property(nonatomic,strong)AVCaptureSession *session;
@property (weak, nonatomic) IBOutlet UIImageView *SCannerRangeImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *OverlayView;
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *preview;
@property(nonatomic,strong)NSTimer *timer;
@property (weak, nonatomic) IBOutlet UITextField *resultTextField;
@property (weak, nonatomic) IBOutlet UIButton *inputButton;
@end

@implementation QRCodeViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

//点击手动输入按钮
- (IBAction)clickInputButton:(UIButton *)sender {
    if (_resultTextField.text.length > 0) {
        if (self.complete) {

            self.complete(_resultTextField.text);
        }
        [[NSUserDefaults standardUserDefaults]setValue:_resultTextField.text forKey:@"scanCodeString"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"扫码考勤";
    
    [self initYJTQRCodeView];
    [self addScannerRangeView];
    [self createAnimationTimer];
    [self configUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)addScannerRangeView
{
    _infoLabel.backgroundColor=[UIColor clearColor];
    _infoLabel.textColor=[UIColor whiteColor];
    _infoLabel.layer.cornerRadius=5;
    _infoLabel.layer.masksToBounds=YES;
}
-(void)createAnimationTimer
{
    _timer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(animationImage ) userInfo:nil repeats:YES];
}

-(void)animationImage
{
    if (_imageHeightConstraint.constant==280) {
        _imageHeightConstraint.constant=10;
           
    }
    else
    {
        _imageHeightConstraint.constant+=1;
    }
}

-(void)initYJTQRCodeView
{
    _device=[AVCaptureDevice  defaultDeviceWithMediaType:AVMediaTypeVideo];
    _input =[AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    _output=[[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    _session=[AVCaptureSession new];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input]) {
        [_session addInput:_input];
    }
    if ([_session canAddOutput:_output]) {
        [_session addOutput:_output];
    }
    CGRect rect=_SCannerRangeImageView.frame;
    [_output setRectOfInterest:[self getScanCrop:rect readerViewBounds:[[UIScreen mainScreen]applicationFrame]]];

    if ([_output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]||[_output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]) {
        _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code];
    }
    _preview=[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity=AVLayerVideoGravityResizeAspectFill;
    _preview.frame=[[UIScreen mainScreen]applicationFrame];

    [self.view.layer insertSublayer:_preview atIndex:0];
    [_session startRunning];
}




#pragma mark - 设置可扫描区的scanCrop的方法
- (CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)rvBounds{
    CGFloat x,y,width,height;
    x=rect.origin.y/rvBounds.size.height;
    y=(rect.origin.x)/rvBounds.size.height;
    width=rect.size.height/rvBounds.size.height;
    height=rect.size.width/rvBounds.size.width;
    CGRect newrect=CGRectMake(x,y, width, height);
    return newrect;
}
#pragma mark  代理方法
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringvalue;
    if (metadataObjects.count>0) {
        AVMetadataMachineReadableCodeObject *metadataObject=[metadataObjects objectAtIndex:0];
        stringvalue=metadataObject.stringValue;
        [_timer invalidate];
        if (self.complete) {
            self.complete(stringvalue);
            
            [[NSUserDefaults standardUserDefaults]setValue:stringvalue forKey:@"scanCodeString"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            self.complete = nil;
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}
- (IBAction)onclickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark 添加模糊效果
-(void)configUI
{
    
    for (UIView *subview in _OverlayView) {
        subview.alpha=0.9;
        subview.backgroundColor=[UIColor blackColor];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
