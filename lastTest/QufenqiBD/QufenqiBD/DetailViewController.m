//
//  DetailViewController.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-14.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "DetailViewController.h"
#import "GoodView.h"
#import "QuartzCore/QuartzCore.h"
#import "DBModel.h"
#import "JSONKit.h"
#import "AppDelegate.h"
#import "DBManager.h"
//#import "IQKeyboardManager.h"

@interface DetailViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,PickImageViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray *identity_Arr;
    NSMutableArray *stduent_Arr;
    NSMutableArray *allpurpose_Arr;
    NSMutableArray *learn_Arr;
    NSMutableArray *hand_Arr;
    NSMutableArray *contract_Arr;
    NSMutableArray *other_Arr;
    NSMutableArray *identityImage_Arr;
    NSMutableArray *stduentImage_Arr;
    NSMutableArray *allpurposeImage_Arr;
    NSMutableArray *learnImage_Arr;
    NSMutableArray *handImage_Arr;
    NSMutableArray *contractImage_Arr;
    NSMutableArray *otherImage_Arr;
    int updateNum;
    GoodView *goodView;
    DataService *postDataServer;
    UIDatePicker *pickdateView;
    NSString *dateString;
    DataService *giveUpDataSevice;
    UIButton *cancelBtn;
    UIButton *okBtn;
    BOOL isPhoto;
    NSMutableArray *successArr;
    UIWebView *m_pWebView;
    BOOL isSuccess;
    BOOL isFail;
    
}
@property (nonatomic,retain) MBProgressHUD *hud;
@property (nonatomic,assign)BOOL isPost;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *failView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet PickImageView *identityPickView;
@property (weak, nonatomic) IBOutlet PickImageView *stdudentPickView;
@property (weak, nonatomic) IBOutlet PickImageView *allpurposeCardPickView;
@property (weak, nonatomic) IBOutlet PickImageView *learnPickView;
@property (weak, nonatomic) IBOutlet PickImageView *handlePickView;
@property (weak, nonatomic) IBOutlet PickImageView *contractPickView;
@property (weak, nonatomic) IBOutlet PickImageView *otherPickView;
@property (weak, nonatomic) IBOutlet UITextField *addressTextFiled;
//购买合同号
@property (weak, nonatomic) IBOutlet UITextField *buyContratNumberTextField;
//日期
@property (weak, nonatomic) IBOutlet UITextField *dataTextField;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet UIButton *goodBtn;
@property (weak, nonatomic) IBOutlet UIButton *infoBtn;
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;

//父亲电话
@property (retain,nonatomic) NSString  *fatherName;
@property (weak, nonatomic) IBOutlet UITextField *fahterNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *fatherNumberTextField;
//母亲电话
@property (weak, nonatomic) IBOutlet UITextField *motherNameTextField;
@property (copy,nonatomic) NSString *motherName;
@property (weak, nonatomic) IBOutlet UITextField *motherNumberTextField;
//班主任电话
@property (nonatomic,copy)NSString *techerName;
@property (weak, nonatomic) IBOutlet UITextField *teacherNumTextField;
//同学电话
@property (nonatomic,retain)NSString *className;
@property (weak, nonatomic) IBOutlet UITextField *classNumTextField;
//其他联系人电话
@property (weak, nonatomic) IBOutlet UITextField *otherNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *otherPersonTextField;
//联系人方式
//QQ
@property (weak, nonatomic) IBOutlet UITextField *qqTextField;
//微信
@property (weak, nonatomic) IBOutlet UITextField *weixinTextField;
//Email
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
//备注
@property (weak, nonatomic) IBOutlet UITextField *remarkTextField;
@property (weak, nonatomic) IBOutlet UILabel *failNoteLable;
@property (weak, nonatomic) IBOutlet UIButton *goBackButton;
@property (weak, nonatomic) IBOutlet UIButton *postBtn;
@property (weak, nonatomic) IBOutlet UIImageView *line;

