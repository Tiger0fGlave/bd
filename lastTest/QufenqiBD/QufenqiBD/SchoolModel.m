//
//  SchoolModel.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-13.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "SchoolModel.h"

@implementation SchoolModel
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
    if ([key isEqualToString:kschool_nameKey]) {
        self.school_name=value;
    }
    else if ([key isEqualToString:kschool_idKey])
    {
        self.school_id=value;
    }
    else if ([key isEqualToString:kcountKey])
    {
        self.count=(NSNumber *)value;
    }
    else if ([key isEqualToString:klistKey])
    {
        self.list=value;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in _list) {
            ListModel *friend = [ListModel modelWithDict:dict];
            [tempArray addObject:friend];
        }
        _list=tempArray;
    }
    
}
@end
