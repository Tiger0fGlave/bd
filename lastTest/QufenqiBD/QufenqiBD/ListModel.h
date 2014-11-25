//
//  ListModel.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-13.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject
@property(nonatomic,copy)NSNumber *order_no;
@property(nonatomic,copy)NSNumber *order_id;
@property(nonatomic,copy)NSString *order_status;
@property(nonatomic,copy)NSString *accept_name;
@property(nonatomic,copy)NSNumber *mobile;
@property(nonatomic,copy)NSString *time_diff;
@property(nonatomic,copy)NSString *goods_name;
@property(nonatomic,copy)NSNumber *order_price;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *warning;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
- (void)setValue:(id)value forKey:(NSString *)key;
@end