@end
@implementation DetailViewController
@synthesize hud;
@synthesize isPost;
/* 改变textField 边缘的框  */
-(void)changeBorder
{
    [self.buyContratNumberTextField changeBorderColor];
    [self.fatherNumberTextField     changeBorderColor];
    [self.motherNumberTextField     changeBorderColor];
    [self.teacherNumTextField       changeBorderColor];
    [self.classNumTextField         changeBorderColor];
    [self.otherNumTextField         changeBorderColor];
    [self.otherPersonTextField      changeBorderColor];
    [self.qqTextField               changeBorderColor];
    [self.weixinTextField           changeBorderColor];
    [self.emailTextField            changeBorderColor];
    [self.remarkTextField           changeBorderColor];
    [self.addressTextFiled          changeBorderColor];
    [self.fahterNameTextField       changeBorderColor];
    [self.motherNameTextField       changeBorderColor];
}
/* 初始化数组 */
-(void)initArray
{
    identity_Arr        =[[NSMutableArray alloc]init];
    stduent_Arr         =[[NSMutableArray alloc]init];
    allpurpose_Arr      =[[NSMutableArray alloc]init];
    learn_Arr           =[[NSMutableArray alloc]init];
    hand_Arr            =[[NSMutableArray alloc]init];
    contract_Arr        =[[NSMutableArray alloc]init];
    other_Arr           =[[NSMutableArray alloc]init];
    identityImage_Arr   =[[NSMutableArray alloc]init];
    stduentImage_Arr    =[[NSMutableArray alloc]init];
    allpurposeImage_Arr =[[NSMutableArray alloc]init];
    learnImage_Arr      =[[NSMutableArray alloc]init];
    handImage_Arr       =[[NSMutableArray alloc]init];
    contractImage_Arr   =[[NSMutableArray alloc]init];
    otherImage_Arr      =[[NSMutableArray alloc]init];
    successArr          =[NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
}
/* 初始化选择照片 */
-(void)initPickView
{
    //身份照片
    // self.order_number=@"141013163614349";
    self.identityPickView.viewController=self;
    self.identityPickView.delegate=self;
    self.identityPickView.order_num=self.order_number;
    [self.identityPickView initView];
    //学生证
    self.stdudentPickView.viewController=self;
    self.stdudentPickView.delegate=self;
    self.stdudentPickView.order_num=self.order_number;
    [self.stdudentPickView initView];
    //一卡通照片
    self.allpurposeCardPickView.viewController=self;
    self.allpurposeCardPickView.delegate=self;
    self.allpurposeCardPickView.order_num=self.order_number;
    [self.allpurposeCardPickView initView];
    //学信网照片
    self.learnPickView.viewController=self;
    self.learnPickView.delegate=self;
    self.learnPickView.order_num=self.order_number;
    [self.learnPickView initView];
    //手持合同相片
    self.handlePickView.viewController=self;
    self.handlePickView.delegate=self;
    self.handlePickView.order_num=self.order_number;
    [self.handlePickView initView];
    //合同照片
    self.contractPickView.viewController=self;
    self.contractPickView.delegate=self;
    self.contractPickView.order_num=self.order_number;
    [self.contractPickView initView];
    self.fatherNumberTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.motherNumberTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.teacherNumTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.classNumTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.otherNumTextField.keyboardType=UIKeyboardTypeNumberPad;
    [self.infoBtn setSelected:YES];
    //其他照片
    self.otherPickView.viewController=self;
    self.otherPickView.delegate=self;
    self.otherPickView.order_num=self.order_number;
    [self.otherPickView initView];
    self.scrollView.frame=CGRectMake(0, 45, kSCREEN_WIDTH, kSCREEN_HEIGHT-45);
    self.scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, 1993+kNavigationBar_HEIGHT);
    self.scrollView.scrollEnabled = YES;
    
}
-(void)goToSilCon
{
    //    SimulationContractViewController *vc=[[SimulationContractViewController alloc]initWithNibName:@"SimulationContractViewController" bundle:nil];
    //    [self.navigationController pushViewController:vc animated:YES];
}
/* 改变navigation */
-(void)changeNavigationItem
{
    //    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,  80, 30)];
    //    [rightBtn setTitle:@"模拟合同" forState:UIControlStateNormal];
    //    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [rightBtn addTarget:self action:@selector(goToSilCon) forControlEvents:UIControlEventTouchUpInside];
    //
    //    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    //self.navigationItem.rightBarButtonItem = rightBarItem;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"订单详情"
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:nil];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(-10, 0, 103, 38);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goBack1) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake([self.username length] *18/2, 0, [self.username length] *18, 30)];
    lable.textColor=[UIColor whiteColor];
    lable.backgroundColor=[UIColor clearColor];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.text=self.username;
    self.navigationItem.titleView=lable;
}
/* 返回上级界面 */
-(void)goBack1
{
    if (isPost==NO&&[self.order_status isEqualToString:kwaitKey]) {
        [UIView showHUD:@"本地保存中" andView:self.view andHUD:hud];
        [[DBManager instance] setSavedDB:^(DBModel *entity) {
            [hud hide:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [self saveDB];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
/* 初始化日期选择器 */
-(void)initDatePick
{
    pickdateView=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-300+20, kSCREEN_WIDTH, 400)];
    [self.view bringSubviewToFront:pickdateView];
    pickdateView.hidden=YES;
    pickdateView.datePickerMode=UIDatePickerModeDate;
    pickdateView.backgroundColor=[UIColor grayColor];
    [pickdateView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    [self.view addSubview:pickdateView];
    cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(-20, kSCREEN_HEIGHT-280, 80, 40)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    okBtn=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-60,kSCREEN_HEIGHT-280 , 80, 40)];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:okBtn];
    cancelBtn.hidden=YES;
    okBtn.hidden=YES;
    [cancelBtn addTarget:self action:@selector(clickCanel) forControlEvents:UIControlEventTouchUpInside];
    [okBtn addTarget:self action:@selector(clickOk) forControlEvents:UIControlEventTouchUpInside];
    
}
/* 初始化日期选择器－取消事件 */
-(void)clickCanel
{
    pickdateView.hidden=YES;
    cancelBtn.hidden=YES;
    okBtn.hidden=YES;
}
/* 初始化日期选择器－确定事件 */
-(void)clickOk
{
    pickdateView.hidden=YES;
    cancelBtn.hidden=YES;
    okBtn.hidden=YES;
    [self.dateBtn setTitle:dateString forState:UIControlStateNormal];
}
/* 日期改变 */
-(void)dateChanged:(id)sender{
    
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    dateString=[formatter stringFromDate:_date];
}
/* scrollview 滑动 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.order_status isEqualToString:kwaitKey])
    {
        self.failView.hidden=YES;
        self.line.hidden=NO;
        self.line.frame=CGRectMake(self.postBtn.frame.origin.x+self.postBtn.frame.size.width-0.5, kSCREEN_HEIGHT-kNavigationBar_HEIGHT-39, 1, 22);
    }
    self.scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, 1993+kNavigationBar_HEIGHT);
}
-(void)awakeFromNib
{
    
}
/* 初始化webView */
-(void)initWebView
{
    m_pWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 44, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNavigationBar_HEIGHT-44)];
    NSString *path=[NSString stringWithFormat:@"%@base/sh_manual",kServerIP];
    NSURL *url = [NSURL URLWithString:path];
    [m_pWebView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:m_pWebView];
    m_pWebView.hidden=YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWebView];
    [self changeBorder];
    [self initArray];
    [self initPickView];
    [self changeNavigationItem];
    self.failView.hidden=YES;
    isFail=NO;
    [DBManager instance].order_no=self.order_number;
    isSuccess=NO;
    isPost=NO;
    updateNum=0;
    NSLog(@"self.order_status==%@=self.order_number=== %@",self.order_status,self.order_number);
    self.bgView.backgroundColor=UIColorFromRGB(0xfd7878);
    self.dataTextField.enabled=NO;
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    dateString=[dateformatter stringFromDate:senddate];
    [self.dateBtn setTitle:[dateformatter stringFromDate:senddate] forState:UIControlStateNormal];
    isPhoto=NO;
    goodView=[[GoodView alloc]initWithFrame:CGRectMake(0, 44, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNavigationBar_HEIGHT-44)];
    goodView.order_id=self.order_id;
    [self.view addSubview:goodView];
    goodView.order_no=self.order_number;
    goodView.hidden=YES;
    postDataServer=[[DataService alloc]init];
    hud=[[MBProgressHUD alloc]initWithView:self.view];
    [self initDatePick];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickPhoto:) name:kclickPhotoNameNotion object:nil];
    self.line.hidden=YES;
    if ([self.order_status isEqualToString:kwaitKey])
    {
        self.failView.hidden=YES;
        NSLog(@"%f===%f",kSCREEN_HEIGHT,kSCREEN_WIDTH);
        self.postBtn.frame=CGRectMake(0, kSCREEN_HEIGHT-kNavigationBar_HEIGHT-50,(int)kSCREEN_WIDTH/2, 50);
        self.goBackButton.frame=CGRectMake( self.postBtn.frame.origin.x+self.postBtn.frame.size.width, kSCREEN_HEIGHT-kNavigationBar_HEIGHT-50, kSCREEN_WIDTH/2+1, 50);
        [self.scrollView setContentOffset:CGPointMake(0, 80) animated:NO];
        [self readDb];
    }
    else
    {
        self.goBackButton.hidden=YES;
        self.line.hidden=YES;
        self.failView.hidden=NO;
        self.postBtn.frame=CGRectMake(0, kSCREEN_HEIGHT-kNavigationBar_HEIGHT-50,(int)kSCREEN_WIDTH, 50);
        [self getDateFromServer];
    }
    
    
    
    
    
}
/* 点击照片消息接收 */
-(void)clickPhoto:(NSNotification *)noti
{
    isPhoto=YES;
}
/* 出现时间选择器 */
- (IBAction)clickDateAction:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    pickdateView.hidden=NO;
    cancelBtn.hidden=NO;
    okBtn.hidden=NO;
    [self.view bringSubviewToFront:okBtn];
    [self.view bringSubviewToFront:cancelBtn];
    
}

