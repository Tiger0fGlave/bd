//
//  ListCell.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-14.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)update
{
    if (self.entity.accept_name)
    {
        self.name.text=self.entity.accept_name;
    }
    if (self.entity.mobile)
    {
        self.mobile.text=[NSString stringWithFormat:@"%@",self.entity.mobile];
    }
    if (self.entity.time_diff)
    {
        self.time.text=self.entity.time_diff;
    }
    if (self.entity.goods_name)
    {
        self.goodname.text=self.entity.goods_name;
    }
    if (self.entity.order_price)
    {
        self.goodprice.text=[NSString stringWithFormat:@"%@",self.entity.order_price];
    }
    if (self.entity.address)
    {
        self.address.text=self.entity.address;
    }
    if (self.entity.order_no) {
        self.order_numLable.text=(NSString *)self.entity.order_no;
    }
    if (self.entity.order_id) {
        self.order_id.text=(NSString *)self.entity.order_id;
    }
    if (self.entity.warning) {
        self.warningLable.text=self.entity.warning;
    }
}

- (IBAction)pushMessage:(id)sender {
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass!=nil) {
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        messageController.messageComposeDelegate = self;
        NSString *messageContent=nil;
        if ([self.entity.order_price intValue]<5289) {
          messageContent = [NSString stringWithFormat:@"%@同学您好，我是趣分期工作人员，约好到您宿舍签订协议，请提前准备好本人身份证、学生证、教务处网、学信网认证资料。如有疑问，可来电咨询。",self.entity.accept_name];
        }else
        {
            messageContent = [NSString stringWithFormat:@"%@同学您好，我是趣分期工作人员，约好到您宿舍签订协议，请提前准备好本人身份证、学生证、教务处网、学信网认证资料、成绩单、近三个月银行流水。如有疑问，可来电咨询。",self.entity.accept_name];
        }
        messageController.body = messageContent;
        messageController.recipients = @[self.entity.mobile];
        [self.viewController presentViewController:messageController animated:YES completion:nil];
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
        if (result==MessageComposeResultSent) {
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"短信发送成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        [alter show];
    }else if (result==MessageComposeResultFailed)
    {
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"短信发送失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        [alter show];
    }
    else if (result==MessageComposeResultCancelled)
    {
        
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pushMobile:(id)sender {
    NSString *mobile=[NSString stringWithFormat:@"telprompt://%@",self.entity.mobile];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mobile]];//打电话
}

@end
