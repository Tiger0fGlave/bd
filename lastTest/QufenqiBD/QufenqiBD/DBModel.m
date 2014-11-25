//
//  DBModel.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-23.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "DBModel.h"
#define korder_noKey @"order_no"
#define kdateDicKey @"dateDic"
#define kisSaveKey @"isSave"

@implementation DBModel
@synthesize order_no;
@synthesize dateDic;


#pragma mark-NSCoding
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    
    [aCoder encodeObject:order_no forKey:korder_noKey];
    [aCoder encodeObject:dateDic forKey:kdateDicKey];
    
    
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self == [super init]) {
        order_no =  [aDecoder decodeObjectForKey:korder_noKey];
        dateDic= [aDecoder decodeObjectForKey:kdateDicKey];
       
        
    }
    
    return self;
}
#pragma mark-NSCopying
-(id)copyWithZone:(NSZone *)zone{
    DBModel *copy = [[[self class] allocWithZone:zone] init];
    copy.order_no = [self.order_no copyWithZone:zone];
    copy.dateDic= [self.dateDic copyWithZone:zone];
    
    return copy;
}

@end
