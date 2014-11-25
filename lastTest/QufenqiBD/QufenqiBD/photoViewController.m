//
//  photoViewController.m
//  QufenqiBD
//
//  Created by Yuyangdexue on 14-10-22.
//  Copyright (c) 2014年 qufenqi. All rights reserved.
//

#import "photoViewController.h"

@interface photoViewController ()
{
    UIImageView *imageView;
}

@end

@implementation photoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    imageView=[[UIImageView alloc]initWithImage:self.photoImage];
    
    if (self.photoImage.size.width>self.photoImage.size.height)
    {
        
        imageView.frame=CGRectMake(0, (kSCREEN_HEIGHT-kNavigationBar_HEIGHT)/2-((kSCREEN_WIDTH*self.photoImage.size.height)/self.photoImage.size.width)/2, kSCREEN_WIDTH, (kSCREEN_WIDTH*self.photoImage.size.height)/self.photoImage.size.width);
    }
    else
    {
        imageView.frame=CGRectMake((kSCREEN_WIDTH)/2-(((kSCREEN_HEIGHT-kNavigationBar_HEIGHT)*self.photoImage.size.width)/self.photoImage.size.height)/2,0, ((kSCREEN_HEIGHT-kNavigationBar_HEIGHT)*self.photoImage.size.width)/self.photoImage.size.height,kSCREEN_HEIGHT-kNavigationBar_HEIGHT);
    }
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 60, 30)];
    [rightBtn setTitle:@"旋转" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(scaGesture:)];
    [pinchRecognizer setDelegate:self];
    [self.view addGestureRecognizer:pinchRecognizer];
    
    
    
    
    //    imageView.userInteractionEnabled=YES;
    //    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    //    tap.numberOfTapsRequired=1;
    //    tap.numberOfTouchesRequired=1;
    //    [imageView addGestureRecognizer:tap];
    //
    
    [self.view  addSubview:imageView];
    
    // Do any additional setup after loading the view.
}
-(void)scaGesture:(id)sender {
    [self.view bringSubviewToFront:[(UIPinchGestureRecognizer*)sender view]];
    //当手指离开屏幕时,将lastscale设置为1.0
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded)
    {
        lastScale = 1.0;
        return;
    }
    
    CGFloat scale = 1.0 - (lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [[(UIPinchGestureRecognizer*)sender view]setTransform:newTransform];
    lastScale = [(UIPinchGestureRecognizer*)sender scale];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return ![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

-(void)tap
{
    static BOOL isFrist=true;
    if (isFrist)
    {
        if (self.photoImage.size.width>self.photoImage.size.height)
        {
            UIImage *image=nil;
            if (self.photoImage.imageOrientation==UIImageOrientationUp)
            {
                NSLog(@"1");
                image=[UIImage imageWithCGImage:self.photoImage.CGImage scale:1 orientation:UIImageOrientationRight];
            }
            if (self.photoImage.imageOrientation==UIImageOrientationDown)
            {
                NSLog(@"2");
                image=[UIImage imageWithCGImage:self.photoImage.CGImage scale:1 orientation:UIImageOrientationLeft];
                
            }
            if (self.photoImage.imageOrientation==UIImageOrientationLeft)
            {
                NSLog(@"3");
                image=[UIImage imageWithCGImage:self.photoImage.CGImage scale:1 orientation:UIImageOrientationDown];
                
            }
            if (self.photoImage.imageOrientation==UIImageOrientationRight)
            {
                NSLog(@"4");
                image=[UIImage imageWithCGImage:self.photoImage.CGImage scale:1 orientation:UIImageOrientationUp];
            }
            imageView.frame=CGRectMake((kSCREEN_WIDTH)/2-(((kSCREEN_HEIGHT-kNavigationBar_HEIGHT)*self.photoImage.size.height)/self.photoImage.size.width)/2,0,((kSCREEN_HEIGHT-kNavigationBar_HEIGHT)*self.photoImage.size.height)/self.photoImage.size.width,kSCREEN_HEIGHT-kNavigationBar_HEIGHT);
            imageView.image=image;
            
        }else
        {
            UIImage *image=nil;
            if (self.photoImage.imageOrientation==UIImageOrientationUp)
            {
                NSLog(@"1");
                image=[UIImage imageWithCGImage:self.photoImage.CGImage scale:1 orientation:UIImageOrientationRight];
            }
            if (self.photoImage.imageOrientation==UIImageOrientationDown)
            {
                NSLog(@"2");
                image=[UIImage imageWithCGImage:self.photoImage.CGImage scale:1 orientation:UIImageOrientationLeft];
                
            }
            if (self.photoImage.imageOrientation==UIImageOrientationLeft)
            {
                NSLog(@"3");
                image=[UIImage imageWithCGImage:self.photoImage.CGImage scale:1 orientation:UIImageOrientationDown];
                
            }
            if (self.photoImage.imageOrientation==UIImageOrientationRight)
            {
                NSLog(@"4");
                image=[UIImage imageWithCGImage:self.photoImage.CGImage scale:1 orientation:UIImageOrientationUp];
            }
            
            imageView.frame=CGRectMake(0, (kSCREEN_HEIGHT-kNavigationBar_HEIGHT)/2-((kSCREEN_WIDTH*self.photoImage.size.width)/self.photoImage.size.height)/2, kSCREEN_WIDTH, (kSCREEN_WIDTH*self.photoImage.size.width)/self.photoImage.size.height);
            imageView.image=image;
            
            
        }
        
        isFrist=false;
    }
    else
    {
        
        imageView.image=self.photoImage;
        if (self.photoImage.size.width>self.photoImage.size.height)
        {
            imageView.frame=CGRectMake(0, (kSCREEN_HEIGHT-kNavigationBar_HEIGHT)/2-((kSCREEN_WIDTH*self.photoImage.size.height)/self.photoImage.size.width)/2, kSCREEN_WIDTH, (kSCREEN_WIDTH*self.photoImage.size.height)/self.photoImage.size.width);
        }
        else
        {
            imageView.frame=CGRectMake((kSCREEN_WIDTH)/2-(((kSCREEN_HEIGHT-kNavigationBar_HEIGHT)*self.photoImage.size.width)/self.photoImage.size.height)/2,0, ((kSCREEN_HEIGHT-kNavigationBar_HEIGHT)*self.photoImage.size.width)/self.photoImage.size.height,kSCREEN_HEIGHT-kNavigationBar_HEIGHT);
        }
        isFrist=true;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
