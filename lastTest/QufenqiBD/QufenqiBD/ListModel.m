//
//  ListModel.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-13.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

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
    if ([key isEqualToString:korder_no]) {
        self.order_no=value;
    }
    else if ([key isEqualToString:korder_statusKey])
    {
        self.order_status=value;
    }
    else if ([key isEqualToString:kaccept_nameKey])
    {
        self.accept_name=value;
    }
    else if ([key isEqualToString:korder_idKey])
    {
        self.order_id=value;
    }
    
    else if ([key isEqualToString:kmobileKey])
    {
        self.mobile=value;
    }
    
    else if ([key isEqualToString:ktime_diffKey])
    {
        self.time_diff=value;
    }
    
    else if ([key isEqualToString:kgoods_nameKey])
    {
        self.goods_name=value;
    }
    
    else if ([key isEqualToString:korder_priceKey])
    {
        self.order_price=value;
    }
    else if ([key isEqualToString:klistAddressKey])
    {
        self.address=value;
    }
    else if ([key isEqualToString:@"warning"])
    {
        self.warning=value;
    }

    
}
@end
