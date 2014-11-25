//
//  UIDevice+Extension.m
//  MicroBusinessCard
//
//  Created by Yuyangdexue on 14-10-9.
//  Copyright (c) 2014年 yuyang. All rights reserved.
//

#import "UIDevice+Extension.h"

@implementation UIDevice (Extension)

- (NSUInteger)isDeviceSystemMajorVersion
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    
    return _deviceSystemMajorVersion;
}

@end
