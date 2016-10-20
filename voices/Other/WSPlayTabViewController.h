//
//  WSPlayTabViewController.h
//  voices
//
//  Created by pc on 16/10/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WSBaseViewController.h"
#import "XMSDK.h"
@interface WSPlayTabViewController : WSBaseViewController<XMTrackPlayerDelegate>


@property (nonatomic,strong)XMTrack *trackone;


@property (nonatomic,assign)NSInteger  currChooseIndex;


@property (nonatomic,strong)NSString *NmaeStr;


@property (nonatomic,strong)UILabel *TimeLabel;

@end