/* 获取订单数据 */
-(void)getDateFromServer
{
    DataService *dateServer=[[DataService alloc]init];
    NSString *url=korderDetail;
    url=[NSString stringWithFormat:@"%@accesstoken=%@",url,[NSString getToken]];
    url=[NSString stringWithFormat:@"%@&order_no=%@",url,self.order_number];
    [dateServer requestGetWithUrl:url];
    hud.hidden=NO;
    [UIView showHUD:kloingMessage andView:self.view andHUD:hud];
    [dateServer setDidFinish:^(DataService *serivice, NSDictionary *dic)
    {
        if ([((NSNumber *)[dic objectForKey:kcodeKey])isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            hud.hidden=NO;
            hud.labelText=[dic objectForKey:kmessageKey];
            [hud hide:YES afterDelay:1];
            return ;
        }
        [self.hud hide:YES];
        if ([self.order_status isEqualToString:kfailKey]==NO)
        {
            self.failView.hidden=YES;
            [self.scrollView setContentOffset:CGPointMake(0, 80) animated:NO];
        }
        NSDictionary *rootDic=[dic objectForKey:kdataKey];
        NSDictionary *contractDic=[rootDic objectForKey:kcontract_infoKey];
        NSDictionary *order_infoDic=[rootDic objectForKey:korder_infoKey];
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        NSMutableArray *itemArray=nil;
        if ([order_infoDic objectForKey:kgoods_infoKey]==[NSNull null])
        {
            
        }else
        {
            itemArray=[[NSMutableArray alloc]initWithArray:(NSArray *)[order_infoDic objectForKey:kgoods_infoKey]];
        }
        for (NSDictionary *dic in itemArray)
        {
            [arr addObject:dic];
        }
        if ([self.order_status isEqualToString:kfailKey]==YES)
        {
            NSLog(@"%@",[order_infoDic objectForKey:korder_noteKey]);
            self.failNoteLable.text=[NSString codeToSeverNull:(NSString *)[order_infoDic objectForKey:korder_noteKey]];
        }
        ContractInfoModel *conEntiy=[[ContractInfoModel alloc]initWithDict: contractDic];
        [self addDateToField:conEntiy];
    }];
    [dateServer setDidFailed:^(DataService *serivice, NSError *error)
     {
        hud.hidden=NO;
        hud.labelText=@"数据下载失败";
        [hud hide:YES afterDelay:2];
    }];
}
/* 取消订单*/
-(void)hideDelayed
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kcancelOrder object:nil];
}

