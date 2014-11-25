//
//  DBManager.h
//  Test
//
//  Created by Yuyangdexue on 14-10-31.
//  Copyright (c) 2014年 yuyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBModel.h"
/* 订单信息保存*/
@interface DBManager : NSObject
{
     void (^ReadDB)(DBModel *entity);
     void (^SavedDB)(DBModel *entity);
    
}
+ (DBManager *)instance;
@property (nonatomic,copy)NSString *order_no;
-(void)saveDB:(DBModel *)entity;
-(void)clearDb;
-(void)setReadDB:(void(^)(DBModel *entity))readDB;
-(void)setSavedDB:(void(^)(DBModel *entity))readDB;
-(void )readDB;
@end
