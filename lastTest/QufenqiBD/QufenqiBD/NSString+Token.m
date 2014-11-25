//
//  NSString+Token.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-13.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "NSString+Token.h"

@implementation NSString (Token)
+(void)saveUser:(NSString *)username andPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];

}
+(NSString *)getUserName
{
    return   [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];

}
+(NSString *)getPassWord
{
    return   [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];

}
+(void)saveToken:(NSString *)token
{
    // s;
    //    User *model = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:app.managedObjectContext];
    //    [model setToken:token];
    //    NSError *error = nil;
    //
    //    BOOL isSave =   [app.managedObjectContext save:&error];
    //    if (!isSave) {
    //        NSLog(@"error:%@,%@",error,[error userInfo]);
    //    }
    //    else{
    //        NSLog(@"保存成功");
    //    }
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    //    [self selectToken:token];
    
}
+(void)selectToken:(NSString *)token
{
    //    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    //    NSEntityDescription* user=[NSEntityDescription entityForName:@"User" inManagedObjectContext:app.managedObjectContext];
    //    [request setEntity:user];
    //    //查询条件
    //    NSPredicate* predicate=[NSPredicate pr];
    //    [request setPredicate:predicate];
    //    NSError* error=nil;
    //    NSMutableArray* mutableFetchResult=[[app.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    //    if (mutableFetchResult==nil) {
    //        NSLog(@"Error:%@",error);
    //    }
    //       //更新age后要进行保存，否则没更新
    //    for (User* user in mutableFetchResult) {
    //        [user setToken:token];
    //
    //    }
    //    [app.managedObjectContext save:&error];
    
}
+(NSString *)getToken
{
    
    //[[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    return   [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    //    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    //
    //    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //    //设置要检索哪种类型的实体对象
    //    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"inManagedObjectContext:app.managedObjectContext];
    //    //设置请求实体
    //    [request setEntity:entity];
    //    //指定对结果的排序方式
    //    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"token"ascending:NO];
    //    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    //    [request setSortDescriptors:sortDescriptions];
    //    NSError *error = nil;
    //    //执行获取数据请求，返回数组
    //    NSMutableArray *mutableFetchResult = [[app.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    //    if (mutableFetchResult == nil) {
    //        NSLog(@"Error: %@,%@",error,[error userInfo]);
    //    }
    //    NSArray *dataArray=mutableFetchResult;
    //
    //    for (User *dog in dataArray) {
    //        return dog.token;
    //    }
    //    return nil;
}
+(NSString *)getPhotoImageString:(NSMutableArray *)arr
{
    NSString *identityString=@"";
    for (int i=0; i<arr.count; i++) {
        NSLog(@"%@",[arr objectAtIndex:i]);
        identityString=[identityString stringByAppendingString:(NSString *)[arr objectAtIndex:i]];
        if (i!=arr.count-1) {
            identityString=[identityString stringByAppendingString:@","];
        }
    }
    return identityString;
    
}
+(NSString *)codeToSeverNull:(id )nullStr
{
    
    if (nullStr == [NSNull null]) {
        return @"";
    }else
    {
        return nullStr;
    }
}
@end