#pragma DataServiceDelegate
/* 取消订单*/
-(void)goBackList
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kcancelOrder object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/* 加载网络数据到UI*/
-(void)addDateToField:(ContractInfoModel *)entity;
{
    for (int i=0; i<entity.ec_Arr.count; i++)
    {
        EcModel *ecEntity=[entity.ec_Arr objectAtIndex:i];
        if ([ecEntity.relation isEqual:@"父亲"]||[ecEntity.relation isEqual:@"父子"])
        {
            self.fatherNumberTextField.text=ecEntity.tel;
            self.fatherName=ecEntity.name;
            self.fahterNameTextField.text=ecEntity.name;
        }
        else if ([ecEntity.relation isEqual:@"母亲"]||[ecEntity.relation isEqual:@"母子"])
        {
            self.motherNumberTextField.text=ecEntity.tel;
            self.motherName=ecEntity.name;
            self.motherNameTextField.text=ecEntity.name;
        }
        else  if ([ecEntity.relation isEqual:@"班主任"])
        {
            self.teacherNumTextField.text=ecEntity.tel;
            self.techerName=ecEntity.name;
        }
        else if (([ecEntity.relation isEqual:@"同学"]))
        {
            self.classNumTextField.text=ecEntity.tel;
            self.className=ecEntity.name;
        }
        else
        {
            self.otherNumTextField.text=ecEntity.tel;
            self.otherPersonTextField.text=ecEntity.relation;
        }
    }
    self.buyContratNumberTextField.text=entity.contract_no;
    self.qqTextField.text=entity.qq;
    self.addressTextFiled.text=entity.address;
    if ([entity.pay_time length]!=0)
    {
        [self.dateBtn setTitle:entity.pay_time forState:UIControlStateNormal];
    }
    self.weixinTextField.text=entity.wenxin;
    self.emailTextField.text =entity.renren;
    self.remarkTextField.text=entity.noteStr;
    [self.identityPickView initNetView:entity.idCard_Arr];
    [self.allpurposeCardPickView initNetView:entity.allpurpose_Arr];
    [self.stdudentPickView initNetView:entity.stdudent_Arr];
    [self.learnPickView initNetView:entity.learn_Arr];
    [self.handlePickView initNetView:entity.hand_Arr];
    [self.contractPickView initNetView:entity.contract_Arr];
    [self.otherPickView initNetView:entity.other_Arr];
}
/* 加载本地数据*/
-(void)addImage:(NSMutableDictionary *)dic
{
    NSDictionary *dbDic=[dic objectForKey:kidentityKey];
    identity_Arr=[dbDic objectForKey:kImageNameArr];
    identityImage_Arr=[dbDic objectForKey:kImageArr];
    NSDictionary *dbDic1=[dic objectForKey:kstduentKey];
    stduent_Arr=[dbDic1 objectForKey:kImageNameArr];
    stduentImage_Arr=[dbDic1 objectForKey:kImageArr];
    NSDictionary *dbDic2=[dic objectForKey:kallpurposeKey];
    allpurpose_Arr=[dbDic2 objectForKey:kImageNameArr];
    allpurposeImage_Arr=[dbDic2 objectForKey:kImageArr];
    NSDictionary *dbDic3=[dic objectForKey:klearnKey];
    learn_Arr=[dbDic3 objectForKey:kImageNameArr];
    learnImage_Arr=[dbDic3 objectForKey:kImageArr];
    NSDictionary *dbDic4=[dic objectForKey:khandKey];
    hand_Arr=[dbDic4 objectForKey:kImageNameArr];
    handImage_Arr=[dbDic4 objectForKey:kImageArr];
    NSDictionary *dbDic5=[dic objectForKey:kcontractKey];
    contract_Arr=[dbDic5 objectForKey:kImageNameArr];
    contractImage_Arr=[dbDic5 objectForKey:kImageArr];
    NSDictionary *dbDic6=[dic objectForKey:kotherKey];
    other_Arr=[dbDic6 objectForKey:kImageNameArr];
    otherImage_Arr=[dbDic6 objectForKey:kImageArr];
    [self.identityPickView initDbView:identityImage_Arr andTitle:identity_Arr];
    [self.stdudentPickView initDbView:stduentImage_Arr andTitle:stduent_Arr];
    [self.allpurposeCardPickView initDbView:allpurposeImage_Arr andTitle:allpurpose_Arr];
    [self.learnPickView initDbView:learnImage_Arr andTitle:learn_Arr];
    [self.handlePickView initDbView:handImage_Arr andTitle:hand_Arr];
    [self.contractPickView initDbView:contractImage_Arr andTitle:contract_Arr];
    [self.otherPickView initDbView:otherImage_Arr andTitle:other_Arr];
    
}


