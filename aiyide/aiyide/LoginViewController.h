//
//  LoginViewController.h
//  aiyide
//
//  Created by 宋志明 on 15-4-20.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHelper.h"

@interface LoginViewController : UIViewController<ServiceHelperDelegate>
{
    ServiceHelper *helper ;
}

@end
