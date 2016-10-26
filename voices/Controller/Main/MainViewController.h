//
//  MainViewController.h
//  voices
//
//  Created by pc on 16/10/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WSBaseViewController.h"
#import "MeViewController.h"
#import "RecommendViewController.h"
#import "ClassifyViewController.h"

#import "SlideMenuController.h"
#import "TTTTTTTTTTTTT.h"
#import "SCNavTabBarController.h"

#import "DetailsRecommendViewController.h"

@interface MainViewController : WSBaseViewController<SlideMenuControllerDelegate>


@property (nonatomic,strong)NSString *tagName;

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




@end
