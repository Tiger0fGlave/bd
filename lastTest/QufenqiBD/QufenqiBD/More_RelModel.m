//
//  More_RelModel.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-15.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "More_RelModel.h"

@implementation More_RelModel
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
    if ([key isEqualToString:kqqKey]) {
        self.qq=value;
    }
    else if ([key isEqualToString:kwenxinKey])
    {
        self.wenxin=value;
    }
    else if([key isEqualToString:krenrenKey])
    {
        self.renren=value;
    }
}
@end
