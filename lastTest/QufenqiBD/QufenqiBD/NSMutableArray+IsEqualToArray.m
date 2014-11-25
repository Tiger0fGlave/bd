//
//  NSMutableArray+IsEqualToArray.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-29.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "NSMutableArray+IsEqualToArray.h"

@implementation NSMutableArray (IsEqualToArray)
+(NSMutableArray *)IsEqulToArrCountImageArr:(NSMutableArray *)ImageArr andtitleArr:(NSMutableArray *)titleArr
{
    NSMutableArray *arr=nil;
    if (ImageArr.count-titleArr.count==1) {
        NSMutableArray *arrTitle=[NSMutableArray arrayWithArray:titleArr];
        [arrTitle addObject:kFailimageurlKey];
        arr=[NSMutableArray arrayWithArray:arrTitle];
    }else if(ImageArr.count==titleArr.count)
    {
        arr=[NSMutableArray arrayWithArray:titleArr];
    }
    return arr;
}
@end
