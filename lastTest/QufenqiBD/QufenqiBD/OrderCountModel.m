//
//  OrderCountModel.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-13.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "OrderCountModel.h"

@implementation OrderCountModel

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
    if ([key isEqualToString:kwaitKey]) {
        self.wait=value;
    }
    if ([key isEqualToString:kauditKey]) {
        self.audit=value;
    }
    if ([key isEqualToString:kfailKey]) {
        self.fail=value;
    }
    
}
@end
