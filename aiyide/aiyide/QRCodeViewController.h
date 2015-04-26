//
//  QRCodeViewController.h
//  yjtos
//
//  Created by WangZHW on 15-1-29.
//  Copyright (c) 2015年 RobuSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^complete) (NSString *result);


@interface QRCodeViewController : UIViewController
/**回调black*/
@property (copy , nonatomic) complete complete;
@end
