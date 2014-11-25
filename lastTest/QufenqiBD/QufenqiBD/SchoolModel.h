//
//  SchoolModel.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-13.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchoolModel : NSObject
@property(nonatomic,copy)NSString *school_name;
@property(nonatomic,copy)NSNumber *school_id;
@property(nonatomic,copy)NSNumber *count;
@property(nonatomic,copy)NSArray *list;
@property (nonatomic, assign, getter = isOpened) BOOL opened;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
- (void)setValue:(id)value forKey:(NSString *)key;
@end
