//
//  WSBaseViewController.m
//  WeiShang
//
//  Created by 曾赟 on 16/7/14.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "WSBaseViewController.h"

#import "Interface.h"
//#import "Reachability.h"
//WSBaseViewController *OCP=nil ;
@interface WSBaseViewController ()
{
//   MBProgressHUD* HUD;
    int staticHUBCounter;
    UIView *loadPageView;
    UIImageView *netImg;
    UILabel *tipLabel;
    UIButton *reloadBt;
}
@end

@implementation WSBaseViewController

-(id)init
{
    if (![super init])
        return nil;
    
    staticHUBCounter = 0;
    
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    
    NSLog(@"完蛋了");

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self.navigationController setToolbarHidden:YES animated:YES];
    //[[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    NSLog(@"BottomArray%lu",(unsigned long)self.BottomArray.count);
   

}

- (void)BottomViewUI
{
    XMSDKPlayer *player = [XMSDKPlayer sharedPlayer];
    
    [player setAutoNexTrack:YES];
    player.trackPlayDelegate = self;
    player.livePlayDelegate = self;
    [[XMSDKPlayer sharedPlayer] setVolume:0.5];
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    self.BottomView =[[UIView alloc]init];
    self.BottomView.backgroundColor =[UIColor grayColor];
    [currentWindow addSubview:self.BottomView];
    
    [self.BottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(currentWindow.mas_left);
        make.right.equalTo(currentWindow.mas_right);
        make.bottom.equalTo(currentWindow.mas_bottom);
        make.height.equalTo(@50);
        
        
        
    }];

    self.BottomHeadImageV =[[UIImageView alloc]init];
    
    self.BottomHeadImageV.image =[UIImage imageNamed:@"placeholder_disk"];
    
    [self.BottomView addSubview:self.BottomHeadImageV];
    
    [self.BottomHeadImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BottomView.mas_left);
//        make.height.equalTo(@50);
        make.top.equalTo(self.BottomView.mas_top);
        make.bottom.equalTo(self.BottomView.mas_bottom);
        make.width.equalTo(@70);
        
        
        
    }];
    
    
    self.BottomNextBtn =[[UIButton alloc]init];
    
    [self.BottomNextBtn setImage:[UIImage imageNamed:@"playbar_btn_next"] forState:UIControlStateNormal];
     [self.BottomNextBtn addTarget:self action:@selector(playNextTrack) forControlEvents:UIControlEventTouchUpInside];
    [self.BottomView addSubview:self.BottomNextBtn];
    
    [self.BottomNextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@50);
        make.top.equalTo(self.BottomView.mas_top);
        make.bottom.equalTo(self.BottomView.mas_bottom);
        make.right.equalTo(self.BottomView.mas_right);
        
        
    }];
    
    
    
    
    self.BottomIsTureBtn =[[UIButton alloc]init];
    
    [self.BottomIsTureBtn setImage:[UIImage imageNamed:@"play_btn"] forState:UIControlStateNormal];
     [self.BottomIsTureBtn addTarget:self action:@selector(playxxx) forControlEvents:UIControlEventTouchUpInside];
    [self.BottomView addSubview:self.BottomIsTureBtn];
    
    [self.BottomIsTureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@40);
        make.top.equalTo(self.BottomView.mas_top);
        make.bottom.equalTo(self.BottomView.mas_bottom);
        make.right.equalTo(self.BottomNextBtn.mas_left);
    }];
    
    
    
}



- (void)playxxx
{
 if(self.BottomArray.count>0){

     if (!self.BottomIsTureBtn.selected) {
        
         [self.BottomIsTureBtn setImage:[UIImage imageNamed:@"pause_btn"] forState:UIControlStateNormal];
         [[XMSDKPlayer sharedPlayer] setPlayMode:XMSDKPlayModeTrack];
         [[XMSDKPlayer sharedPlayer] setTrackPlayMode:XMTrackPlayerModeList];
         [[XMSDKPlayer sharedPlayer] playWithTrack:self.track playlist:self.BottomArray];
         
     }
     else
     {
      [self.BottomIsTureBtn setImage:[UIImage imageNamed:@"play_btn"] forState:UIControlStateNormal];
     [[XMSDKPlayer sharedPlayer] pauseTrackPlay];
     
     
     }
     
     self.BottomIsTureBtn.selected =!self.BottomIsTureBtn.selected;
     
 }
    else
    {
        NSLog(@"323333");
    
    }
    
}
- (void)palyISPaly
{

    [self PalyXXXXpALY];
}

- (void)PalyXXXXpALY
{
 [self.BottomIsTureBtn setImage:[UIImage imageNamed:@"pause_btn"] forState:UIControlStateNormal];
    self.BottomIsTureBtn.selected =YES;
    [[XMSDKPlayer sharedPlayer] setPlayMode:XMSDKPlayModeTrack];
    [[XMSDKPlayer sharedPlayer] setTrackPlayMode:XMTrackPlayerModeList];
    [[XMSDKPlayer sharedPlayer] playWithTrack:self.track playlist:self.BottomArray];

}




- (void)playNextTrack
{
    if(self.BottomArray.count>0){
        
        [[XMSDKPlayer sharedPlayer] playNextTrack];
        
    }
else
{
NSLog(@"323333kkkkkk");
}
 

}