/* 比较本地图片是否上传*/
-(NSMutableArray *)IsEqulToArrCountImageArr:(NSMutableArray *)ImageArr andtitleArr:(NSMutableArray *)titleArr
{
    NSMutableArray *arr=nil;
    if (ImageArr.count-titleArr.count==1)
    {
        NSMutableArray *arrTitle=[NSMutableArray arrayWithArray:titleArr];
        [arrTitle addObject:kFailimageurlKey];
        arr=titleArr;
    }
    else if(ImageArr.count==titleArr.count)
    {
        arr=titleArr;
    }
    return arr;
}
#pragma PickViewDelegate
/* 照片选择的代理方法*/
-(void)addObjectView:(PickImageView *)pickView passImageArray:(NSMutableArray *)imageArray andPassImageArr:(NSMutableArray *)arr
{
    if (pickView==self.identityPickView)
    {
        identity_Arr=[NSMutableArray IsEqulToArrCountImageArr:arr andtitleArr:imageArray];
        identityImage_Arr=arr;
    }
    else if (pickView==self.stdudentPickView)
    {
        stduent_Arr=[NSMutableArray IsEqulToArrCountImageArr:arr andtitleArr:imageArray];
        stduentImage_Arr=arr;
    }
    else if (pickView==self.allpurposeCardPickView)
    {
        allpurpose_Arr=[NSMutableArray IsEqulToArrCountImageArr:arr andtitleArr:imageArray];
        allpurposeImage_Arr=arr;
    }
    else if (pickView==self.learnPickView)
    {
        learn_Arr=[NSMutableArray IsEqulToArrCountImageArr:arr andtitleArr:imageArray];
        learnImage_Arr=arr;
    }
    else if (pickView==self.handlePickView)
    {
        hand_Arr=[NSMutableArray IsEqulToArrCountImageArr:arr andtitleArr:imageArray];
        handImage_Arr=arr;
    }
    else if (pickView==self.contractPickView)
    {
        contract_Arr=[NSMutableArray IsEqulToArrCountImageArr:arr andtitleArr:imageArray];
        contractImage_Arr=arr;
    }
    else if (pickView==self.otherPickView)
    {
        other_Arr=[NSMutableArray IsEqulToArrCountImageArr:arr andtitleArr:imageArray];
        otherImage_Arr=arr;
    }
}
#pragma upData
/* 判断电话号码是否是纯数字*/
- (BOOL)isPureNumandCharacters:(NSString *)_text
{
    for(int i = 0; i < [(NSString *)_text length]; ++i)
    {
        int a = [(NSString *)_text characterAtIndex:i];
        if (a>=0&&a<=9)
        {
            continue;
        } else {
            return YES;
        }
    }
    return NO;
}
/* 提交订单*/
- (IBAction)submitAction:(id)sender
{
    if ([self.buyContratNumberTextField.text length]==0)
    {
        [self addMessage:@"请填写购买合同号"];
        return;
    }
    else if (([self.fatherNumberTextField.text length]==0||[self.fahterNameTextField.text length]==0) &&([self.motherNumberTextField.text length]==0||[self.motherNameTextField.text length]==0))
    {
        [self addMessage:@"请至少填写父亲或者母亲信息"];
        return;
    }
    else if (([self.fatherNumberTextField.text length]==0||[self.fahterNameTextField.text length]==0)&&([self.motherNumberTextField.text length]==0&&[self.motherNameTextField.text length]==0))
    {
        [self addMessage:@"请填写父亲电话以及名称"];
        return;
    }
    else if (([self.motherNumberTextField.text length]==0||[self.motherNameTextField.text length]==0)&&([self.fatherNumberTextField.text length]==0&&[self.fahterNameTextField.text length]==0) )
    {
        [self addMessage:@"请填写母亲电话以及名称"];
        return;
    }
    
    else if ([self.classNumTextField.text length]==0)
    {
        [self addMessage:@"请填写同学电话"];
        return;
    }
    else if ([self.qqTextField.text length]==0) {
        [self addMessage:@"请填写qq"];
        return;
    }
    else if (identity_Arr.count==0)
    {
        [self addMessage:@"请至少上传一张身份证照片"];
        return;
    }
    //    else if (stduent_Arr.count==0)
    //    {
    //        [self addMessage:@"请至少上传一张学生证照片"];
    //        return;
    //    }
    else if (learn_Arr.count==0)
    {
        [self addMessage:@"请至少上传一张官方证明照片"];
        return;
    }
    else if (hand_Arr.count==0)
    {
        [self addMessage:@"请至少上传一张手持合同照片"];
        return;
    }
    else if (contract_Arr.count==0)
    {
        [self addMessage:@"请至少上传一张纸质合同照片"];
        return;
    }
    else if([self.fatherNumberTextField.text length]!=0&&[self.fatherNumberTextField.text length]!=11&&[self isPureNumandCharacters:self.fatherNumberTextField.text])
    {
        [self addMessage:@"父亲号码不是有效号码"];
        return;
    }
    else if ([self.motherNumberTextField.text length]!=0&&[self.motherNumberTextField.text length]!=11&&[self isPureNumandCharacters:self.motherNumberTextField.text])
    {
        [self addMessage:@"母亲号码不是有效号码"];
        return;
        
    }
    else if ([self.teacherNumTextField.text length]!=0&&[self.teacherNumTextField.text length]!=11&&[self isPureNumandCharacters:self.teacherNumTextField.text])
    {
        [self addMessage:@"班主任号码不是有效号码"];
        return;
        
    }
    else if ([self.classNumTextField.text length]!=0&&[self.classNumTextField.text length]!=11&&[self isPureNumandCharacters:self.classNumTextField.text])
    {
        [self addMessage:@"同学号码不是有效号码"];
        return;
        
    }
    
    else if ([self.otherNumTextField.text length]!=0&&[self.otherNumTextField.text length]!=11&&[self isPureNumandCharacters:self.otherNumTextField.text])
    {
        [self addMessage:@"其他人号码不是有效号码"];
        return;
        
    }
    
    
    
    //=====================================================================验证本地图片是否上传成功
    //    if(allpurpose_Arr.count==0)
    //    {
    //        [successArr setObject:@"1" atIndexedSubscript:2];
    //    }
    [UIView showHUD:@"正在提交" andView:self.view  andHUD:hud];
    [self handBbImage];
    //====================================================================
}
/* 提交订单*/
-(void)sumbit
{
    NSString *identityString=[NSString getPhotoImageString:identity_Arr];
    NSString *stduentString=[NSString getPhotoImageString:stduent_Arr];
    NSString *allpuposeString=[NSString getPhotoImageString:allpurpose_Arr];
    NSString *learnSting =[NSString getPhotoImageString:learn_Arr];
    NSString *handString=[NSString getPhotoImageString:hand_Arr];
    NSString *contractString=[NSString getPhotoImageString:contract_Arr];
    NSString *otherString=[NSString getPhotoImageString:other_Arr];
    NSMutableArray *relArr=[self getReL];
    NSMutableDictionary *netPerson=[[NSMutableDictionary alloc]init];
    [netPerson setValue:self.qqTextField.text forKey:kqqKey];
    [netPerson setValue:self.weixinTextField.text forKey:kwenxinKey];
    if (self.emailTextField.text!=nil)
    {
        [netPerson setValue:self.emailTextField.text forKey:krenrenKey];
    }
    NSString *netjson=[netPerson JSONString];
    NSString *relJson=[relArr JSONString];
    //----------------
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc]init];
    [dataDic setObject:self.order_number forKey:korder_no];
    [dataDic setObject:self.addressTextFiled.text forKey:kaddressKey];
    [dataDic setObject:self.remarkTextField.text forKey:knoteKey];
    [dataDic setObject:netjson forKeyedSubscript:kmore_relKey];
    [dataDic setObject:identityString forKey:kidcard_photoKey];
    [dataDic setObject:stduentString forKey:kstudent_id_photoKey];
    [dataDic setObject:allpuposeString forKey:kschool_card_photoKey];
    [dataDic setObject:learnSting forKey:kchsi_photoKey];
    [dataDic setObject:handString forKey:kdorm_photoKey];
    [dataDic setObject:contractString forKey:kcontract_photoKey];
    [dataDic setObject:otherString forKey:kother_photoKey];
    [dataDic setObject:relJson forKey:kec_infoKey];
    [dataDic setObject:dateString forKey:kbuyTimeKey];
    [dataDic setObject:self.buyContratNumberTextField.text forKey:kbuyNoKey];
    //提交
    [self submitDataToServer:dataDic];
}
/* 判断图片是否上传成功*/
-(void)IsImageSuccess:(int ) index;
{
    if (isFail==YES) {
        return;
    }
    NSLog(@"updateNum==%d",updateNum);
    if ([[successArr objectAtIndex:index] isEqualToString:@"1"])
    {
        updateNum++;
    }
    else
    {
        [self saveDB];
        hud.hidden=YES;
        isFail=YES;
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"本地上传图片失败,请检查网络!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
        [alter show];
        alter.tag=111;
        return;
    }
    if(updateNum>=7)
    {
        updateNum=0;
        [self sumbit];
    }
}
/* 判断图片是否已经传成功*/
-(BOOL)isFromNet:(NSMutableArray *)arr
{
    for (int i=0; i<arr.count; i++)
    {
        NSLog(@"leng===%lu==",(unsigned long)[[arr objectAtIndex:i] length]);
        if ([[arr objectAtIndex:i] length]<52)
        {
            return YES;
        }
    }
    return NO;
}
/* 多线程异步图片*/
-(void)handBbImage
{
    if ([self isFromNet:identity_Arr])
    {
        DbToNetManager *identityManager=[[DbToNetManager alloc]init];
        [identityManager getImageArr:identityImage_Arr andTitleArr:identity_Arr  andNum:self.order_number];
        [identityManager HandSuccess:^(NSMutableArray *titleArr)
         {
            identity_Arr=titleArr;
            [successArr setObject:@"1" atIndexedSubscript:0];
            [self IsImageSuccess:0];
        }];
        [identityManager HandFail:^(NSString *errStr)
        {
            [successArr setObject:@"2" atIndexedSubscript:0];
            [self IsImageSuccess:0];
        }];
    }
    else
    {
        [successArr setObject:@"1" atIndexedSubscript:0];
        [self IsImageSuccess:0];
    }
    if ([self isFromNet:stduent_Arr])
    {
        DbToNetManager *studentManager=[[DbToNetManager alloc]init];
        [studentManager getImageArr:stduentImage_Arr andTitleArr:stduent_Arr andNum:self.order_number];
        [studentManager HandSuccess:^(NSMutableArray *titleArr)
        {
            stduent_Arr=titleArr;
            [successArr setObject:@"1" atIndexedSubscript:1];
            [self IsImageSuccess:1];
        }];
        [studentManager HandFail:^(NSString *errStr)
        {
            [successArr setObject:@"2" atIndexedSubscript:1];
            [self IsImageSuccess:1];
            
        }];
    }
    else
    {
        [successArr setObject:@"1" atIndexedSubscript:1];
        [self IsImageSuccess:1];
    }
    if ([self isFromNet:allpurpose_Arr])
    {
        DbToNetManager *allpurposeManager=[[DbToNetManager alloc]init];
        [allpurposeManager getImageArr:allpurposeImage_Arr andTitleArr:allpurpose_Arr andNum:self.order_number];
        [allpurposeManager HandSuccess:^(NSMutableArray *titleArr)
         {
            allpurpose_Arr=titleArr;
            [successArr setObject:@"1" atIndexedSubscript:2];
            [self IsImageSuccess:2];
        }];
        [allpurposeManager HandFail:^(NSString *errStr)
         {
            [successArr setObject:@"2" atIndexedSubscript:2];
            [self IsImageSuccess:2];
        }];
    }
    else
    {
        [successArr setObject:@"1" atIndexedSubscript:2];
        [self IsImageSuccess:2];
    }
    if ([self isFromNet:learn_Arr])
    {
        DbToNetManager *learnManager=[[DbToNetManager alloc]init];
        [learnManager getImageArr:learnImage_Arr andTitleArr:learn_Arr andNum:self.order_number];
        [learnManager HandSuccess:^(NSMutableArray *titleArr)
        {
            learn_Arr=titleArr;
            [successArr setObject:@"1" atIndexedSubscript:3];
            [self IsImageSuccess:3];
        }];
        [learnManager HandFail:^(NSString *errStr)
         {
            [successArr setObject:@"2" atIndexedSubscript:3];
            [self IsImageSuccess:3];
        }];
    }
    else
    {
        [successArr setObject:@"1" atIndexedSubscript:3];
        [self IsImageSuccess:3];
    }
    if ([self isFromNet:hand_Arr])
    {
        DbToNetManager *handManager=[[DbToNetManager alloc]init];
        [handManager getImageArr:handImage_Arr andTitleArr:hand_Arr andNum:self.order_number];
        [handManager HandSuccess:^(NSMutableArray *titleArr)
        {
            hand_Arr=titleArr;
            [successArr setObject:@"1" atIndexedSubscript:4];
            [self IsImageSuccess:4];
        }];
        [handManager HandFail:^(NSString *errStr)
        {
            [successArr setObject:@"2" atIndexedSubscript:4];
            [self IsImageSuccess:4];
        }];
    }
    else
    {
        [successArr setObject:@"1" atIndexedSubscript:4];
        [self IsImageSuccess:4];
    }
    if ([self isFromNet:contract_Arr])
    {
        DbToNetManager *contractManager=[[DbToNetManager alloc]init];
        [contractManager getImageArr:contractImage_Arr andTitleArr:contract_Arr andNum:self.order_number];
        [contractManager HandSuccess:^(NSMutableArray *titleArr)
        {
            contract_Arr=titleArr;
            [successArr setObject:@"1" atIndexedSubscript:5];
            [self IsImageSuccess:5];
        }];
        [contractManager HandFail:^(NSString *errStr)
         {
            [successArr setObject:@"2" atIndexedSubscript:5];
            [self IsImageSuccess:5];
        }];
    }
    else
    {
        [successArr setObject:@"1" atIndexedSubscript:5];
        [self IsImageSuccess:5];
    }
    if ([self isFromNet:other_Arr])
    {
        DbToNetManager *otherManager=[[DbToNetManager alloc]init];
        [otherManager getImageArr:otherImage_Arr andTitleArr:other_Arr andNum:self.order_number];
        [otherManager HandSuccess:^(NSMutableArray *titleArr)
         {
            other_Arr=titleArr;
            [successArr setObject:@"1" atIndexedSubscript:6];
            [self IsImageSuccess:6];
        }];
        [otherManager HandFail:^(NSString *errStr)
        {
            [successArr setObject:@"2" atIndexedSubscript:6];
            [self IsImageSuccess:6];
        }];
    }
    else
    {
        [successArr setObject:@"1" atIndexedSubscript:6];
        [self IsImageSuccess:6];
    }
    
}
/* 提交表单*/
-(void)submitDataToServer:(NSDictionary *)dic
{
    NSString *url=@"order/upload_info?";
    url=[NSString stringWithFormat:@"%@accesstoken=%@",url,[NSString getToken]];
    __block DetailViewController *blockSelf = self;
    [postDataServer postRequest:url path:nil parameter:dic];
    [postDataServer setDidFinish:^(DataService *serivice, NSDictionary *dic)
    {
        if ([((NSNumber *)[dic objectForKey:kcodeKey])isEqualToNumber:[NSNumber numberWithInt:0]])
        {
            [UIView showHUD:@"提交成功" andView:blockSelf.view andHUD:blockSelf.hud];
            // [blockSelf clearDb];
            [[DBManager instance] clearDb];
            blockSelf.isPost=YES;
            [blockSelf.hud hide:YES afterDelay:2];
            [blockSelf performSelector:@selector(goBackList) withObject:nil afterDelay:2];
            return;
        }
        NSLog(@"dic===%@",[dic objectForKey:kmessageKey]);
        [UIView showHUD:[dic objectForKey:kmessageKey]andView:blockSelf.self.view andHUD:blockSelf.hud];
        [blockSelf.hud hide:YES afterDelay:2];
    }];
    [postDataServer setDidFailed:^(DataService *serivice, NSError *error)
     {
        blockSelf.hud.labelText=@"提交失败,请检查网络!";
        [blockSelf.hud hide:YES afterDelay:2];
        
    }];
}
/* 获取联系人json*/
-(NSMutableArray *)getReL
{
    NSMutableArray *relArr=[[NSMutableArray alloc]init];
    NSMutableDictionary *fatherDic=[self getDicFromTextFieldName:self.fahterNameTextField.text andTel:self.fatherNumberTextField.text andRel:kfatherRel];
    [relArr addObject:fatherDic];
    NSMutableDictionary *motherDic=[self getDicFromTextFieldName:self.motherNameTextField.text andTel:self.motherNumberTextField.text andRel:kmotherRel];
    [relArr addObject:motherDic];
    NSMutableDictionary *teachDic=nil;
    if (self.teacherNumTextField.text!=nil)
    {
        teachDic=[self getDicFromTextFieldName:self.techerName andTel:self.teacherNumTextField.text andRel:kteacherRel];
        [relArr addObject:teachDic];
    }
    NSMutableDictionary *classDic=nil;
    if (self.classNumTextField.text!=nil)
    {
        classDic =[self getDicFromTextFieldName:self.className andTel:self.classNumTextField.text andRel:kclassRel];
        [relArr addObject:classDic];
    }
    NSMutableDictionary *otherDic=nil;
    if (self.otherNumTextField.text!=nil&&self.otherPersonTextField.text!=nil)
    {
        otherDic=[self getDicFromTextFieldName:self.otherPersonTextField.text andTel:self.otherNumTextField.text andRel:self.otherPersonTextField.text];
        [relArr addObject:otherDic];
    }else
    {
        [self addMessage:@"请确保其他联系人和对应的电话号码不能为空"];
    }
    return relArr;
}

