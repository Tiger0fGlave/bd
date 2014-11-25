//
//  EcModel.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-15.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EcModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *relation;
@property(nonatomic,copy)NSString *tel;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
- (void)setValue:(id)value forKey:(NSString *)key;
@end
