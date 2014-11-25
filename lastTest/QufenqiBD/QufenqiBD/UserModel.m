//
//  UserModel.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-13.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
}
- (void)setValue:(id)value forKey:(NSString *)key
{
    
    if (value==[NSNull null]) {
        value=nil;
    }
    if ([key isEqualToString:kcodeKey]) {
        self.code=value;
    }
    else if ([key isEqualToString:kdataKey]) {
        self.data=value;
    }
    else if ([key isEqualToString:kmessageKey]) {
        self.token=value;
    }
    
}
@end
