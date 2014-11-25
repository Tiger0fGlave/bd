//
//  EcModel.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-15.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "EcModel.h"

@implementation EcModel
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
- (void)setValue:(id)value forKey:(NSString *)key
{
    if (value==[NSNull null]) {
        value=nil;
    }
    
    if ([key isEqualToString:knameKey])
    {
        self.name=value;
    }
    else if ([key isEqualToString:krelKey])
    {
        self.relation=value;
    }
    else if ([key isEqualToString:ktelKey])
    {
        self.tel=value;
    }
}
@end
