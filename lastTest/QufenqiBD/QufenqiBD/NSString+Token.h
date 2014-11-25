//
//  NSString+Token.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-13.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Token)
/* token保存*/
+(void)saveToken:(NSString *)token;
+(void)saveUser:(NSString *)username andPassword:(NSString *)password;
+(NSString *)getToken;
+(NSString *)getUserName;
+(NSString *)getPassWord;
+(NSString *)getPhotoImageString:(NSMutableArray *)arr;
+(NSString *)codeToSeverNull:(id)nullStr;
@end
