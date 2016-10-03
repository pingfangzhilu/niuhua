//
//  ClassListViewController.h
//  voices
//
//  Created by pc on 16/10/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WSBaseViewController.h"
#import "XMSDK.h"
#import "MJRefresh.h"
#import "RecommeTableViewCell.h"
@interface ClassListViewController : WSBaseViewController<UITableViewDelegate,UITableViewDataSource>
{

    int pagenum ;
    MJRefreshNormalHeader *header;
    MJRefreshAutoNormalFooter *footer;

}

@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) NSString *titleWillShow;
@property (nonatomic,strong)NSString *tagName;

@property (nonatomic,strong) UITableView *MainTableView;

@property (nonatomic,strong)NSMutableArray *DataArray;

@end
