//
//  PickImageView.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-14.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "PickImageView.h"
#import "photoViewController.h"

@implementation PickImageView
{
    BOOL isUpLoad;
    
}
@synthesize imageArray;
@synthesize imageViewArray;
@synthesize imageViewBgArray;
@synthesize hud;
@synthesize viewController;
@synthesize LoadArray;
@synthesize deleteNum;


-(void)initView
{
    imageViewArray=[[NSMutableArray alloc]init];
    LoadArray=[[NSMutableArray alloc]init];
    imageArray=[[NSMutableArray alloc]init];
    imageViewBgArray=[[NSMutableArray alloc]init];
    button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    rect=CGRectMake(18, 20, 65, 65);
    button.frame=rect;
    [button addTarget:self action:@selector(addImageView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    dataDeleteService=[[DataService alloc]init];
    dataAddService=[[DataService alloc]init];
    isUpLoad=NO;
    
}
-(void)addImageView
{
    
    UIActionSheet *actionSheetTemp = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"相机",@"相册", nil];
    actionSheetTemp.tag=102;
    [actionSheetTemp showInView:self.viewController.view];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        photoImage= nil;
        photoImage= [editingInfo objectForKey:UIImagePickerControllerOriginalImage];
        
        [self performSelector:@selector(createImageView:)
                   withObject:photoImage
                   afterDelay:0.2];
         photoImage =[UIImage scale:photoImage toSize:CGSizeMake(640, (640*photoImage.size.height)/photoImage.size.width)];
    }];
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        photoImage= nil;
        if (photoImage==nil) {
            photoImage = [info objectForKey:UIImagePickerControllerOriginalImage];
          photoImage =[UIImage scale:photoImage toSize:CGSizeMake(640, (640*photoImage.size.height)/photoImage.size.width)];
        }
        [self performSelector:@selector(createImageView:)
                   withObject:photoImage
                   afterDelay:0.2];
        
        
        
    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)initDbView:(NSMutableArray *)arr andTitle:(NSMutableArray *)titleArr
{
    isNet=NO;
    for (int i=0; i<arr.count; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(18+75*i, 20, 65, 65)];
        UIImageView *imageViewbg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"white.png"]];
        imageViewbg.frame=CGRectMake(18+75*imageViewArray.count, 20, 65, 65);
        [self addSubview:imageViewbg];
        [imageViewBgArray addObject:imageViewbg];
        [LoadArray addObject:@"1"];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteImageView:)];
        tap.numberOfTapsRequired=1;
        tap.numberOfTouchesRequired=1;
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
        UIImage * image=(UIImage *)[arr objectAtIndex:i];
        imageView.image=image;
        if ((int)image.size.width==0||image.size.height==0) {
            return ;
        }
        CGRect rect1;
        if (image.size.width>image.size.height) {
            rect1=CGRectMake(18+75*i, 21+((65-((65*image.size.height)/image.size.width))/2), 65, (65*image.size.height)/image.size.width);
            
        }else
        {
            rect1=CGRectMake(18+75*i+((65-((65*image.size.width)/image.size.height))/2), 21, (65*image.size.width)/image.size.height, 64);
            
        }
        imageView.frame=rect1;
        
        [imageViewArray addObject:imageView];
        
    }
    for (int i=0; i<imageViewArray.count; i++) {
        UIImageView *imageView=[imageViewArray objectAtIndex:i];
        imageView.tag=i+kImageViewTag;
        
    }
    for (int i=0; i<imageViewBgArray.count; i++) {
        UIImageView *imageView=[imageViewBgArray objectAtIndex:i];
        imageView.tag=i+kImageViewTagBg;
        
    }
    
    button.frame=CGRectMake(18+75*arr.count, 20, 65, 65);
    imageArray=[NSMutableArray arrayWithArray:titleArr];
    NSMutableArray *arr1=[[NSMutableArray alloc]init];
    for ( int i=0; i<imageViewArray.count; i++) {
        [arr1 addObject:((UIImageView *)[imageViewArray objectAtIndex:i]).image];
    }
    [self.delegate addObjectView:self passImageArray:self.imageArray andPassImageArr:arr1];
}
-(void)initNetView:(NSMutableArray *)arr
{
    isNet=YES;
    for (int i=0; i<arr.count; i++) {
        NSLog(@"============%@",[NSString stringWithFormat:@"%@%@",kDownLoadImageIP,[arr objectAtIndex:i]]);
        CGRect rect1=CGRectMake(18+75*i, 20, 65, 65);
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:rect1];
        
        UIImageView *imageViewbg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"white.png"]];
        imageViewbg.frame=CGRectMake(18+75*imageViewArray.count, 20, 65, 65);
        [self addSubview:imageViewbg];
        [imageViewBgArray addObject:imageViewbg];
        [LoadArray addObject:@"1"];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteImageView:)];
        tap.numberOfTapsRequired=1;
        tap.numberOfTouchesRequired=1;
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kDownLoadImageIP,[arr objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"white.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if ((int)image.size.width==0||image.size.height==0) {
                return ;
            }
            CGRect rect1;
            if (image.size.width>image.size.height) {
                rect1=CGRectMake(18+75*i, 21+((65-((65*image.size.height)/image.size.width))/2), 65, (65*image.size.height)/image.size.width);
                
            }else
            {
                rect1=CGRectMake(18+75*i+((65-((65*image.size.width)/image.size.height))/2), 21, (65*image.size.width)/image.size.height, 64);
                
            }
            imageView.frame=rect1;
            
            
        }];
        [imageViewArray addObject:imageView];
        
    }
    for (int i=0; i<imageViewArray.count; i++) {
        UIImageView *imageView=[imageViewArray objectAtIndex:i];
        imageView.tag=i+kImageViewTag;
        
    }
    for (int i=0; i<imageViewBgArray.count; i++) {
        UIImageView *imageView=[imageViewBgArray objectAtIndex:i];
        imageView.tag=i+kImageViewTagBg;
        
    }
    button.frame=CGRectMake(18+75*arr.count, 20, 65, 65);
    imageArray=[NSMutableArray arrayWithArray:arr];
    NSMutableArray *arr1=[[NSMutableArray alloc]init];
    for ( int i=0; i<imageViewArray.count; i++) {
        [arr1 addObject:((UIImageView *)[imageViewArray objectAtIndex:i]).image];
    }
    [self.delegate addObjectView:self passImageArray:self.imageArray andPassImageArr:arr1];
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==102) {
        if (buttonIndex==0) {
            [self removeUI];
        }
    }
}
-(void)updateUI
{
    for (int i=0; i<imageViewArray.count; i++) {
        
        UIImageView *imageView2=(UIImageView *)[self viewWithTag:i+kImageViewTag];
        if (i==deleteNum) {
            [imageView2 removeFromSuperview];
        }
        if (i>deleteNum) {
            imageView2.frame=CGRectMake(18+75*(i-1),20 , 65, 65);
        }
    }
    for (int i=0; i<imageViewBgArray.count; i++) {
        UIImageView *imageView2=(UIImageView *)[self viewWithTag:i+kImageViewTagBg];
        if (i==deleteNum) {
            [imageView2 removeFromSuperview];
        }
        if (i>deleteNum) {
            imageView2.frame=CGRectMake(18+75*(i-1),20 , 65, 65);
        }
    }
    [imageViewArray removeObjectAtIndex:deleteNum];
    [imageViewBgArray removeObjectAtIndex:deleteNum];
    for (int i=0; i<imageViewArray.count; i++) {
        UIImageView *imageView=[imageViewArray objectAtIndex:i];
        imageView.tag=i+kImageViewTag;
        //最后的图片image
    }
    for (int i=0; i<imageViewBgArray.count; i++) {
        UIImageView *imageView=[imageViewBgArray objectAtIndex:i];
        imageView.tag=i+kImageViewTagBg;
        //最后的图片image
    }
    [LoadArray removeObjectAtIndex:deleteNum];
    button.frame=CGRectMake(18+75*(imageViewArray.count),20 , 65, 65);
    
    
}
-(void)deletePhotoFromServer
{
    if (isNet==NO) {
        [self.imageArray removeObjectAtIndex:self.deleteNum];
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        for ( int i=0; i<imageViewArray.count; i++) {
            [arr addObject:((UIImageView *)[imageViewArray objectAtIndex:i]).image];
        }
        [self.delegate addObjectView:self passImageArray:self.imageArray andPassImageArr:arr];

    }else
    {
    ///delete_photo?accesstoken=GGG3424JHJ24&photo_path=图片地址url_encode编码
    NSString * url =[NSString stringWithFormat:@"order/delete_photo?accesstoken=%@&order_no=%@&photo_path=%@",[NSString getToken],self.order_num,[imageArray objectAtIndex: deleteNum]];
    [dataDeleteService requestGetWithUrl:url];
    __block  PickImageView *  blockSelf=self;
    [dataDeleteService setDidFinish:^(DataService *serivice, NSDictionary *dic) {
        if ([(NSNumber *)[dic objectForKey:kcodeKey] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            [blockSelf.imageArray removeObjectAtIndex:blockSelf.deleteNum];
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            for ( int i=0; i<blockSelf.imageViewArray.count; i++) {
                [arr addObject:((UIImageView *)[blockSelf.imageViewArray objectAtIndex:i]).image];
            }
            [blockSelf.delegate addObjectView:blockSelf passImageArray:blockSelf.imageArray andPassImageArr:arr];
            
        }
        else
        {
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            for ( int i=0; i<blockSelf.imageViewArray.count; i++) {
                [arr addObject:((UIImageView *)[blockSelf.imageViewArray objectAtIndex:i]).image];
            }
            [blockSelf.delegate addObjectView:blockSelf passImageArray:blockSelf.imageArray andPassImageArr:arr];
            
        }
        
    }];
    [dataDeleteService setDidFailed:^(DataService *serivice, NSError *error) {
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        for ( int i=0; i<blockSelf.imageViewArray.count; i++) {
            [arr addObject:((UIImageView *)[blockSelf.imageViewArray objectAtIndex:i]).image];
        }
        [blockSelf.delegate addObjectView:blockSelf passImageArray:blockSelf.imageArray andPassImageArr:arr];
    }];
    }
    
}
-(void)upLoadFile:(NSData *)data
{
    
    if (self.imageViewArray.count!=0) {
        [self.LoadArray removeObjectAtIndex:self.imageViewArray.count-1];

    }
    [self.LoadArray addObject:@"1"];
    [self.imageArray addObject:kFailimageurlKey];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    for ( int i=0; i<self.imageViewArray.count; i++) {
        [arr addObject:((UIImageView *)[self.imageViewArray objectAtIndex:i]).image];
    }
    [self.delegate addObjectView:self  passImageArray:self.imageArray andPassImageArr:arr];
//    NSString *urlStr=[NSString stringWithFormat:@"order/upload_file?accesstoken=%@&order_no=%@",[NSString getToken],self.order_num];
//    [dataAddService upImageFileData:urlStr imageData:data andDic:nil];
//    __block  PickImageView *  blockSelf=self;
//    [dataAddService  setDidFinish:^(DataService *serivice, NSDictionary *dic) {
//        if ([(NSNumber *)[dic objectForKey:kcodeKey] isEqualToNumber:[NSNumber numberWithInt:0]]) {
//            [blockSelf.LoadArray removeObjectAtIndex:blockSelf.imageViewArray.count-1];
//            [blockSelf.LoadArray addObject:@"1"];
//            NSString *dataStr=[dic objectForKey:kdataKey];
//            [blockSelf.imageArray addObject:dataStr];
//            NSMutableArray *arr=[[NSMutableArray alloc]init];
//            for ( int i=0; i<blockSelf.imageViewArray.count; i++) {
//                [arr addObject:((UIImageView *)[blockSelf.imageViewArray objectAtIndex:i]).image];
//            }
//            [blockSelf.delegate addObjectView:blockSelf  passImageArray:blockSelf.imageArray andPassImageArr:arr];
//            
//        }
//        else
//        {
//            NSMutableArray *arr=[[NSMutableArray alloc]init];
//            for ( int i=0; i<blockSelf.imageViewArray.count; i++) {
//                [arr addObject:((UIImageView *)[blockSelf.imageViewArray objectAtIndex:i]).image];
//            }
//            [blockSelf.delegate addObjectView:blockSelf  passImageArray:blockSelf.imageArray andPassImageArr:arr];
//            //            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"图片上传失败" delegate:blockSelf cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
//            //            alter.tag=102;
//            //            [alter  show ];
//            
//        }
//        
//    }];
//    [dataAddService setDidFailed:^(DataService *serivice, NSError *error) {
//        NSMutableArray *arr=[[NSMutableArray alloc]init];
//        for ( int i=0; i<blockSelf.imageViewArray.count; i++) {
//            [arr addObject:((UIImageView *)[blockSelf.imageViewArray objectAtIndex:i]).image];
//            [blockSelf.delegate addObjectView:blockSelf  passImageArray:blockSelf.imageArray andPassImageArr:arr];
//        }
//        
//    }];
    
}
-(void)upLoadUI
{
    CGRect rect1;
    if (photoImage.size.width>photoImage.size.height) {
        rect1=CGRectMake(18+75*imageViewArray.count, 21+((65-((65*photoImage.size.height)/photoImage.size.width))/2), 65, (65*photoImage.size.height)/photoImage.size.width);
        
    }else
    {
        rect1=CGRectMake(18+75*imageViewArray.count+((65-((65*photoImage.size.width)/photoImage.size.height))/2), 21, (65*photoImage.size.width)/photoImage.size.height, 64);
        
    }
    UIImageView *imageViewbg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"white.png"]];
    imageViewbg.frame=CGRectMake(18+75*imageViewArray.count, 20, 65, 65);
    [self addSubview:imageViewbg];
    [imageViewBgArray addObject:imageViewbg];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:rect1];
    imageView.image=photoImage;
    imageView.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteImageView:)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    imageView.userInteractionEnabled=YES;
    [imageView addGestureRecognizer:tap];
    [self addSubview:imageView];
    button.frame=CGRectMake(18+75*(imageViewArray.count+1), 20, 65, 65);
    [imageViewArray addObject:imageView];
    for (int i=0; i<imageViewArray.count; i++) {
        UIImageView *imageView=[imageViewArray objectAtIndex:i];
        imageView.tag=i+kImageViewTag;
    }
    for (int i=0; i<imageViewBgArray.count; i++) {
        UIImageView *imageView=[imageViewBgArray objectAtIndex:i];
        imageView.tag=i+kImageViewTagBg;
    }
    [LoadArray addObject:@"0"];
    
    
    
}
-(void)removeUI
{
    for (int i=0; i<imageViewArray.count; i++) {
        UIImageView *imageView=[imageViewArray objectAtIndex:i];
        imageView.tag=i+kImageViewTag;
    }
    for (int i=0; i<imageViewBgArray.count; i++) {
        UIImageView *imageView=[imageViewBgArray objectAtIndex:i];
        imageView.tag=i+kImageViewTagBg;
    }
    
    UIImageView *imageView=(UIImageView *)[self viewWithTag:imageViewArray.count-1+kImageViewTag];
    [imageView removeFromSuperview];
    [LoadArray removeObjectAtIndex:imageViewArray.count-1];
    UIImageView *imageView1=(UIImageView *)[self viewWithTag:imageViewBgArray.count-1+kImageViewTagBg];
    [imageView removeFromSuperview];
    [imageView1 removeFromSuperview];
    [imageViewBgArray removeObjectAtIndex:imageViewBgArray.count-1];
    [imageViewArray removeObjectAtIndex:imageViewArray.count-1];
    for (int i=0; i<imageViewArray.count; i++) {
        UIImageView *imageView=[imageViewArray objectAtIndex:i];
        imageView.tag=i+kImageViewTag;
    }
    for (int i=0; i<imageViewBgArray.count; i++) {
        UIImageView *imageView=[imageViewBgArray objectAtIndex:i];
        imageView.tag=i+kImageViewTagBg;
    }
    
    button.frame=CGRectMake(18+75*(imageViewArray.count), 20, 65, 65);
    
}
-(void)createImageView:(UIImage *)image
{
    imageData=nil;
    imageData=UIImageJPEGRepresentation([image fixOrientation], 0.5);
    [self upLoadUI];
    [self upLoadFile:imageData];
    
}


