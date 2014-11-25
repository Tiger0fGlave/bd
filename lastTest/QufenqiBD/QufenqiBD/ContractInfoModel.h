//
//  ContractInfoModel.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-15.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContractInfoModel : NSObject
@property (nonatomic,copy)NSMutableArray *ec_Arr;
@property (nonatomic,copy)NSMutableDictionary *rel_Dic;
@property (nonatomic,copy)NSMutableArray *idCard_Arr;
@property (nonatomic,copy)NSMutableArray *stdudent_Arr;
@property (nonatomic,copy)NSMutableArray *allpurpose_Arr;
@property (nonatomic,copy)NSMutableArray *learn_Arr;
@property (nonatomic,copy)NSMutableArray *hand_Arr;
@property (nonatomic,copy)NSMutableArray *contract_Arr;
@property (nonatomic,copy)NSMutableArray *other_Arr;
@property (nonatomic,copy)NSString *noteStr;
@property (nonatomic,copy)NSString *qq;
@property (nonatomic,copy)NSString *wenxin;
@property (nonatomic,copy)NSString *renren;
@property (nonatomic,copy)NSString *contract_no;
@property (nonatomic,copy)NSString *pay_time;
@property (nonatomic,copy)NSString *address;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
- (void)setValue:(id)value forKey:(NSString *)key;
@end
