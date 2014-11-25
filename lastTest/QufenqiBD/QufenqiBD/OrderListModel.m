//
//  OrderListModel.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-13.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "OrderListModel.h"

@implementation OrderListModel
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
    
    if ([key isEqualToString:korder_listKey]) {
        _order_list=value;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in _order_list) {
            SchoolModel *friend = [SchoolModel modelWithDict:dict];
            [tempArray addObject:friend];
        }
        _order_list=tempArray;
    }
    else if ([key isEqualToString:korder_countKey])
    {
        self.order_count=value;
        OrderCountModel *model=[[OrderCountModel alloc]initWithDict:self.order_count];
        self.wait=model.wait;
        self.audit=model.audit;
        self.fail=model.fail;
    }
}
@end
