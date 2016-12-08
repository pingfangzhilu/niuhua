//
//  ClassifyViewController.h
//  voices
//
//  Created by pc on 16/10/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WSBaseViewController.h"
#import "XMSDK.h"
#import "ClassMainTableViewCell.h"
#include "demo_tcp.h"
#include "Interface.h"
#import "ClassListViewController.h"
#include "cJSON.h"
//#import "AFNetworking.h"
@interface ClassifyViewController : WSBaseViewController<UITableViewDelegate,UITableViewDataSource,XMReqDelegate>
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) NSString *titleWillShow;

@property (nonatomic,strong) UITableView *MianTableView;

@end
