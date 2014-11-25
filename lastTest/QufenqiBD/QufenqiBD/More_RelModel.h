//
//  More_RelModel.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-15.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface More_RelModel : NSObject
@property (nonatomic,copy)NSString *qq;
@property (nonatomic,copy)NSString *wenxin;
@property (nonatomic,copy)NSString *renren;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
- (void)setValue:(id)value forKey:(NSString *)key;
@end
