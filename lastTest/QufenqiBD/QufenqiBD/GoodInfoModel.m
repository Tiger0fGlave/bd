//
//  GoodInfoModel.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-15.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "GoodInfoModel.h"

@implementation GoodInfoModel
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return  [[self alloc]initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self =[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
- (void)setValue:(id)value forKey:(NSString *)key
{
  
    if (value==[NSNull null]) {
        value=nil;
    }
    if ([key isEqualToString:kpriceKey])
    {
        self.goodPrice=value;
    }else if ([key isEqualToString:knameKey])
    {
        self.goodName=value;
    }
    else if ([key isEqualToString:kgoods_infoKey])
    {
        self.goodDesription=value;
    }
}
@end
