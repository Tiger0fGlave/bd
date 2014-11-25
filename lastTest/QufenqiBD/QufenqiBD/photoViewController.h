//
//  photoViewController.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-22.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface photoViewController : UIViewController<UIGestureRecognizerDelegate>
{
    CGFloat lastScale;
}
@property (nonatomic,retain)UIImage *photoImage;
@end
