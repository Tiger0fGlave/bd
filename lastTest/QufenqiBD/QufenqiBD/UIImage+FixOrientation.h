//
//  UIImage+FixOrientation.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-29.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FixOrientation)
/* 保证照片到后台是正确的方向*/
- (UIImage *)fixOrientation;
+(UIImage *)scale:(UIImage *)image toSize:(CGSize)size;
@end