-(NSMutableDictionary *)getDicFromTextFieldName:(NSString *)name andTel:(NSString *)tel andRel:(NSString *)rel
{
    NSMutableDictionary *relDic=[[NSMutableDictionary alloc]init];
    if (name==nil)
    {
        name=@"";
    }
    [relDic setValue:name forKey:knameKey];
    [relDic setValue:tel forKey:ktelKey];
    [relDic setValue:rel forKey:krelKey];
    return relDic;
}
/* 警告提示框*/
-(void)addMessage:(NSString *)message
{
    [UIView showHUD:message andView:self.view andHUD:hud];
    [hud hide:YES afterDelay:1];
}
/* 订单信息*/

- (IBAction)getInfoAction:(id)sender
{
    _scrollView.hidden=NO;
    goodView.hidden=YES;
    m_pWebView.hidden=YES;
    [self.infoBtn setSelected:YES];
    [self.goodBtn setSelected:NO];
    [self.lookBtn setSelected:NO];
    
}
/* 商品信息*/
- (IBAction)getGoodAction:(id)sender
{
    _scrollView.hidden=YES;
    goodView.hidden=NO;
    m_pWebView.hidden=YES;
    [self.infoBtn setSelected:NO];
    [self.goodBtn setSelected:YES];
    [self.lookBtn setSelected:NO];
    [goodView getDateFromServer];
    
}
/* 审核规则*/
- (IBAction)LookDemonAction:(id)sender
{
    [self.infoBtn setSelected:NO];
    [self.goodBtn setSelected:NO];
    [self.lookBtn setSelected:YES];
    m_pWebView.hidden=NO;
    _scrollView.hidden=YES;
    goodView.hidden=YES;
}

