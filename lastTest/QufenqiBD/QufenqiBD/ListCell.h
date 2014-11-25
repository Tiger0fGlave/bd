//
//  ListCell.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-14.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
/* 商品信息*/
@interface ListCell : UITableViewCell<MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *mobile;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *goodname;
@property (weak, nonatomic) IBOutlet UILabel *goodprice;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *order_numLable;
@property (weak, nonatomic) IBOutlet UILabel *order_id;
@property (weak, nonatomic) IBOutlet UIButton *pushMes;
@property (weak, nonatomic) IBOutlet UIButton *pushMob;
@property (nonatomic,weak)UIViewController *viewController;
@property (weak, nonatomic) IBOutlet UILabel *warningLable;

@property (nonatomic,retain)ListModel *entity;
-(void)update;
@end
