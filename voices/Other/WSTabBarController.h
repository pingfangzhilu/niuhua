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
#import "AutoScrollLabel.h"
#import "WSPlayTabViewController.h"
#import "IntervalSinceNow.h"

@interface WSTabBarController : UITabBarController<UITableViewDelegate,UITableViewDataSource,XMTrackPlayerDelegate>

{
    int VVVVVVV ;

   int indecxxx;
}
@property (nonatomic,strong)UIView *myView ;
@property (nonatomic,strong)UIImageView *HeadImageView;

@property (nonatomic,strong)XMTrack *track;


@property (nonatomic,strong)UIButton *NextBtn;

@property (nonatomic,strong)UIButton *PlayBtn;

@property (nonatomic,strong)UIButton *ListBtn;

@property (nonatomic,strong)UIProgressView *ProgressView;

@property (nonatomic,strong)UILabel *NameLabel;

@property (nonatomic,strong)UILabel *zhuanjiLabel;

@property (nonatomic,strong)NSArray *AllDataArray;


@property (nonatomic,strong)UIView *BackView;

@property (nonatomic,strong)UITableView *MianTableView;

@property (nonatomic,strong)NSString *nameStr;

@property (nonatomic,strong)NSString *MarkStr;

@property (nonatomic,strong)NSMutableArray *UpdateArray;

@property (nonatomic,strong)NSMutableArray *currentArray;

@property (nonatomic,strong)UILabel *BottomName;

@property (nonatomic,strong)UIView *BottomView;

@property (nonatomic,strong)UIView *BottomBackView;

@property (nonatomic,strong)UISlider *BottomSlider;

@property (nonatomic,strong)UILabel *BottomLabel;

@property (nonatomic,strong)UIButton *BottomBtn;

@property (nonatomic,strong)UIImageView *BottomImageV;

@property(nonatomic,strong)UIButton *markStringSele;

@property (nonatomic,strong)UIButton *BottomNextBtn;

@property(nonatomic,strong)UIButton *BottomUpBtn;

@property (nonatomic,assign)NSInteger PlayURLindex;




@property (nonatomic,strong)NSMutableArray *PlayUrlData;


@property (nonatomic,strong)UILabel *CurTimeLabel;

@property (nonatomic,strong)UILabel *MusicTimeLabel;


@property (nonatomic,strong)NSString *playCurtime;

@end
