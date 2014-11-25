//
//  GoodCell.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-16.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
/* 商品订单*/
@interface GoodCell : UITableViewCell<UITextViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *goodPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UITextView *goodDespritionText;
@property (nonatomic,copy)NSString *order_no;
-(void)updateDic:(NSDictionary *)dic;

@end
