//
//  DataService.m
//  CocoPodsExample
//
//  Created by Yuyangdexue on 14-10-11.
//  Copyright (c) 2014年 yuyang. All rights reserved.
//

#import "DataService.h"

@implementation DataService
-(id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}
-(void)setDidFinish:(void (^)(DataService *, NSDictionary *))finsihRequset
{
    RequseFinish=[finsihRequset copy];
}
-(void)setDidFailed:(void (^)(DataService *, NSError *))failRequset
{
    RequseError=[failRequset copy];
}
- (void)requestGetWithUrl:(NSString *)urlStr
{
    NSString *url=[NSString stringWithFormat:@"%@%@",kServerIP,urlStr];
    NSString *urlTmp=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: urlTmp]];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html", nil]];
    
    AFJSONRequestOperation *operation= [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary* JSON) {
        if (RequseFinish) {
            __block DataService *blockSelf = self;
            RequseFinish(blockSelf,JSON);
        }
        [operation cancel];
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id data) {
        NSLog(@"发生错误！%@",error);
        if (RequseError) {
            __block DataService *blockSelf = self;
            RequseError(blockSelf,error);
        }
        [operation cancel];
        
    }];
    [operation start];
    
}
-(void)postRequest:(NSString *)urlStr  path:(NSString *)path  parameter:(NSDictionary *)paraDic;
{
    NSString *url=[NSString stringWithFormat:@"%@%@",kServerIP,urlStr];
    
    AFHTTPClient * client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:url]];
    
    //设置接受的数据类型为json
    [client setDefaultHeader:@"Accept"value:@"application/json"];
    //设置提交的数据编码类型为json格式
    [client setParameterEncoding:AFFormURLParameterEncoding];
    [client postPath:nil parameters:paraDic success:^(AFHTTPRequestOperation*operation,id responseObject)
     {
         
         NSString *requestTmp = [NSString stringWithString:operation.responseString];
         NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
         //系统自带JSON解析
         NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
         if (RequseFinish) {
             __block DataService *blockSelf = self;
             RequseFinish(blockSelf,resultDic);
         }
         
         [operation cancel];
         
     }
             failure:^(AFHTTPRequestOperation *operation,NSError *error)
     
     {
         if (RequseError) {
             __block DataService *blockSelf = self;
             RequseError(blockSelf,error);
         }
         [operation cancel];
     }];
    
}
- (void)upImageFileData:(NSString *)urlStr imageData:(NSData *)imagedata andDic:(NSDictionary *)dic;
{
    NSString *url=[NSString stringWithFormat:@"%@%@",kServerIP,urlStr];
    AFHTTPClient * client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:url]];
    NSMutableURLRequest *fileUpRequest = [client multipartFormRequestWithMethod:@"POST" path:nil parameters:dic constructingBodyWithBlock:^(id formData) {
        //[formData appendPartWithFileURL:[NSURL fileURLWithPath:theImagePath] name:@"file" error:nil];
        [formData appendPartWithFileData:imagedata name:@"file" fileName:@"filename.jpg" mimeType:@"image/jgp"];
    }];
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:fileUpRequest];
    [operation start];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        if (RequseFinish) {
            __block DataService *blockSelf = self;
            RequseFinish(blockSelf,resultDic);
        }
        [operation cancel];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (RequseError) {
            __block DataService *blockSelf = self;
            RequseError(blockSelf,error);
        }
        [operation cancel];
    }];
    
    
    
}


@end
