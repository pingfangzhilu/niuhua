//
//  DetailsRecommendViewController.h
//  voices
//
//  Created by pc on 16/10/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WSBaseViewController.h"
#import "MJRefresh.h"
#import "XMSDK.h"
#import "RecommeTableViewCell.h"
#import "ClassDetailTableViewCell.h"
#import "IntervalSinceNow.h"

#import "RecommJieSTableViewCell.h"
#import "RecommHeadImageVTableViewCell.h"
#import "RemarksTableViewCell.h"
#import "RemarksCellHeightModel.h"
#import "PlayingViewController.h"

#import "RecommSecondTableViewCell.h"
#import "RecommOneLabelTableViewCell.h"


#include "Interface.h"

#import "WSTabBarController.h"

@interface DetailsRecommendViewController : WSBaseViewController<UITableViewDelegate,UITableViewDataSource,RemarksCellDelegate>
{


    int pagenum ;
    MJRefreshNormalHeader *header;
    MJRefreshAutoNormalFooter *footer;
}

@property (nonatomic,strong)NSArray *ArrayDataBottom;

@property (nonatomic,strong)NSArray *ArrAyImagVBottom;

@property (nonatomic,strong)UITableView *MainTableView;

@property (nonatomic,strong)UITableView *SecondTableView;

@property (nonatomic,strong)NSString *tagName;



@property (nonatomic,strong)NSMutableArray *DataArray;
/**大图*/
@property (nonatomic,strong)NSString *BigHeadURL;
/**专题*/
@property (nonatomic,strong)NSString *ZhuantiName;
/**头像*/
@property (nonatomic,strong)NSString *headImageVUrl;
/**名字*/
@property (nonatomic,strong)NSString *nameStr;
/**播放次数*/
@property (nonatomic,strong)NSString *palyCount;
/**更新集*/
@property (nonatomic,strong)NSString *genxinCount;

/**描述*/
@property (nonatomic,strong)NSString *ContString;

@property (nonatomic,strong)UIView *BackView;

@property (nonatomic,strong)NSString *RowNameSting;

@property (nonatomic,strong)NSString *DeataiString;





@end
