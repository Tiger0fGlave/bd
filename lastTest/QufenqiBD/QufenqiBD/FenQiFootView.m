//
//  FenQiFootView.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-17.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "FenQiFootView.h"

#define kH 25
@implementation FenQiFootView

- (IBAction)changeMonth:(id)sender {
    [self.delegate changeClickButton];
}
-(void)clickBtn
{
    //[self.delegate changeClickButton];
}
+ (FenQiFootView *)fenqiFootViewWithTableView:(UITableView *)tableView
{
    static NSString *headIdentifier = @"footer";
    
    FenQiFootView *headView = [tableView dequeueReusableCellWithIdentifier:headIdentifier];
    if (headView == nil) {
        headView = [[FenQiFootView alloc] initWithReuseIdentifier:headIdentifier];
    }
    
    return headView;
}
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UILabel *orderLable1=[[UILabel alloc]initWithFrame:CGRectMake(24, 3, 300, 22)];
        orderLable1.text=@"订单ID:";
        orderLable1.backgroundColor=[UIColor clearColor];
        orderLable1.textColor=[UIColor blackColor];
        [self.contentView addSubview:orderLable1];
        _orederLable=[[UILabel alloc]initWithFrame:CGRectMake(98, 3, 200, 22)];
        _orederLable.textColor=[UIColor darkGrayColor];
        _orederLable.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:_orederLable];

        UILabel *amountLable=[[UILabel alloc]initWithFrame:CGRectMake(24, 25, 75, 22)];
        amountLable.text=@"总价款:";
        amountLable.textColor=[UIColor blackColor];
        amountLable.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:amountLable];
        _amontLablePrice=[[UILabel alloc]initWithFrame:CGRectMake(98, 25, 100, 22)];
        _amontLablePrice.text=@"8888";
        _amontLablePrice.backgroundColor=[UIColor clearColor];
        _amontLablePrice.textColor=[UIColor darkGrayColor];
        UILabel * big=[[UILabel alloc]initWithFrame:CGRectMake(24, 25+kH, 100, 22)];
        big.text=@"大写:";
        big.backgroundColor=[UIColor clearColor];
        big.textColor=[UIColor blackColor];
        [self.contentView addSubview:big];
        
        _bigLable=[[UILabel alloc]initWithFrame:CGRectMake(98, 25+25, 300, 22)];
        _bigLable.text=@"8888";
        _bigLable.backgroundColor=[UIColor clearColor];
        _bigLable.textColor=[UIColor darkGrayColor];
        [self.contentView addSubview:_bigLable];
        
        
        [self.contentView addSubview:_amontLablePrice];
        UILabel  *firstLable=[[UILabel alloc]initWithFrame:CGRectMake(24, 54+kH, 55, 22)];
        firstLable.backgroundColor=[UIColor clearColor];
        firstLable.textColor=[UIColor blackColor];
        [self.contentView addSubview:firstLable];
        firstLable.text=@"首付:";
        _firstPrice=[[UILabel alloc]initWithFrame:CGRectMake(98, 54+kH, 70, 22)];
        [self.contentView addSubview:_firstPrice];
        _firstPrice.backgroundColor=[UIColor clearColor];
        _firstPrice.text=@"1000";
        _firstPrice.textColor=[UIColor darkGrayColor];
        UILabel *paseLable=[[UILabel alloc]initWithFrame:CGRectMake(172, 54+kH, 55, 22)];
        [self.contentView addSubview:paseLable];
        paseLable.text=@"余款:";
        paseLable.backgroundColor=[UIColor clearColor];
        paseLable.textColor=[UIColor blackColor];
        _paseLablPrice=[[UILabel alloc]initWithFrame:CGRectMake(222, 54+kH, 100, 22)];
        [self.contentView addSubview:_paseLablPrice];
        _paseLablPrice.text=@"7888";
        _paseLablPrice.backgroundColor=[UIColor clearColor];
        _paseLablPrice.textColor=[UIColor darkGrayColor];
        UILabel *fenqiNum=[[UILabel alloc]initWithFrame:CGRectMake(24, 84+kH, 91, 22)];
        fenqiNum.text=@"分期数:";
        fenqiNum.backgroundColor=[UIColor clearColor];
        fenqiNum.textColor=[UIColor blackColor];
        [self.contentView addSubview:fenqiNum];
        
        _fenqiMonth=[[UILabel alloc]initWithFrame:CGRectMake(98, 84+kH, 73, 22)];
        _fenqiMonth.text=@"18个月";
        _fenqiMonth.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:_fenqiMonth];
        _fenqiMonth.textColor=[UIColor darkGrayColor];
        //修改
        //        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        //        btn.frame=CGRectMake(190, 84, 50, 22);
        //        [btn setTintColor:[UIColor blueColor]];
        //        [btn setTitle:@"修改" forState:UIControlStateNormal];
        //        [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
        //        [self.contentView addSubview:btn];
        
        UILabel *monthLable=[[UILabel alloc]initWithFrame:CGRectMake(24, 112+kH, 55, 22)];
        monthLable.text=@"月供:";
        monthLable.backgroundColor=[UIColor clearColor];
        monthLable.textColor=[UIColor blackColor];
        [self.contentView addSubview:monthLable];
        
        _monthfee=[[UILabel alloc]initWithFrame:CGRectMake(98, 112+kH, 240, 22)];
        _monthfee.text=@"150元 （含服务费5元）";
        [self.contentView addSubview:_monthfee];
        _monthfee.textColor=[UIColor darkGrayColor];
        _monthfee.backgroundColor=[UIColor clearColor];
        
        
        
    }
    return self;
}
-(void)update:(NSDictionary *)info
{
    
    _orederLable.text=[NSString stringWithFormat:@"%@",self.order_id];
    _fenqiMonth.text=[NSString codeToSeverNull:[NSString stringWithFormat:@"%@个月",[((NSDictionary *)[info objectForKey:@"order_amount"])  objectForKey:@"fenqi"]]];
//
       _amontLablePrice.text= [NSString stringWithFormat:@"%.2f",[[NSString codeToSeverNull:[NSString stringWithFormat:@"%@",[((NSDictionary *)[info objectForKey:@"order_amount"])  objectForKey:@"payable_amount"]]] floatValue]]  ;
    _bigLable.text=[((NSDictionary *)[info objectForKey:@"order_amount"])  objectForKey:@"num2cny"]  ;

    _firstPrice.text=[NSString codeToSeverNull:[NSString stringWithFormat:@"%@",[((NSDictionary *)[info objectForKey:@"order_amount"])  objectForKey:@"real_amount"]]];
    float num=[_amontLablePrice.text floatValue]-[_firstPrice.text floatValue];
    _paseLablPrice.text=[NSString stringWithFormat:@"%.2f",num];
    NSString *per_pay=[NSString codeToSeverNull:[((NSDictionary *)[info objectForKey:@"order_amount"])  objectForKey:@"per_pay"]];
    NSString *service_fee=[NSString codeToSeverNull:[((NSDictionary *)[info objectForKey:@"order_amount"])  objectForKey:@"service_fee"]];
    float fpay=[per_pay floatValue];
    float ffee=[service_fee floatValue];
    
    
    
    _monthfee.text=[NSString stringWithFormat:@"%.2f (含服务费%.2f元) ",fpay,ffee];
    
    
}
-(void)awakeFromNibe
{
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
