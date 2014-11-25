//
//  DbToNetManager.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-29.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "DbToNetManager.h"

@implementation DbToNetManager
//+ (DbToNetManager *)sharedManager
//{
//    static DbToNetManager *sharedAccountManagerInstance = nil;
//    static dispatch_once_t predicate;
//    dispatch_once(&predicate, ^{
//        sharedAccountManagerInstance = [[self alloc] init];
//    });
//    return sharedAccountManagerInstance;
//}
-(id)init
{
    if (self=[super init]) {
        m_nMaxIndex=0;
        max=0;
        dataArray=[[NSMutableArray alloc]init];
    }
    return self;
}
-(void)HandSuccess:(void (^)(NSMutableArray *))handSuccess
{
    HandSuccess=[handSuccess copy];
}
-(void)HandFail:(void (^)(NSString *))handFail
{
    HandFail=[handFail copy];
}
-(void)getImageArr:(NSMutableArray *)imageArr andTitleArr:(NSMutableArray *)tilteArr andNum:(NSString *)num
{
    m_nMaxIndex=tilteArr.count;
   
    BOOL isHave=NO;
    NSMutableArray *arr=[NSMutableArray arrayWithArray:tilteArr];
    for (int i=0; i<tilteArr.count; i++) {
        if ([[tilteArr objectAtIndex:i] length]!=52) {
            [self postDataTo:[imageArr objectAtIndex:i] andTag:i and:arr andNum:num];
            isHave=YES;
        }
        
        
    }
    if (isHave==NO) {
        
        if (HandSuccess) {
            HandSuccess(tilteArr);
        }
        
    }
    
}
-(void)postDataTo:(UIImage *)image andTag:(int)tag and:(NSMutableArray *)titleArr andNum:(NSString *)num;
{
    
  
   
    __block NSMutableArray *array=[NSMutableArray arrayWithArray:titleArr];
    NSData *  imageData=UIImageJPEGRepresentation([image fixOrientation], 0.4);
    DataService *dataService=[[DataService alloc]init];
    NSString *urlStr=[NSString stringWithFormat:@"order/upload_file?accesstoken=%@&order_no=%@",[NSString getToken],num];
    [dataService upImageFileData:urlStr imageData:imageData andDic:nil];
    [dataService  setDidFinish:^(DataService *serivice, NSDictionary *dic) {
        if ([(NSNumber *)[dic objectForKey:kcodeKey] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            //成功
            
            
        [dataArray addObject:[dic objectForKey:kdataKey]];
            max++;
            
            if (max==m_nMaxIndex) {
                if (HandSuccess) {
                    HandSuccess(dataArray);
                }
            }
        }
        
    }];
    [dataService setDidFailed:^(DataService *serivice, NSError *error) {
        if (HandFail) {
            HandFail(kfailImageKey);
        }
        
        
    }];
    
}

@end
