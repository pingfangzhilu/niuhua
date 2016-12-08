//
//  RecommendViewController.h
//  voices
//
//  Created by pc on 16/10/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WSBaseViewController.h"
#import "RecommeTableViewCell.h"
#import "ZYMyTableViewHeader.h"
#import "XMSDK.h"
#import "ClassListViewController.h"
#import "DetailsRecommendViewController.h"
//#import <AFNetworkReachabilityManager.h>
//#import "AFNetworking.h"

@interface RecommendViewController : WSBaseViewController<UITableViewDelegate,UITableViewDataSource>

{

   MJRefreshNormalHeader *header;
}
@property (nonatomic,strong)UITableView *MainTableView;
/**新妈听听看   */
@property (nonatomic,strong)NSArray *xinMamaArray;
/**爱听故事   */
@property (nonatomic,strong)NSArray *GushiArray;
/** 英文磨耳朵  */
@property (nonatomic,strong)NSArray *YwenArray;
/**  儿歌大全 */
@property (nonatomic,strong)NSArray *ErgeArray;
/**  科普涨知识 */
@property (nonatomic,strong)NSArray *KepuArray;
/** 国学启蒙  */
@property (nonatomic,strong)NSArray *GuoxueArray;
/**  亲自学堂 */
@property (nonatomic,strong)NSArray *QinziArray;
/** 口袋故事集  */
@property (nonatomic,strong)NSArray *KedaiArray;
/**  宝贝show */
@property (nonatomic,strong)NSArray *ShowArray;
/** 卡通动画片  */
@property (nonatomic,strong)NSArray *KatongArray;
/**  中小学必备 */
@property (nonatomic,strong)NSArray *ZhongxiaoArray;
/** 推荐  */
@property (nonatomic,strong)NSArray *TuijianArray;

@property (nonatomic,strong)NSArray *ALLArray;


@property (nonatomic,strong)NSString *tagName;

@end
