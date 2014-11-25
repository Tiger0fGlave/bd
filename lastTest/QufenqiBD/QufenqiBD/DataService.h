//
//  DataService.h
//  CocoPodsExample
//
//  Created by Yuyangdexue on 14-10-11.
//  Copyright (c) 2014年 yuyang. All rights reserved.
//

#import <Foundation/Foundation.h>
/* 网络数据*/
@interface DataService : NSObject
{
    void (^RequseFinish)(DataService *serivice,NSDictionary *dic);
    void (^RequseError)(DataService *serivice,NSError *error);
}
-(void)setDidFinish:(void(^)(DataService *serivice,NSDictionary *dic))finsihRequset;



-(void)setDidFailed:(void(^)(DataService *serivice,NSError *error))failRequset;
- (void)requestGetWithUrl:(NSString *)urlStr;
- (void)postRequest:(NSString *)urlStr  path:(NSString *)path  parameter:(NSDictionary *)paraDic;
- (void)upImageFileData:(NSString *)urlStr imageData:(NSData *)imagedata andDic:(NSDictionary *)dic;

@end
