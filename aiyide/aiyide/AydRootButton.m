//
//  AydRootButton.m
//  aiyide
//
//  Created by WangZHW on 15/4/20.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "AydRootButton.h"

@implementation AydRootButton

- (void)awakeFromNib{
    self.layer.cornerRadius = 10;
    self.layer.borderWidth  = 1;
    self.layer.borderColor  = [UIColor whiteColor].CGColor;
    
    self.backgroundColor    = [UIColor blackColor];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
