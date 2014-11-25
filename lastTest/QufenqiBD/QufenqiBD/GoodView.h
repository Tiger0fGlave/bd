//
//  GoodView.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-16.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodCell.h"
#import "FenQiFootView.h"
/* 商品界面*/
@interface GoodView : UIView<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,FenQiFootViewDelegate>
-(void)initMax_FenQI:(NSDictionary *)order_infoDic andGoodInfo:(NSArray *)goodArr;
-(void)getDateFromServer;
@property(nonatomic,retain)MBProgressHUD *hud;
@property(nonatomic,retain)UITableView *mTableView;
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)NSDictionary *order_Info;
@property(nonatomic,retain)  UIButton *cancelBtn;
@property(nonatomic,retain)  UIButton *okBtn;
@property (nonatomic,copy)NSString *order_no;
@property (nonatomic,copy)NSString *order_id;
@end