-(void)deleteImageView:(UITapGestureRecognizer *)tap
{
    //int tag=imageView.tag;
    UIView *v = (UIView *)[tap view];
    deleteNum=v.tag-kImageViewTag;
    
    UIActionSheet *actionSheetTemp = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:@"删除图片"
                                                        otherButtonTitles:@"浏览", nil];
    actionSheetTemp.tag=101;
    [actionSheetTemp showInView:self.viewController.view];
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==101) {
        if (buttonIndex==0) {
            if ([[LoadArray objectAtIndex:deleteNum] isEqualToString:@"0"]) {
                return;
            }
            [self updateUI];
            [self deletePhotoFromServer];
            
        }else if (buttonIndex==1)
        {
            photoViewController *vc=[[photoViewController alloc]init];
            vc.photoImage=((UIImageView *)[imageViewArray objectAtIndex:deleteNum]).image;
            [self.viewController.navigationController pushViewController:vc animated:YES];
            
        }
        
    }else if (actionSheet.tag==102)
        
    {
        if (buttonIndex==0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kclickPhotoNameNotion object:@"1"];
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = NO;
            picker.sourceType = sourceType;
            [self.viewController presentViewController:picker animated:YES completion:nil];
            
        }
        else if (buttonIndex==1)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kclickPhotoNameNotion object:@"1"];
            UIImagePickerControllerSourceType  sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //相片库
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = NO;
            picker.sourceType = sourceType;
            [self.viewController presentViewController:picker animated:YES completion:nil];
            
        }
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
