//
//  OrderCountModel.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-13.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderCountModel : NSObject
@property(nonatomic,copy)NSNumber *wait;
@property(nonatomic,copy)NSNumber *audit;
@property(nonatomic,copy)NSNumber *fail;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
- (void)setValue:(id)value forKey:(NSString *)key;
@end
