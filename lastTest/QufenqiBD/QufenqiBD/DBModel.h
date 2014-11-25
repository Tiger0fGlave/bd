//
//  DBModel.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-23.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBModel : NSObject<NSCoding,NSCopying>
@property (nonatomic,copy)NSString *order_no;
@property (nonatomic,strong)NSMutableDictionary *dateDic;
@end
