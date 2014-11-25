//
//  UserModel.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-13.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic,copy)NSString *code;
@property (nonatomic,copy)NSString *data;
@property (nonatomic,copy)NSString *token;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
- (void)setValue:(id)value forKey:(NSString *)key;
@end
