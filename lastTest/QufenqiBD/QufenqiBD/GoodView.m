//
//  GoodView.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-16.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "GoodView.h"



@implementation GoodView
{
    
    UIPickerView *pickView;
    NSMutableArray *monthArr;
    UIScrollView *scrollView;
    DataService *fenqiService;
    NSNumber *max;
    NSString *order_num;
    NSInteger iMax;
    UIButton *cancelBtn;
    UIButton *okBtn;
    BOOL isPost;
    
}
@synthesize hud;
@synthesize mTableView;
@synthesize dataArray;
@synthesize order_Info;
@synthesize cancelBtn;
@synthesize okBtn;
-(id)init
{
    if (self=[super init]) {
        isPost=NO;
           hud = [[MBProgressHUD alloc] initWithView:self];
    }
    return self;
}
-(void)initMax_FenQI:(NSDictionary *)order_infoDic andGoodInfo:(NSArray *)goodArr
{
    isPost=YES;
    //self.backgroundColor=[UIColor redColor];
    order_Info=order_infoDic;
    max=[order_Info objectForKey:@"max_fenqi"];
    order_num=[order_Info objectForKey:korder_no];
    
    dataArray=[NSMutableArray arrayWithArray:goodArr];
    [self setUpTableView];
    [self initMonthArr];
    fenqiService=[[DataService alloc]init];
 
    hud.hidden=YES;
    __block GoodView *blockSelf=self;
    [fenqiService setDidFinish:^(DataService *serivice, NSDictionary *dic) {
        NSLog(@"%@",[dic objectForKey:kmessageKey]);
        if ([((NSNumber *)[dic objectForKey:kcodeKey])isEqualToNumber:[NSNumber numberWithInt:0]]) {
            [blockSelf.dataArray removeAllObjects];
            blockSelf.hud.hidden=NO;
            blockSelf.hud.labelText=[dic objectForKey:kmessageKey];
            [blockSelf.hud hide:YES afterDelay:1];
            blockSelf.order_Info=[[dic objectForKey:kdataKey] objectForKey:korder_infoKey];
            
            
            NSMutableArray *itemArray=[[NSMutableArray alloc]initWithArray:(NSArray *)[blockSelf.order_Info objectForKey:kgoods_infoKey]];
            for (NSDictionary *dic in itemArray) {
                [blockSelf.dataArray addObject:dic];
            }
            [blockSelf.mTableView reloadData];
            [blockSelf bringSubviewToFront:blockSelf.cancelBtn];
            [blockSelf bringSubviewToFront:blockSelf.okBtn];
            return ;
        }
        else
        {
            blockSelf.hud.hidden=NO;
            blockSelf.hud.labelText=[dic objectForKey:kmessageKey];
            [blockSelf.hud hide:YES afterDelay:1];
        }
        
    }];
    [fenqiService setDidFailed:^(DataService *serivice, NSError *error) {
        blockSelf.hud.labelText=@"数据下载失败,请检查网络!";
        [blockSelf.hud hide:YES afterDelay:1];
    }];
    
    
}
-(void)getDateFromServer
{
    if (isPost) {
        return;
    }
    DataService *dateServer=[[DataService alloc]init];
    NSString *url=korderDetail;
    url=[NSString stringWithFormat:@"%@accesstoken=%@",url,[NSString getToken]];
    url=[NSString stringWithFormat:@"%@&order_no=%@",url,self.order_no];
    [dateServer requestGetWithUrl:url];
    hud = [[MBProgressHUD alloc] initWithView:self];
    [UIView showHUD:kloingMessage andView:self andHUD:hud];
    [dateServer setDidFinish:^(DataService *serivice, NSDictionary *dic) {
        if ([((NSNumber *)[dic objectForKey:kcodeKey])isEqualToNumber:[NSNumber numberWithInt:1]]) {
            hud.hidden=NO;
            hud.labelText=[dic objectForKey:kmessageKey];
            [hud hide:YES afterDelay:1];
            return ;
        }
        [self.hud hide:YES];
        NSDictionary *rootDic=[dic objectForKey:kdataKey];
        NSDictionary *order_infoDic=[rootDic objectForKey:korder_infoKey];
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        NSMutableArray *itemArray=nil;
        if ([order_infoDic objectForKey:kgoods_infoKey]==[NSNull null]) {
            
        }else
        {
            itemArray=[[NSMutableArray alloc]initWithArray:(NSArray *)[order_infoDic objectForKey:kgoods_infoKey]];
        }
        for (NSDictionary *dic in itemArray) {
            [arr addObject:dic];
        }
      if (self) {
            self.hidden=NO;
            NSLog(@"----%@",[order_infoDic objectForKey:kgoods_infoKey]);
            [self initMax_FenQI:order_infoDic andGoodInfo:arr];
        }
    }];
    [dateServer setDidFailed:^(DataService *serivice, NSError *error) {
        hud.hidden=NO;
        hud.labelText=@"数据下载失败,请检查网络!";
        [hud hide:YES afterDelay:2];
    }];
}
-(void)changePostDataToServerOrder_no:(NSString *)order_no andMax:(NSString *)maxnum
{
    NSString *url=@"order/change_fenqi?";
    url=[NSString stringWithFormat:@"%@accesstoken=%@",url,[NSString getToken]];
    NSDictionary *dic=@{korder_no:order_no,@"fenqi":maxnum};
    [fenqiService postRequest:url path:nil parameter:dic];
    hud.hidden=NO;
    
    [UIView showHUD:kloingMessage andView:self andHUD:hud];
}
-(void)initMonthArr
{
    monthArr=[[NSMutableArray alloc]init];
    for (int i=1; i<=24; i++) {
        NSString *monthStr=[NSString stringWithFormat:@"%d",i];
        [monthArr addObject:monthStr];
    }
    pickView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 150)];
    pickView.dataSource=self;
    pickView.delegate=self;
    pickView.backgroundColor=[UIColor grayColor];
    [self addSubview:pickView];
    
    cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-255, 80, 40)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self addSubview:cancelBtn];
    cancelBtn.hidden=YES;
    okBtn=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-80,kSCREEN_HEIGHT-255 , 80, 40)];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:okBtn];
    cancelBtn.hidden=YES;
    okBtn.hidden=YES;
    
    iMax=1;
    [cancelBtn addTarget:self action:@selector(clickCanel) forControlEvents:UIControlEventTouchUpInside];
    [okBtn addTarget:self action:@selector(clickOk) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)clickCanel
{
    [UIView animateWithDuration:1 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
    } completion:^(BOOL finished) {
        
        pickView.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, 150);
    }];
    cancelBtn.hidden=YES;
    okBtn.hidden=YES;
    
}
-(void)clickOk
{
    
    [self changePostDataToServerOrder_no:order_num andMax:[NSString  stringWithFormat:@"%ld",(long)iMax]];
    
    
    [UIView animateWithDuration:1 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
    } completion:^(BOOL finished) {
        
        pickView.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, 150);
    }];
    okBtn.hidden=YES;
    cancelBtn.hidden=YES;
}
- (void)setUpTableView
{
    
    mTableView=[[UITableView alloc]initWithFrame:CGRectMake(0 ,0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    mTableView.delegate=self;
    mTableView.dataSource=self;
    mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:mTableView];
    [mTableView reloadData];
}
#pragma TableView
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    FenQiFootView *footView=[FenQiFootView fenqiFootViewWithTableView:tableView];
    footView.delegate=self;
    footView.order_id=self.order_id;
    [footView update:order_Info];
    //footView.contentView.backgroundColor=[UIColor orangeColor];
    return footView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 150+25;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([GoodCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered = YES;
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
    }
    GoodCell * goodCell = (GoodCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row%2==0) {
        goodCell.backgroundColor=UIColorFromRGB(0xf3f3f3);
    }else
    {
        goodCell.backgroundColor=[UIColor whiteColor];
    }
    tableView.allowsSelection = NO;
    goodCell.order_no=order_num;
    [goodCell updateDic:(NSDictionary *)[dataArray objectAtIndex:indexPath.row]];
    return goodCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 213;
}
#pragma PickView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [monthArr count];
}

#pragma mark Picker Delegate Methods

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return  [NSString stringWithFormat:@"%@个月",[monthArr objectAtIndex:row]];
}
-(void) pickerView: (UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component
{
    NSLog(@"werer%@",[monthArr objectAtIndex:row]);
    
    iMax=row+1;
    
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 80;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.frame.size.width;
}
#pragma footViewDelegate
-(void)changeClickButton
{
    cancelBtn.hidden=NO;
    okBtn.hidden=NO;
    [UIView animateWithDuration:1 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
    } completion:^(BOOL finished) {
        
        pickView.frame=CGRectMake(0, self.frame.size.height-150, self.frame.size.width, 150);
    }];
}
@end
