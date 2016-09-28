//
//  ViewController.h
//  voices
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XMSDK.h"


@interface ViewController : UITableViewController<XMReqDelegate>

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSArray *urlStringArray;

@end