- (BOOL)XMTrackPlayerShouldContinueNextTrackWhenFailed:(XMTrack *)track
{
    return NO;
}

//void ocCallBack(int type,char *msg,int size)
//{
//    //    printf("msg = %s\n",msg);
//    
//   [OCP ocCallMsg:msg];
//}
//
//- (void)ocCallMsg:(char *)msg
//{
//    Player_t * play = GetPlayer();
//    printf("play->playState = %d\n",play->playState);
//    Sysdata_t * sdata = GetSysdata();
//    NSLog(@"%d",sdata->lockState);
//    
//}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [[self navigationController] setNavigationBarHidden:YES animated:YES];
//    self.navigationController.navigationBarHidden = YES;
    
    
//    OCP =self;
     self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
   
   

    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//         nativeInitSystem(ocCallBack);
//    });

//    [self BottomViewUI];
    
    
    
//    Reachability *CurReach = [Reachability reachabilityForInternetConnection];
//    
//    switch ([CurReach currentReachabilityStatus]) {
//            
//        case NotReachable://没有网络
//            
//        {
//            [self prompt:@"请检查网络连接"];
//            //添加你需要的操作
//            
//            break;
//            
//        }
//            
//        case ReachableViaWiFi://有wifi
//            
//        {//添加你需要的操作
//            
//            break;
//            
//        }
//            
//        case ReachableViaWWAN://有3G
//            
//        {
//            
//            //添加你需要的操作
//            
//            
//            break;
//            
//        }
//            
//        default:
//            
//            break;
//    }
    // Do any additional setup after loading the view.
}
//提示信息
-(void)prompt:(NSString *)messageStr{
    UIAlertView *alert8 = [[UIAlertView alloc] initWithTitle:nil message:messageStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert8 show];
    [self.view endEditing:YES];
}
- (void)makeNavWithTitle:(NSString *)title
{
    UILabel *centerLab = [[UILabel alloc] init];
    centerLab.frame = CGRectMake(0, 20, DEF_FRAME_MAX_X(self.view), 44);
    centerLab.text=title;
    centerLab.textAlignment=NSTextAlignmentCenter;
    centerLab.font = [UIFont systemFontOfSize:15];
    centerLab.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:centerLab];
    
    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNavBtn.frame = CGRectMake(10, 22, 40, 40);
    leftNavBtn.tag = 300;
    [leftNavBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftNavBtn addTarget:self action:@selector(leftNavBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftNavBtn];
    
}

- (void)leftNavBtnDown
{
    [self.navigationController popViewControllerAnimated:YES];
}

//-(void)showHUB
//{
//    if(staticHUBCounter == 0)
////        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    
//    staticHUBCounter ++;
//}
//
//-(void)hideHUB
//{
//    staticHUBCounter --;
//    if(staticHUBCounter == 0)
////        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        
//}

-(void)setupReloadPage
{
    if (loadPageView == nil) {
        loadPageView = [[UIView alloc] init];
        loadPageView.backgroundColor = [DisplayUtil hexStringToColor:@"#f2f2f2"];
        [self.view addSubview:loadPageView];
        [loadPageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(loadPageView.superview.mas_top);
            make.bottom.equalTo(loadPageView.superview.mas_bottom);
            make.left.equalTo(loadPageView.superview.mas_left);
            make.right.equalTo(loadPageView.superview.mas_right);
        }];
        
        tipLabel = [[UILabel alloc] init];
        tipLabel.text = @"没有网络连接,无法获取内容,请检查网络连接后重试";
        tipLabel.font = [UIFont systemFontOfSize:12];
        tipLabel.textColor = [DisplayUtil hexStringToColor:@"#666666"];
        [loadPageView addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(tipLabel.superview.mas_centerX);
            make.centerY.equalTo(tipLabel.superview.mas_centerY);
        }];
        
        netImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"netnull"]];
        [loadPageView addSubview:netImg];
        [netImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@90);
            make.height.equalTo(@90);
            make.bottom.equalTo(tipLabel.mas_top).with.offset(-23);
            make.centerX.equalTo(netImg.superview.mas_centerX);
        }];
        
        reloadBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [reloadBt setTitle:@"重新加载" forState:UIControlStateNormal];
        reloadBt.titleLabel.font = [UIFont systemFontOfSize:15];
        [reloadBt setBackgroundColor:[UIColor clearColor]];
        reloadBt.layer.cornerRadius = 5;
        reloadBt.layer.borderWidth = 1;
        reloadBt.layer.borderColor = [DisplayUtil hexStringToColor:@"#666666"].CGColor;
        [reloadBt setTitleColor:[DisplayUtil hexStringToColor:@"#666666"] forState:UIControlStateNormal];
        [reloadBt addTarget:self action:@selector(reloadClick) forControlEvents:UIControlEventTouchUpInside];
        [loadPageView addSubview:reloadBt];
        [reloadBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@84);
            make.height.equalTo(@27);
            make.centerX.equalTo(reloadBt.superview.mas_centerX);
            make.top.equalTo(tipLabel.mas_bottom).with.offset(23);
        }];
    }
    
}

- (void)reloadClick
{
    [self.reloadxDelegate netReloadx];
}

-(void)removeReloadPage
{
    loadPageView.hidden = YES;
    //    [loadPageView removeFromSuperview];
}

@end
