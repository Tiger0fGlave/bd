//
//  FenQiFootView.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-17.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
/* 商品信息*/
@class FenQiFootViewDelegate;
@protocol FenQiFootViewDelegate <NSObject>

-(void)changeClickButton;

@end
@interface FenQiFootView : UITableViewHeaderFooterView

@property (nonatomic,weak)id<FenQiFootViewDelegate>delegate;
@property (nonatomic,retain)UILabel *amontLablePrice;
@property (nonatomic,retain)UILabel *bigLable;
@property (nonatomic,retain)UILabel *firstPrice;
@property (nonatomic,retain)UILabel *paseLablPrice;
@property (nonatomic,retain)UILabel *fenqiMonth;
@property (nonatomic,retain)UILabel *monthfee;
@property (nonatomic,retain)UILabel *orederLable;
@property (nonatomic,copy) NSString *order_id;

+ (FenQiFootView *)fenqiFootViewWithTableView:(UITableView *)tableView;
-(void)update:(NSDictionary *)info;
@end
