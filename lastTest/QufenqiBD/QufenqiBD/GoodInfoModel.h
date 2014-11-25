//
//  GoodInfoModel.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-15.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodInfoModel : NSObject
@property (nonatomic,copy)NSString *goodName;
@property (nonatomic,copy)NSString *goodPrice;
@property (nonatomic,copy)NSString *goodDesription;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
- (void)setValue:(id)value forKey:(NSString *)key;
@end
