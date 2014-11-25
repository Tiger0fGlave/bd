//
//  UITextField+ChangeBorder.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-29.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "UITextField+ChangeBorder.h"

@implementation UITextField (ChangeBorder)

-(void)changeBorderColor
{
    self.layer.borderColor=[UIColor grayColor].CGColor;
    self.layer.borderWidth= 1.0f;
    
}
@end
