//
//  AppConfig.h
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-12.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//
/* 配置文件*/
#ifndef QufenqiBD_AppConfig_h
#define QufenqiBD_AppConfig_h

#import <MessageUI/MessageUI.h>
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "DataService.h"
#import "UserModel.h"
#import "User.h"
#import "NSString+Token.h"
#import "OrderListModel.h"
#import "ListModel.h"
#import "SchoolModel.h"
#import "OrderCountModel.h"
#import "HeadView.h"
#import "UIDevice+Extension.h"
#import "PickImageView.h"
#import "DetailViewController.h"
#import "UIView+Tool.h"
#import <KeyboardManager/KeyboardManager.h>
#import "GoodInfoModel.h"
#import "ContractInfoModel.h"
#import "EcModel.h"
#import "More_RelModel.h"
#import "UIImageView+WebCache.h"
#import "UITextField+ChangeBorder.h"
#import "UIImage+FixOrientation.h"
#import "NSMutableArray+IsEqualToArray.h"
#import "DbToNetManager.h"




#define kImageViewTag 2000
#define kImageViewTagBg 3000
#define klistAddressKey        @"address"
#define korder_priceKey        @"order_price"
#define kgoods_nameKey         @"goods_name"
#define ktime_diffKey          @"time_diff"
#define klistKey               @"list"
#define kcountKey              @"count"
#define kschool_idKey          @"school_id"
#define kschool_nameKey        @"school_name"
#define korder_countKey        @"order_count"
#define korder_listKey         @"order_list"
#define kpriceKey              @"price"
#define kmobileKey             @"mobile"
#define korder_idKey           @"order_id"
#define kaccept_nameKey        @"accept_name"
#define korder_statusKey       @"order_status"
#define krelKey                @"rel"
#define ktelKey                @"tel"
#define knameKey               @"name"
#define kclickPhotoNameNotion  @"clickPhotoName"
#define korder_noteKey         @"order_note"
#define kwaitKey               @"wait"
#define kauditKey              @"audit"
#define kfailKey               @"fail"
#define kgoods_infoKey         @"goods_info"
#define korder_infoKey         @"order_info"
#define kcontract_infoKey      @"contract_info"
#define kdataKey               @"data"
#define kcodeKey               @"code"
#define karviDataKey           @"arviData"
#define kmessageKey            @"message"
#define kec_infoKey            @"ec_info"
#define kother_photoKey        @"other_photo"
#define kcontract_photoKey     @"contract_photo"
#define kdorm_photoKey         @"dorm_photo"
#define kchsi_photoKey         @"chsi_photo"
#define kschool_card_photoKey  @"school_card_photo"
#define kstudent_id_photoKey   @"student_id_photo"
#define kidcard_photoKey       @"idcard_photo"
#define kmore_relKey           @"more_rel"
#define kbuyNoKey              @"contract_no"
#define kbuyTimeKey            @"pay_time"
#define kaddressKey            @"addr"
#define kfatherNumKey          @"fatherNum"
#define kfatherNameKey         @"fatherName"
#define kmotherNumKey          @"motherNum"
#define kmotherNameKey         @"motherName"
#define kteacherNumKey         @"teacherNum"
#define kclassNumKey           @"classNum"
#define kotherNameKey          @"otherName"
#define kotherNumKey           @"otherNum"
#define kqqKey                 @"qq"
#define kwenxinKey             @"weixin"
#define krenrenKey             @"renren"
#define knoteKey               @"note"
#define kidentityKey           @"identity"
#define kstduentKey            @"stduent"
#define kallpurposeKey         @"allpurpose"
#define klearnKey              @"learn"
#define khandKey               @"hand"
#define kcontractKey           @"contract"
#define kotherKey              @"other"
#define kFailimageurlKey       @"Failimageurl"
#define kfailImageKey          @"failImage"
#define kcancelOrder           @"cancelOrder"
#define kloingMessage          @"正在加载"
#define korder_no              @"order_no"
#define kclassRel               @"同学"
#define kteacherRel             @"班主任"
#define kmotherRel              @"母子"
#define kfatherRel              @"父子"
#define IS_IOS_7 ([[UIDevice currentDevice] isDeviceSystemMajorVersion] >= 7)
#define kIOS7STATUSHEIGHT (IS_IOS_7?20:0)
#define kNavigationBar_HEIGHT (IS_IOS_7?64:44)
//
#define kServerIP             @"http://admin.fadongxi.com/mobile/"
#define kDownLoadImageIP @"http://admin.fadongxi.com/resources/ht/thumb/"

//#define kServerIP             @"http://test.buyadmin.fadongxi.com/mobile/"
//#define kDownLoadImageIP @"http://test.buyadmin.fadongxi.com/resources/ht/thumb/"
//#define kServerIP               @"http://192.168.1.10:7541/mobile/"  //IP
//#define kDownLoadImageIP        @"http://192.168.1.10:7541/mobile/base/img?pid="  //IP

#define kuserLogin              @"user/login?"
#define korderList              @"order/order_list?"
#define korderDetail            @"order/order_detail?"
#define kImageNameArr           @"imageNameArr"
#define kImageArr               @"imageArr"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//获取屏幕 宽度、高度
#define kSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kViewWidth CGRectGetWidth(self.view.frame)
#define KViewHeight CGRectGetHeight(self.view.frame)
#endif

