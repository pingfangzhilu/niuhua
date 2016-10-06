//
//  WSBaseViewController.h
//  WeiShang
//
//  Created by 曾赟 on 16/7/14.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#define kEditDelegateBtn @"postEditDelegate"
#define KBackBtn         @"backBtn"
#import "BMDefine.h"
#import "SDImageCache.h"
#import "MBProgressHUD.h"
#import "DisplayUtil.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"

#import "XMSDK.h"
@protocol ReloadxDelegate <NSObject>

- (void)netReloadx;

@end
@interface WSBaseViewController : UIViewController<XMTrackPlayerDelegate,XMLivePlayerDelegate>

@property(nonatomic, weak)id<ReloadxDelegate> reloadxDelegate;
/** 底部播放栏  */
@property (strong , nonatomic)UIView *BottomView;
/** 底部播放栏的图像  */
@property (strong,nonatomic)UIImageView *BottomHeadImageV;
/** 底部播放栏的列表按钮  */
@property (strong,nonatomic)UIButton *BottomListBtn;
/** 底部播放栏开关按钮  */
@property (strong,nonatomic)UIButton *BottomIsTureBtn;

/** 底部播放栏的下一首  */
@property (strong,nonatomic)UIButton *BottomNextBtn;
/** 底下播放数据源 */
@property (strong,nonatomic)NSArray *BottomArray;

@property (nonatomic,strong)XMTrack *track;

-(void)prompt:(NSString *)messageStr;

- (void)makeNavWithTitle:(NSString *)title;

- (void)showHUB;

- (void)hideHUB;

-(void)setupReloadPage;

-(void)removeReloadPage;



- (void)palyISPaly;



@end
