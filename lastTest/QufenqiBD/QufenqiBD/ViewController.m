//
//  ViewController.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-12.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "ListViewController.h"
#import "DetailViewController.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;

@end

@implementation ViewController
{
    MBProgressHUD *hud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.hidden=YES;
    self.view.backgroundColor=UIColorFromRGB(0x383a4c);
    self.passWordTextField.secureTextEntry=YES;
    if ([[NSString getToken]length]!=0) {
        hud.hidden=NO;
        self.userNameTextField.text=[NSString getUserName];
        self.passWordTextField.text=[NSString getPassWord];
//        [UIView showHUD:@"正在登录" andView:self.view andHUD:hud];
//         NSString *url=kuserLogin;
//        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
//        [dic setValue:self.userNameTextField.text forKey:@"username"];
//        [dic setValue:self.passWordTextField.text forKey:@"password"];
//         DataService *dataService=[[DataService alloc]init];
//        [dataService postRequest:url path:nil parameter:dic];
//        [dataService setDidFinish:^(DataService *serivice, NSDictionary *dic) {
//            NSLog(@"%@",[dic objectForKey:@"message"]);
//            UserModel *userModel=[[UserModel alloc]initWithDict:dic];
//
//            if ([userModel.code intValue]==0) {
//                //登录成功
//                [NSString saveToken:[[dic objectForKey:kdataKey] objectForKey:@"accesstoken"]];
//                [NSString saveUser:self.userNameTextField.text andPassword:self.passWordTextField.text];
//                ListViewController *lv=[[ListViewController alloc]init];
//                UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:lv];
//                lv.username=self.userNameTextField.text;
//                [self presentViewController:nav animated:YES completion:nil];
//                lv=nil;
//                
//            }else
//            {
//                hud.hidden=NO;
//                hud.labelText=[dic objectForKey:kmessageKey];
//                [hud hide:YES afterDelay:1];
//            }
//            
//
//        }];
//        [dataService setDidFailed:^(DataService *serivice, NSError *error) {
//            
//            hud.hidden=NO;
//            hud.labelText=@"网络或者服务器错误";
//            [hud hide:YES afterDelay:1];
//            
//        }];

        
        
    }
    
    
    
}
- (IBAction)ClickOkAction:(id)sender {
    if (self.userNameTextField.text.length==0||self.passWordTextField.text.length==0) {
        [UIView showHUD:@"用户名或者密码不能为空" andView:self.view andHUD:hud];
        hud.hidden=NO;
        [hud hide:YES afterDelay:2];
        return;
    }
    [self postLogin];
}
/* 登陆*/
-(void)postLogin
{
    hud.hidden=NO;
    [UIView showHUD:@"正在登录" andView:self.view andHUD:hud];
    DataService *dataService=[[DataService alloc]init];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:self.userNameTextField.text forKey:@"username"];
    [dic setValue:self.passWordTextField.text forKey:@"password"];
    NSString *url=kuserLogin;
    [dataService  postRequest:url path:nil parameter:dic];
    [dataService  setDidFinish:^(DataService *serivice, NSDictionary *dic) {
        hud.hidden=YES;
        UserModel *userModel=[[UserModel alloc]initWithDict:dic];
        if ([userModel.code intValue]==0) {
            //登录成功
            [NSString saveToken:[[dic objectForKey:kdataKey] objectForKey:@"accesstoken"]];
            [NSString saveUser:self.userNameTextField.text andPassword:self.passWordTextField.text];
            NSString *ptr=[NSString getToken];
            NSLog(@"%@",ptr);
            ListViewController *lv=[[ListViewController alloc]init];
            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:lv];
            lv.username=self.userNameTextField.text;
            [self presentViewController:nav animated:YES completion:nil];
            
        }else
        {
            hud.hidden=NO;
            hud.labelText=[dic objectForKey:kmessageKey];
            [hud hide:YES afterDelay:1];
        }
        
    }];
    [dataService setDidFailed:^(DataService *serivice, NSError *error) {
        
        hud.hidden=NO;
        hud.labelText=@"网络或者服务器错误";
        [hud hide:YES afterDelay:1];
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
