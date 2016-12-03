//
//  LeftViewController.h
//  SlideMenuControllerOC
//
//  Created by ChipSea on 16/2/27.
//  Copyright © 2016年 pluto-y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "RecommSecondTableViewCell.h"
#import "smartconfig.hpp"
#import "MianLeftViewCell.h"
#import "XMSDK.h"
#import "DetailsRecommendViewController.h"

typedef enum : NSInteger{
    LeftMenuMain = 0,
    LeftMenuSwift,
    LeftMenuJava,
    LeftMenuGo,
    LeftMenuNonMenu
} LeftMenu;

@protocol LeftMenuProtocol <NSObject>

@required
-(void)changeViewController:(LeftMenu) menu;

@end

@interface LeftViewController : UIViewController<LeftMenuProtocol, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

//@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong ,nonatomic)UIView *WhiteView;

@property (strong ,nonatomic)UIView *BackView;

@property (nonatomic,strong)UITextField  *wifiMima;

@property (nonatomic,strong)UILabel *tishiLabel;


@property (strong ,nonatomic)UITableView *tableView;
@property (retain, nonatomic) NSArray *menus;
@property (retain, nonatomic) UIViewController *mainViewControler;

@property (nonatomic,strong) NSArray *DataArray;

@property(nonatomic,strong) UISlider *slider;

@property (nonatomic,strong)NSMutableArray *AllDataArray;


@property (nonatomic,strong)NSString *wifiName;

@property (nonatomic,strong)UILabel *WifiBtn;
//@property (retain, nonatomic) UIViewController *swiftViewController;
//@property (retain, nonatomic) UIViewController *javaViewController;
//@property (retain, nonatomic) UIViewController *goViewController;
//@property (retain, nonatomic) UIViewController *nonMenuViewController;
//@property (retain, nonatomic) ImageHeaderView *imageHeaderView;

@property (nonatomic,strong)NSString *power;

@property (nonatomic,strong)NSString *powerData;

@property (nonatomic,strong)NSString *lockState;


@end
