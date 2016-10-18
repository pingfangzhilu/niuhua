//
//  WSTabBarController.h
//  voices
//
//  Created by pc on 16/10/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewController.h"
#import "ExSlideMenuController.h"
#import "Masonry.h"
#import "DisplayUtil.h"
#import "MainListTabBarViewcell.h"
@interface WSTabBarController : UITabBarController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *myView ;
@property (nonatomic,strong)UIImageView *HeadImageView;




@property (nonatomic,strong)UIButton *NextBtn;

@property (nonatomic,strong)UIButton *PlayBtn;

@property (nonatomic,strong)UIButton *ListBtn;



@property (nonatomic,strong)UILabel *NameLabel;

@property (nonatomic,strong)UILabel *zhuanjiLabel;

@property (nonatomic,strong)NSMutableArray *AllDataArray;


@property (nonatomic,strong)UIView *BackView;

@property (nonatomic,strong)UITableView *MianTableView;

@end