/* 放弃订单*/
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1002)
    {
        if (buttonIndex==1)
        {
            if ([self.order_status isEqualToString:kfailKey]==NO) {
                return;
            }
            if (giveUpDataSevice==nil)
            {
                giveUpDataSevice=[[DataService alloc]init];
            }
            NSString *url=@"order/cancel_order?";
            url=[NSString stringWithFormat:@"%@accesstoken=%@",url,[NSString getToken]];
            NSLog(@"==========%@",self.order_number);
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.order_number,korder_no,nil];
            [giveUpDataSevice postRequest:url path:nil parameter:dic];
            __block DetailViewController *blockSelf = self;
            [giveUpDataSevice setDidFinish:^(DataService *serivice, NSDictionary *dic)
            {
                NSLog(@"dic===%@",[dic objectForKey:kmessageKey]);
                if ([((NSNumber *)[dic objectForKey:kcodeKey])isEqualToNumber:[NSNumber numberWithInt:0]])
                {
                    [UIView showHUD:[dic objectForKey:kmessageKey]andView:blockSelf.view andHUD:blockSelf.hud];
                    //  hud.labelText=[dic objectForKey:kmessageKey];
                    [blockSelf.hud hide:YES afterDelay:1];
                    [blockSelf performSelector:@selector(hideDelayed) withObject:nil afterDelay:1];
                    
                    return;
                }
                [UIView showHUD:[dic objectForKey:kmessageKey]andView:blockSelf.view andHUD:blockSelf.hud];
                [blockSelf.hud hide:YES afterDelay:2];
                return;
                
            }];
            [giveUpDataSevice setDidFailed:^(DataService *serivice, NSError *error)
            {
                [UIView showHUD:@"网络不好" andView:blockSelf.view andHUD:blockSelf.hud];
                [blockSelf.hud hide:YES afterDelay:2];
            }];
            
        }
    }
    if (alertView.tag==111)
    {
        isFail=NO;
        updateNum=0;
        if (buttonIndex==1)
        {
            
            [self submitAction:nil];
        }
        else
        {
            //[self saveDB];
        }
    }
}

