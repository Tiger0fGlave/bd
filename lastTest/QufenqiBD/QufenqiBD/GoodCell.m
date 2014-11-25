//
//  GoodCell.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-16.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "GoodCell.h"
#import "UILabel+StringFrame.h"

@implementation GoodCell
{
    NSMutableDictionary *postDic;
    BOOL isFrist;
    NSString *goodStr;
    NSString *goodUrl;
}
- (void)awakeFromNib {

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)updateDic:(NSDictionary *)dic
{
    

    isFrist=YES;
    goodUrl=nil;
    _goodName.text=[NSString codeToSeverNull:[NSString stringWithFormat:@"%@",[dic objectForKey:knameKey]]];
    goodUrl=[NSString codeToSeverNull:[NSString stringWithFormat:@"%@",[dic objectForKey:@"b2c_url"]]];
    
    _goodPrice.text=[NSString codeToSeverNull:[NSString stringWithFormat:@"%@",[dic objectForKey:kpriceKey]]];
    _goodDespritionText.text=[NSString codeToSeverNull:[NSString stringWithFormat:@"%@",[dic objectForKey:kgoods_infoKey]]];
    goodStr=[NSString codeToSeverNull:[NSString stringWithFormat:@"%@",[dic objectForKey:kgoods_infoKey]]];
    
    if ([_goodDespritionText.text length]==0) {
        _goodDespritionText.text=@"修改商品信息点击这里";
    }
    _goodDespritionText.delegate=self;
    postDic=[[NSMutableDictionary alloc]init];
    [postDic setObject:[NSString codeToSeverNull:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]] forKey:@"goods_id"];
    [postDic setObject:self.order_no forKey:korder_no];
    _goodName.userInteractionEnabled=YES;
   
        CGSize size=[_goodName boundingRectWithSize:CGSizeMake(320, 0)];
        _goodName.frame=CGRectMake(8, 68, size.width, size.height);
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickGoodName)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    [_goodName addGestureRecognizer:tap];
    
}

-(void)clickGoodName
{
    if (goodUrl!=nil) {
        [[UIApplication sharedApplication]openURL:[NSURL   URLWithString:goodUrl]];
    }
    
}


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([goodStr length]==0) {
        _goodDespritionText.text=@"";
    }
    
}
-(void)setUp:(NSDictionary *)dic1
{
    DataService *dataService=[[DataService alloc]init];
    NSString *url=@"order/change_desc?";
    url=[NSString stringWithFormat:@"%@accesstoken=%@",url,[NSString getToken]];
    [dataService postRequest:url path:nil parameter:dic1];
    [dataService  setDidFinish:^(DataService *serivice, NSDictionary *dic) {
        NSLog(@"%@",[dic objectForKey:kmessageKey]);
        
        if ([((NSNumber *)[dic objectForKey:kcodeKey])isEqualToNumber:[NSNumber numberWithInt:0]]) {
            MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:self];
            [UIView showHUD:[dic objectForKey:kmessageKey] andView:self  andHUD:hud];
            [hud hide:YES afterDelay:1];
            goodStr=_goodDespritionText.text;
        }
        else
        {
            MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:self];
            [UIView showHUD:[dic objectForKey:kmessageKey] andView:self  andHUD:hud];
            [hud hide:YES afterDelay:1];
            goodStr=@"修改商品信息点击这里";
            _goodDespritionText.text=goodStr;
        }
        _goodDespritionText.editable=YES;
    }];
    [dataService setDidFailed:^(DataService *serivice, NSError *error) {
        MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:self];
         [UIView showHUD:@"网络错误" andView:self  andHUD:hud];
        [hud hide:YES afterDelay:1];
        goodStr=@"修改商品信息点击这里";
        _goodDespritionText.text=goodStr;
    }];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (isFrist) {
        isFrist=NO;
        return;
    }
    if (isFrist==NO) {
        if ([goodStr isEqualToString:_goodDespritionText.text]) {
            //防止多次请求
            return;
        }
        [postDic setObject:_goodDespritionText.text forKey:@"desc"];
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定修改商品描述吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alter show];
        alter.tag=102;
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        _goodDespritionText.editable=NO;
        [self setUp:postDic];
    }
    else
    {
        _goodDespritionText.text=goodStr;
        if ([_goodDespritionText.text length]==0) {
            _goodDespritionText.text=@"修改商品信息点击这里";
        }
    }
}

@end
