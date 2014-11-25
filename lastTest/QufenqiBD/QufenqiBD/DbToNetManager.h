//
//  DbToNetManager.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-29.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//
/* 多线程异步图片提交*/
#import <Foundation/Foundation.h>

@interface DbToNetManager : NSObject
{
    void (^HandSuccess)(NSMutableArray *titleArr);
    void (^HandFail)(NSString *errStr);
    NSInteger m_nMaxIndex;
     __block NSInteger max;
    NSMutableArray *dataArray;
}
//+ (DbToNetManager *)sharedManager;
@property (nonatomic,copy)NSString *order_no;
-(void)HandSuccess:(void(^)(NSMutableArray *titleArr))handSuccess;
-(void)HandFail:(void(^)(NSString *errStr))handFail;
-(void)getImageArr:(NSMutableArray *)imageArr andTitleArr:(NSMutableArray *)tilteArr andNum:(NSString *)num;
@end
