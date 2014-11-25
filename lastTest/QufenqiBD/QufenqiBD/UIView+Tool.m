//
//  UIView+Tool.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-17.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "UIView+Tool.h"

@implementation UIView (Tool)
+ (void)showHUD:(NSString *)text andView:(UIView *)view andHUD:(MBProgressHUD *)hud
{
    [view addSubview:hud];
    hud.labelText = text;//显示提示
    hud.dimBackground = YES;//使背景成黑灰色，让MBProgressHUD成高亮显示
    hud.square = YES;//设置显示框的高度和宽度一样
    [hud show:YES];
}
@end
