//
//  AppDelegate.m
//  voices
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "XMReqMgr.h"
#import "MainViewController.h"
#import "Masonry.h"
#import "LeftViewController.h"
#import "WSTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [[XMReqMgr sharedInstance] registerXMReqInfoWithKey:@"aa92815ea48d7f6658b0d8225d20e7c4" appSecret:@"249bcd84bce6d1b16218b0c92e34b6b8"] ;
    
   
    WSTabBarController *sdkDemoViewController =[[WSTabBarController alloc]init];
//   UINavigationController  *NAV =[[UINavigationController alloc]initWithRootViewController:sdkDemoViewController];
//    self.window.rootViewController =sdkDemoViewController;
//
   MainViewController *sdkDemo = [[MainViewController alloc]init];
//    
//    UINavigationController *navConttroller = [[UINavigationController alloc] initWithRootViewController:sdkDemoViewController];
//   
//    
   LeftViewController  *leftViewController =[[LeftViewController alloc]init];
    
 leftViewController.mainViewControler = sdkDemoViewController;
    ExSlideMenuController *slideMenuController = [[ExSlideMenuController alloc] initWithMainViewController:sdkDemoViewController leftMenuViewController:leftViewController rightMenuViewController:nil];
    slideMenuController.automaticallyAdjustsScrollViewInsets = YES;
    slideMenuController.delegate = sdkDemo;
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = slideMenuController;
////
//   self.window.rootViewController = navConttroller;
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        //        self.internetstatus  = status;
        
        if (status == 0) {
            
            [SVProgressHUD showErrorWithStatus:@"无网咯,请检查网咯"];
        }
        else
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"wangloLoadDta" object:nil];
            
//            [self tuijianLaod];
//            [self LoadData];
        }
        
    }];
    
//    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}








- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        //        self.internetstatus  = status;
        
        if (status == 0) {
            
            [SVProgressHUD showErrorWithStatus:@"无网咯,请检查网咯"];
        }
        else
        {
            
              [[NSNotificationCenter defaultCenter]postNotificationName:@"wangloLoadDta" object:nil];
            //            [self tuijianLaod];
            //            [self LoadData];
        }
        
    }];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[XMReqMgr sharedInstance] closeXMReqMgr];
}

@end
