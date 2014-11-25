//
//  PickImageView.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-1/Users/yuyang/Desktop/QufenqiBD/User.h0-14.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
/* 图片选择*/
@class PickImageView;
@protocol PickImageViewDelegate <NSObject>

@optional
- (void)addObjectView:(PickImageView *)pickView passImageArray:(NSMutableArray *)imageArray andPassImageArr:(NSMutableArray *) arr;

@end

@interface PickImageView : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    UIButton *button;
    CGRect  rect;
    NSMutableArray *imageArray;
    NSMutableArray *imageViewArray;
    NSMutableArray *imageViewBgArray;
    NSMutableArray *LoadArray;
    DataService *dataDeleteService;
    DataService *dataAddService;
    NSData *imageData;
    UIImage *photoImage;
    BOOL isNet;
}
@property (nonatomic, assign) id<PickImageViewDelegate> delegate;
@property(nonatomic,weak)UIViewController * viewController;
@property (nonatomic,retain)NSMutableArray *imageArray;
@property (nonatomic,retain)NSMutableArray *imageViewArray;
@property (nonatomic,retain)NSMutableArray *imageViewBgArray;
@property (nonatomic,retain)NSMutableArray *LoadArray;
@property (nonatomic,retain)MBProgressHUD *hud;;
@property (nonatomic,copy)NSString *order_num;
@property (nonatomic,assign)NSInteger deleteNum;;
-(void)initView;
-(void)initNetView:(NSMutableArray *)arr;
-(void)initDbView:(NSMutableArray *)arr andTitle:(NSMutableArray *)titleArr;
@end
