//
//  ViewController.m
//  voices
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "GerneralTableViewController.h"
#include "demo_tcp.h"
#include "Interface.h"

#include "cJSON.h"
ViewController *OCP=nil ;

@interface ViewController ()
{
    NSArray *array;
    int playCount;//globe vaule
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    OCP = self;// 把指针传给他
    playCount =0;
//    array =   [NSArray arrayWithObjects:
//               @"http://fdfs.xmcdn.com/group7/M01/A3/8D/wKgDX1d2Rr6w3CegABHDHZzUiUs448.mp3",
//               @"http://fdfs.xmcdn.com/group4/M03/A3/84/wKgDs1d2RZ_RjSxuABV9gmXQeIc233.mp3",
//               @"http://fdfs.xmcdn.com/group14/M01/A2/06/wKgDZFdzNujBdVzmABboXqMK5U0551.mp3",
//               @"http://fdfs.xmcdn.com/group9/M08/A1/4A/wKgDZldzNWzRoXyzACZofeFKKKc093.mp3",
//               @"http://fdfs.xmcdn.com/group14/M09/9F/EA/wKgDZFdwhHSyCmBsABE4V3MaLHU408.mp3",
//               @"http://fdfs.xmcdn.com/group15/M05/99/61/wKgDaFdqbLaQq4oRABBQgZsXAcA203.mp3",
//               nil];

    [[XMReqMgr sharedInstance] registerXMReqInfoWithKey:@"b617866c20482d133d5de66fceb37da3" appSecret:@"4d8e605fa7ed546c4bcb33dee1381179"] ;
    
    [XMReqMgr sharedInstance].delegate = self;
    
    self.titleArray = [NSMutableArray arrayWithObjects:
                       @"儿童分类",
                       @"儿童相关信息",                  //儿童相关信息
                       @"儿童推荐列表",                  //儿童推荐列表
                       @"胎教故事",                     //胎教故事
                       nil
                       ];
    self.view.frame = CGRectMake(0, 59, self.view.frame.size.width, self.view.frame.size.height);
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    
    nativeInitSystem(ocCallBack);
    
}

void ocCallBack(int type,char *msg,int size)
{
//    printf("msg = %s\n",msg);

    [OCP ocCallMsg:msg];
}

- (void)ocCallMsg:(char *)msg
{
    Player_t * play = GetPlayer();
    printf("play->playState = %d\n",play->playState);
}

#pragma mark tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    //添加网络上获取到列表菜单
    //    NSLog(@"indexPath.row[%d]= %@\n",indexPath.row,self.titleArray[indexPath.row]);
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) sself = self;
    NSLog(@"[%d]%@\n",indexPath.row,self.titleArray[indexPath.row]);
    switch (indexPath.row) {
        case 0:     //儿童分类
        {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:@6 forKey:@"category_id"];
            [params setObject:@0 forKey:@"type"];
            [[XMReqMgr sharedInstance] requestXMData:XMReqType_TagsList params:params withCompletionHander:^(id result, XMErrorModel *error) {
                if (!error)
                    [sself showReceivedData:result className:@"XMTag" valuePath:nil titleNeedShow:@"tagName"];
                else
                    NSLog(@"Error: error_no:%ld, error_code:%@, error_desc:%@",(long)error.error_no, error.error_code, error.error_desc);
            }];
            break;
        }
        case 1:            //儿童相关信息
        {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:@6 forKey:@"category_id"];
            [params setObject:@1 forKey:@"type"];
            [[XMReqMgr sharedInstance] requestXMData:XMReqType_TagsList params:params withCompletionHander:^(id result, XMErrorModel *error) {
                if (!error)
                    [sself showReceivedData:result className:@"XMTag" valuePath:nil titleNeedShow:@"tagName"];
                else
                    NSLog(@"Error: error_no:%ld, error_code:%@, error_desc:%@",(long)error.error_no, error.error_code, error.error_desc);
            }];
            break;
        }
        case 2:     //@儿童推荐列表
        {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:@6 forKey:@"category_id"];
            [params setObject:@20 forKey:@"count"];  //提前一次，加载的内容数目
            [params setObject:@1 forKey:@"page"];   //按页获取内容 1：表示去第1页内容，2：表示取第2页内容 3：表示取第三页内容
            [params setObject:@1 forKey:@"calc_dimension"];
            //            [params setObject:@3 forKey:@"calc_dimension"];
            [[XMReqMgr sharedInstance] requestXMData:XMReqType_AlbumsList params:params withCompletionHander:^(id result, XMErrorModel *error) {
                if (!error)
                    [sself showReceivedData:result className:@"XMAlbum" valuePath:@"albums" titleNeedShow:@"albumTitle"];
                else
                    NSLog(@"Error: error_no:%ld, error_code:%@, error_desc:%@",(long)error.error_no, error.error_code, error.error_desc);
            }];
            break;
        }
        case 3:// @"胎教故事",
        {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            //            [params setObject:@2996987 forKey:@"album_id"];
            [params setObject:[NSNumber numberWithInt:2996987] forKey:@"album_id"];
            [params setObject:@"asc" forKey:@"sort"];
            [params setObject:@20 forKey:@"count"];
            [params setObject:@1 forKey:@"page"];
            //            [params setObject:@"ascc" forKey:@"sort"];
            [[XMReqMgr sharedInstance] requestXMData:XMReqType_AlbumsBrowse params:params withCompletionHander:^(id result, XMErrorModel *error) {
                if (!error)
                    [sself showReceivedData:result className:@"XMTrack" valuePath:@"tracks" titleNeedShow:@"trackTitle"];
                //                NSLog(@"result --- %@ --- end", result);
                else
                    NSLog(@"Error: error_no:%ld, error_code:%@, error_desc:%@",(long)error.error_no, error.error_code, error.error_desc);
            }];
            break;
        }
        default:
            break;
    }
}

- (void)showReceivedData:(id)result className:(NSString*)className valuePath:(NSString *)path titleNeedShow:(NSString*)title
{
    NSMutableArray *models = [NSMutableArray array];
    Class dataClass = NSClassFromString(className);
    if([result isKindOfClass:[NSArray class]]){
        for (NSDictionary *dic in result) {
            id model = [[dataClass alloc] initWithDictionary:dic];
            [models addObject:model];
        }
    }
    else if([result isKindOfClass:[NSDictionary class]]){
        if(path.length == 0)
        {
            id model = [[dataClass alloc] initWithDictionary:result];
            [models addObject:model];
        }
        else
        {
            NSArray *paths = [path componentsSeparatedByString:@"."];
            NSDictionary *dic = result;
            for (int i=0;i<paths.count-1;i++)
            {
                NSString *subPath = paths[i];
                dic = dic[subPath];
            }
            for (NSDictionary *dict in dic[paths.lastObject])
            {
                id model = [[dataClass alloc] initWithDictionary:dict];
                [models addObject:model];
//                self.array[indexPath.row]
            }
        }
    }
    int count=0;
    for (NSMutableArray *object in models) {
//        NSLog(@"数组对象:%@", object);
        if([object isKindOfClass:[XMTrack class]])
        {
            XMTrack *xmt=object;
            NSLog(@"里面的标签内容:%@",xmt.trackTitle);
        }else if ([object isKindOfClass:[XMAlbum class]]){
            XMAlbum *album=object;
            NSLog(@"[%d]:%@",count++,album.albumTitle);
        }
    }
    
//    GerneralTableViewController *vc = [[GerneralTableViewController alloc] init];
//    vc.array = models;
//    vc.titleWillShow = title;
//    
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
