//
//  ListViewController.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-13.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "ListViewController.h"
#import "ListCell.h"
#define kButtonTag 100

@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate,HeadViewDelegate>
{
    UITableView *mTableView;
    UIButton *btnfail;
    UIButton *btnaudit;
    UIButton *btnwait;
    DataService *dataService;
    BOOL isFirst;
    BOOL isFirstSecond;
    BOOL isDevFirst;
    BOOL isFailUrl;
    UILabel *m_pNoLable;
    NSString *token;
    
    
}
@property(nonatomic,retain)MBProgressHUD *hud;
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)UITableView *mTableView;

@end

@implementation ListViewController
@synthesize hud;
@synthesize dataArray;
@synthesize mTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    m_pNoLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 400, 40)];
    m_pNoLable.text=@"暂时没有对应的的数据源";
    m_pNoLable.font=[UIFont systemFontOfSize:24];
    m_pNoLable.textColor=[UIColor redColor];
    m_pNoLable.center=CGPointMake(kSCREEN_WIDTH/2, kSCREEN_HEIGHT/2);
    m_pNoLable.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:m_pNoLable];
    m_pNoLable.hidden=YES;
    dataArray=[[NSMutableArray alloc]init];
    dataArray=[[NSMutableArray alloc]init];
    dataService=[[DataService alloc]init];
    isFirst=NO;
    isDevFirst=NO;
    isFailUrl=NO;
    isFirstSecond=NO;
    NSString *url=korderList;
    hud =[[MBProgressHUD alloc]initWithView:self.view];
    hud.hidden=NO;
    [self setUpTable];
    [self changeNavigationItem];
    url=[NSString stringWithFormat:@"%@accesstoken=%@&status=wait",url,[NSString getToken]];
    token=[NSString getToken];
    [self requestData:url];
    __block ListViewController *blockSelf=self;
    [dataService setDidFinish:^(DataService *serivice, NSDictionary *dic)
     {
        [blockSelf.dataArray removeAllObjects];
        if ([((NSNumber *)[dic objectForKey:kcodeKey])isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            NSLog(@"23423423===%@", [dic objectForKey:@"message"])    ;
            [blockSelf.mTableView reloadData];
            blockSelf.mTableView.hidden=YES;
            m_pNoLable.hidden=NO;
            if (isFirstSecond==YES)
            {
                blockSelf.hud.hidden=YES;
                return ;
            }
            if (isFailUrl==NO)
            {
                NSString *url=korderList;
                
                url=[NSString stringWithFormat:@"%@accesstoken=%@&status=fail",url,[NSString getToken]];
                
                [self requestData:url];
                isFailUrl=YES;
                return;
            }
            else if (isFailUrl==YES)
            {
                isFirstSecond=YES;
                NSString *url=korderList;
                url=[NSString stringWithFormat:@"%@accesstoken=%@&status=audit",url,[NSString getToken]];
                
                [self requestData:url];
                return;
            }
            return ;
        }
        blockSelf.mTableView.hidden=NO;
        m_pNoLable.hidden=YES;
        blockSelf.hud.hidden=YES;
        NSDictionary *dataDic=[dic objectForKey:kdataKey];
        OrderListModel *orderModel=[[OrderListModel alloc]initWithDict:dataDic];
        [blockSelf setUpButton:orderModel.fail and:orderModel.wait and:orderModel.audit];
        blockSelf.dataArray=orderModel.order_list;
        [blockSelf.mTableView reloadData];
    }];
    [dataService setDidFailed:^(DataService *serivice, NSError *error)
     {
        blockSelf.hud.labelText=@"网络或者服务器错误";
        [blockSelf.hud hide:YES afterDelay:1];
    }];

    if (btnfail==nil)
    {
        btnfail=[UIButton buttonWithType:UIButtonTypeCustom];
    }
    btnfail.frame= CGRectMake(0, 0, kSCREEN_WIDTH/3, 44);
    NSString *failStr=[NSString stringWithFormat:@"审核失败 (0)"];
    [btnfail setTitle:failStr forState:UIControlStateNormal];
    [self.view addSubview:btnfail];
    btnfail.tag=kButtonTag;
    if (btnwait==nil)
    {
        btnwait=[UIButton buttonWithType:UIButtonTypeCustom];
    }
    btnwait.frame=CGRectMake(kSCREEN_WIDTH/3,0, kSCREEN_WIDTH/3, 44);
    NSString *waitlStr=[NSString stringWithFormat:@"待处理 (0)"];
    [btnwait setTitle:waitlStr forState:UIControlStateNormal];
    [self.view addSubview:btnwait];
    btnwait.tag=kButtonTag+1;
    if (btnaudit==nil)
    {
        btnaudit=[UIButton buttonWithType:UIButtonTypeCustom];
    }
    btnaudit.frame =CGRectMake(kSCREEN_WIDTH*2/3, 0, kSCREEN_WIDTH/3, 44);
    NSString *auditStr=[NSString stringWithFormat:@"待审核 (0)"];
    [btnaudit setTitle:auditStr forState:UIControlStateNormal];
    [self.view addSubview:btnaudit];
    btnaudit.tag=kButtonTag+2;
    
    [self.view bringSubviewToFront:btnaudit];
    [self.view bringSubviewToFront:btnfail];
    [self.view bringSubviewToFront:btnwait];
    
    [btnfail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnwait setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnaudit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btnfail setTitleColor:[ UIColor redColor] forState:UIControlStateHighlighted];
    [btnwait setTitleColor:[ UIColor redColor] forState:UIControlStateHighlighted];
    [btnaudit setTitleColor:[ UIColor redColor] forState:UIControlStateHighlighted];
    
    [btnfail setTitleColor:[ UIColor redColor] forState:UIControlStateSelected];
    [btnwait setTitleColor:[ UIColor redColor] forState:UIControlStateSelected];
    [btnaudit setTitleColor:[ UIColor redColor] forState:UIControlStateSelected];
    
    for ( int i=0; i<2; i++)
    {
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH/3)*(i+1), 10, 1, 22)];
        img.image=[UIImage imageNamed:@"linev.png"];
        [self.view addSubview:img];
    }
    btnfail.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    btnaudit.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    btnwait.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [btnwait addTarget:self action:@selector(clickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [btnaudit addTarget:self action:@selector(clickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [btnfail addTarget:self action:@selector(clickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:kcancelOrder object:nil];
}
-(void)updateUI
{
    NSString *url=korderList;
    url=[NSString stringWithFormat:@"%@accesstoken=%@&status=wait",url,[NSString getToken]];
    isFirst=NO;
    isFailUrl=NO;
    isFirstSecond=NO;
    [self requestData:url];
}
-(void)setUpButton:(NSNumber *)fail and:(NSNumber *)wait and:(NSNumber *)audit
{
    NSString *failStr=[NSString stringWithFormat:@"审核失败 (%@)",fail];
    [btnfail setTitle:failStr forState:UIControlStateNormal];
    NSString *waitlStr=[NSString stringWithFormat:@"待处理 (%@)",wait];
    [btnwait setTitle:waitlStr forState:UIControlStateNormal];
    NSString *auditStr=[NSString stringWithFormat:@"待审核 (%@)",audit];
    [btnaudit setTitle:auditStr forState:UIControlStateNormal];
    if (isFirst==NO)
    {
        isFirst=YES;
        if ([wait integerValue]!=0)
        {
            [btnwait  setSelected:YES];
            [btnfail setSelected:NO];
            [btnaudit setSelected:NO];
            return;
        }
        if ([fail integerValue]!=0)
        {
            [btnwait  setSelected:NO];
            [btnfail setSelected:YES];
            [btnaudit setSelected:NO];
            return;
        }
        if ([audit integerValue]!=0)
        {
            [btnwait  setSelected:NO];
            [btnfail setSelected:NO];
            [btnaudit setSelected:YES];
            return;
        }
    }
}
-(void)clickTitleButton:(UIButton *)btn
{
    hud.hidden=NO;
    hud.labelText=kloingMessage ;
    NSString *status=nil;
    // [btn setSelected:YES];
    if (btn.tag==kButtonTag)
    {
        //失败
        status=kfailKey;
        [btn setSelected:YES];
        [btnwait setSelected:NO];
        [btnaudit setSelected:NO];
    }
    else if (btn.tag==kButtonTag+1)
    {
        //待处理
        status=kwaitKey;
        [btn  setSelected:YES];
        [btnfail setSelected:NO];
        [btnaudit setSelected:NO];
    }
    else if (btn.tag==kButtonTag+2)
    {
        //待审核
        status=kauditKey;
        [btnfail setSelected:NO];
        [btnwait setSelected:NO];
        [btn setSelected:YES];
    }
    NSString *url=korderList;
    url=[NSString stringWithFormat:@"%@accesstoken=%@",url,[NSString getToken]];
    url=[NSString stringWithFormat:@"%@&status=%@",url,status];
    [self requestData:url];
}

-(void)setUpTable
{
    mTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, kSCREEN_WIDTH,kSCREEN_HEIGHT-kNavigationBar_HEIGHT-44)];
    mTableView.delegate=self;
    mTableView.dataSource=self;
    mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:mTableView];
    [self.view sendSubviewToBack:mTableView];
    [mTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SchoolModel *friendGroup = dataArray[section];
    NSInteger count = friendGroup.isOpened ? friendGroup.list.count : 0;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered)
    {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([ListCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered = YES;
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
    }
    ListCell * listCell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (indexPath.row%2==0) {
        listCell.backgroundColor=UIColorFromRGB(0xf3f3f3);
    }else
    {
        listCell.backgroundColor=[UIColor whiteColor];
    }
    SchoolModel *friendGroup = dataArray[indexPath.section];
    ListModel *friend = friendGroup.list[indexPath.row];
    listCell.entity=friend;
    listCell.viewController=self;
    [listCell update];
    return listCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *headView = [HeadView headViewWithTableView:tableView];
    headView.delegate = self;
    headView.friendGroup = dataArray[section];
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SchoolModel *friendGroup = dataArray[indexPath.section];
    ListModel *friend = friendGroup.list[indexPath.row];
    if ([friend.order_status isEqualToString:kauditKey])
    {
        hud.hidden=NO;
        [UIView showHUD:@"待审核的订单只能浏览不能进入" andView:self.view andHUD:hud];
        [hud hide:YES afterDelay:1];
        return;
    }
    DetailViewController *detailVc=[[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
    if (detailVc!=nil)
    {
        detailVc.order_number=[NSString stringWithFormat:@"%@",friend.order_no];
        detailVc.username=self.username;
        detailVc.order_status=friend.order_status;
        detailVc.order_id=[NSString stringWithFormat:@"%@",friend.order_id];
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}

- (void)clickHeadView
{
    [mTableView reloadData];
}
-(void)changeNavigationItem
{
    //    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    //    [rightBtn setTitle:@"刷新" forState:UIControlStateNormal];
    //    [rightBtn addTarget:self action:@selector(updateData) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    //    self.navigationItem.rightBarButtonItem = rightBarItem;
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(-10, 0, 90, 30)];
    [leftBtn setTitle:@"订单列表" forState:UIControlStateNormal];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake([self.username length] *18/2, 0, [self.username length] *18, 30)];
    lable.textColor=[UIColor whiteColor];
    lable.backgroundColor=[UIColor clearColor];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.text=self.username;
    self.navigationItem.titleView=lable;
}
-(void)updateData
{
    NSString *url=korderList;
    url=[NSString stringWithFormat:@"%@accesstoken=%@",url,[NSString getToken]];
    [btnfail setSelected:NO];
    [btnwait setSelected:YES];
    [btnaudit setSelected:NO];
    [self requestData:url];
}

-(void)requestData:(NSString *)url
{
    hud.hidden=NO;
    [UIView showHUD:kloingMessage andView:self.view andHUD:hud];
    [dataService requestGetWithUrl:url];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resouarces that can be recreated.
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
