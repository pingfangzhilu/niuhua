//
//  WSBaseViewController.m
//  WeiShang
//
//  Created by 曾赟 on 16/7/14.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "WSBaseViewController.h"
//#import "Reachability.h"
@interface WSBaseViewController ()
{
   MBProgressHUD* HUD;
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
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self.navigationController setToolbarHidden:YES animated:YES];
    //[[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[self navigationController] setNavigationBarHidden:YES animated:YES];
//    self.navigationController.navigationBarHidden = YES;
     self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
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

-(void)showHUB
{
    if(staticHUBCounter == 0)
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    staticHUBCounter ++;
}

-(void)hideHUB
{
    staticHUBCounter --;
    if(staticHUBCounter == 0)
        [MBProgressHUD hideHUDForView:self.view animated:YES];
}

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
