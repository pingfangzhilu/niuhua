//
//  PlayingViewController.h
//  voices
//
//  Created by mac on 16/9/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XMSDK.h"

@interface PlayingViewController : UIViewController<XMTrackPlayerDelegate,XMLivePlayerDelegate>

@property (nonatomic,strong)XMTrack *track;
@property (nonatomic,strong)NSArray *trackList;

@property (nonatomic,strong)XMRadio *radio;
@property (nonatomic,strong)NSArray *programList;
@property (nonatomic,strong)XMRadioSchedule *radioSchedule;

@end
