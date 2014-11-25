//
//  ContractInfoModel.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-15.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "ContractInfoModel.h"

@implementation ContractInfoModel
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
- (void)setValue:(id)value forKey:(NSString *)key
{
    //联系人信息
    if (value==[NSNull null]) {
        value=nil;
    }
    NSLog(@"key==%@===value==%@",key,value);
    
    if ([key isEqualToString:kec_infoKey])
    {
        
        
        
        self.ec_Arr=value;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in _ec_Arr) {
            EcModel *friend = [EcModel modelWithDict:dict];
            [tempArray addObject:friend];
        }
        self.ec_Arr=tempArray;
        
        
    }
    else if ([key isEqualToString:kmore_relKey])
    {
        
        self.rel_Dic=value;
        More_RelModel *model=[[More_RelModel alloc]initWithDict:self.rel_Dic];
        self.qq=model.qq;
        self.wenxin=model.wenxin;
        self.renren=model.renren;
        
        
    }
    else  if ([key isEqualToString:kbuyNoKey])
    {
        
        self.contract_no=value;
    }
    else  if ([key isEqualToString:kbuyTimeKey])
    {
        self.pay_time=value;
    }
    else  if ([key isEqualToString:kaddressKey])
    {
        self.address=value;
    }
    else  if ([key isEqualToString:kidcard_photoKey])
    {
        self.idCard_Arr=value;
    }
    else  if ([key isEqualToString:kstudent_id_photoKey])
    {
        self.stdudent_Arr=value;
    }
    
    else if ([key isEqualToString:kschool_card_photoKey])
    {
        self.allpurpose_Arr=value;
    }
    else if ([key isEqualToString:kchsi_photoKey])
    {
        self.learn_Arr=value;
    }
    else if ([key isEqualToString:kdorm_photoKey])
    {
        self.hand_Arr=value;
    }
    else if ([key isEqualToString:kcontract_photoKey])
    {
        self.contract_Arr=value;
    }
    else if ([key isEqualToString:kother_photoKey])
    {
        self.other_Arr=value;
    }
    else if ([key isEqualToString:knoteKey])
    {
        self.noteStr=value;
    }
   
}
@end
