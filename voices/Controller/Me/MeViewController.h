//
//  MeViewController.h
//  voices
//
//  Created by pc on 16/10/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WSBaseViewController.h"
#import "MEviewTableViewCell.h"
#import "MeSecondTableViewCell.h"
@interface MeViewController : WSBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *MainTableView;
@property (nonatomic,strong)NSArray *ImagevArray;

@property (nonatomic,strong)NSArray *WenziArray;
@end
