//
//  DBManager.m
//  Test
//
//  Created by Yuyangdexue on 14-10-31.
//  Copyright (c) 2014年 yuyang. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager
{
   __block BOOL isSave;
    DBModel *dbModel;
    NSString *isS;
      BOOL isFrist;
    NSTimer *timer;
}
@synthesize order_no;

-(id)init
{
    if (self=[super init]) {
        isFrist=YES;
        isSave=YES;
        dbModel=nil;
    }
    return self;
}
+ (DBManager *)instance
{
    static DBManager *sharedDBManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedDBManagerInstance = [[self alloc] init];
    });
    return sharedDBManagerInstance;
}
-(void )readDB
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self getFilePath]]) {
            NSData *data = [[NSData alloc] initWithContentsOfFile:[self getFilePath]];
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            //解档出数据模型Student
            DBModel *entity=[unarchiver decodeObjectForKey:[NSString stringWithFormat:@"%@Key",self.order_no]];
            [unarchiver finishDecoding];//一定不要忘记finishDecoding，否则会报错
            if ([entity.order_no isEqualToString:self.order_no]) {
                dbModel=nil;
                dbModel=entity;
                isS=nil;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (isFrist) {
                    if (ReadDB) {
                        ReadDB(dbModel);
                    }
                    
                    isFrist=NO;
                }
                else{
                  timer =[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(iSBollChange) userInfo:nil repeats:YES];
                    [timer fire];
                    
                }
                
                
                
            });
            
        }
        else
        {
            if (ReadDB) {
                dbModel=nil;
                ReadDB(dbModel);
            }

        }
        
    });
}
-(void)iSBollChange
{
    if (ReadDB&&isSave) {
        ReadDB(dbModel);
        [timer invalidate];
        timer=nil;
    }
}
-(void)setReadDB:(void(^)(DBModel *entity))readDB
{
    [self readDB];
    ReadDB=[readDB copy];
}
-(void)setSavedDB:(void(^)(DBModel *entity))readDB;
{
        SavedDB=[readDB copy];
}
-(void)clearDb
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getFilePath]]) {
        NSLog(@"filePAth:%@",[self getFilePath]);
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        BOOL bRet = [fileMgr fileExistsAtPath:[self getFilePath]];
        if (bRet) {
            NSError *err;
            [fileMgr removeItemAtPath:[self getFilePath] error:&err];
        }
    }
}
-(void)saveDB:(DBModel *)entity;
{
    isSave=NO;
    [self clearDb];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:entity forKey:[NSString stringWithFormat:@"%@Key",self.order_no]];
        [archiver finishEncoding];
        if ([data writeToFile:[self getFilePath] atomically:YES]) {
           isSave=YES;
            dbModel=nil;
            dbModel=entity;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (SavedDB) {
                    SavedDB(dbModel);
                }
                
            });
           
        
        };
        
       
    });
}
-(NSString *) getFilePath{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"kFile%@",self.order_no]];
}
@end