- (IBAction)GiveUpOrderListAction:(id)sender {
    
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"你确定取消订单吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alter.tag=1002;
    [alter show];
}
/* 本地数据读取*/
-(void)readDb
{
    [UIView showHUD:@"本地读取中" andView:self.view andHUD:hud];
    [[DBManager instance] setReadDB:^(DBModel *entity)
    {
        NSLog(@"%@",entity.dateDic);
        [hud hide:YES];
        [self addDb:entity.dateDic];
        [self addImage:entity.dateDic];
    }];
    
}
/* 本地数据读取 UI添加*/
-(void)addDb:(NSMutableDictionary *)dic
{
    if ([self.buyContratNumberTextField.text length]==0)
    {
        self.buyContratNumberTextField.text=[dic objectForKey:kbuyNoKey];
    }
    if ([[dic objectForKey:kbuyTimeKey] length]!=0)
    {
        dateString=[dic objectForKey:kbuyTimeKey];
        [self.dateBtn setTitle:[dic objectForKey:kbuyTimeKey]  forState:UIControlStateNormal];
    }
    if ([self.addressTextFiled.text length]==0)
    {
        self.addressTextFiled.text=[dic objectForKey:kaddressKey];
    }
    if ([self.fatherNumberTextField.text length]==0)
    {
        self.fatherNumberTextField.text=[dic objectForKey:kfatherNumKey];
    }
    if ([self.motherNumberTextField.text length]==0)
    {
        self.motherNumberTextField.text=[dic objectForKey:kmotherNumKey];
    }
    if ([self.teacherNumTextField.text length]==0)
    {
        self.teacherNumTextField.text=[dic objectForKey:kteacherNumKey];
    }
    if ([self.classNumTextField.text length]==0)
    {
        self.classNumTextField.text=[dic objectForKey:kclassNumKey];
    }
    if ([self.otherPersonTextField.text length]==0)
    {
        self.otherPersonTextField.text=[dic objectForKey:kotherNameKey];
    }
    if ([self.otherNumTextField.text length]==0)
    {
        self.otherNumTextField.text=[dic objectForKey:kotherNumKey];
    }
    if ([self.qqTextField.text length]==0)
    {
        self.qqTextField.text=[dic objectForKey:kqqKey];
    }
    if ([self.weixinTextField.text length]==0)
    {
        self.weixinTextField.text=[dic objectForKey:kwenxinKey];
    }
    if ([self.emailTextField.text length]==0)
    {
        self.emailTextField.text=[dic objectForKey:krenrenKey];
    }
    if ([self.remarkTextField.text length]==0)
    {
        self.remarkTextField.text=[dic objectForKey:knoteKey];
    }
    if ([self.fahterNameTextField.text length]==0)
    {
        self.fahterNameTextField.text=[dic objectForKey:kfatherNameKey];
    }
    if ([self.motherNameTextField.text length]==0)
    {
        self.motherNameTextField.text=[dic objectForKey:kmotherNameKey];
    }
}
/* 本地数据读取 保存*/
-(void)saveDB
{
    DBModel *saveStudent = [[DBModel alloc] init];
    saveStudent.order_no = self.order_number;
    saveStudent.dateDic=[[NSMutableDictionary alloc]init];
    [saveStudent.dateDic setObject:self.buyContratNumberTextField.text forKey:kbuyNoKey];
    [saveStudent.dateDic setObject:dateString forKey:kbuyTimeKey];
    [saveStudent.dateDic setObject:self.addressTextFiled.text forKey:kaddressKey];
    [saveStudent.dateDic setObject:self.fatherNumberTextField.text forKey:kfatherNumKey];
    [saveStudent.dateDic setObject:self.motherNumberTextField.text forKey:kmotherNumKey];
    [saveStudent.dateDic setObject:self.classNumTextField.text forKey:kclassNumKey];
    [saveStudent.dateDic setObject:self.teacherNumTextField.text forKey:kteacherNumKey];
    [saveStudent.dateDic setObject:self.otherPersonTextField.text forKey:kotherNameKey];
    [saveStudent.dateDic setObject:self.otherNumTextField.text forKey:kotherNumKey];
    [saveStudent.dateDic setObject:self.qqTextField.text forKey:kqqKey];
    [saveStudent.dateDic setObject:self.weixinTextField.text forKey:kwenxinKey];
    [saveStudent.dateDic setObject:self.emailTextField.text forKey:krenrenKey];
    [saveStudent.dateDic setObject:self.remarkTextField.text forKey:knoteKey];
    [saveStudent.dateDic setObject:self.motherNameTextField.text forKey:kmotherNameKey];
    [saveStudent.dateDic setObject:self.fahterNameTextField.text forKey:kfatherNameKey];
    if (identity_Arr.count==identityImage_Arr.count)
    {
        [saveStudent.dateDic setObject:[self dbImage:identity_Arr and:identityImage_Arr] forKey:kidentityKey];
    }
    if (stduent_Arr.count==stduentImage_Arr.count)
    {
        [saveStudent.dateDic setObject:[self dbImage:stduent_Arr and:stduentImage_Arr] forKey:kstduentKey];
    }
    if (allpurpose_Arr.count==allpurposeImage_Arr.count)
    {
        [saveStudent.dateDic setObject:[self dbImage:allpurpose_Arr and:allpurposeImage_Arr] forKey:kallpurposeKey];
    }
    if (learn_Arr.count==learnImage_Arr.count)
    {
        [saveStudent.dateDic setObject:[self dbImage:learn_Arr and:learnImage_Arr] forKey:klearnKey];
    }
    if (hand_Arr.count==handImage_Arr.count)
    {
        [saveStudent.dateDic setObject:[self dbImage:hand_Arr and:handImage_Arr] forKey:khandKey];
    }
    if (contract_Arr.count==contractImage_Arr.count)
    {
        [saveStudent.dateDic setObject:[self dbImage:contract_Arr and:contractImage_Arr] forKey:kcontractKey];
    }
    if (other_Arr.count==otherImage_Arr.count)
    {
        [saveStudent.dateDic setObject:[self dbImage:other_Arr and:otherImage_Arr] forKey:kotherKey];
    }
    [[DBManager instance]saveDB:saveStudent];
    
}
/* uiimage 关联信息*/
-(NSMutableDictionary *)dbImage:(NSMutableArray *)imageNameArr and:(NSMutableArray *)imageArr
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    if (imageNameArr!=nil)
    {
        [dic setObject:imageNameArr forKey:kImageNameArr];
    }
    if (imageArr!=nil)
    {
        [dic setObject:imageArr forKey:kImageArr];
    }
    return dic;
}
/* 返回 本地保存*/
- (IBAction)clickBtnAction:(id)sender
{
    if (isPost==NO)
    {
        [UIView showHUD:@"本地保存中" andView:self.view andHUD:hud];
        [[DBManager instance] setSavedDB:^(DBModel *entity)
        {
            [hud hide:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [self saveDB];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
