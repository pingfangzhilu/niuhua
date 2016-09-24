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

@protocol ReloadxDelegate <NSObject>

- (void)netReloadx;

@end
@interface WSBaseViewController : UIViewController

@property(nonatomic, weak)id<ReloadxDelegate> reloadxDelegate;

-(void)prompt:(NSString *)messageStr;

- (void)makeNavWithTitle:(NSString *)title;

- (void)showHUB;

- (void)hideHUB;

-(void)setupReloadPage;

-(void)removeReloadPage;

@end
