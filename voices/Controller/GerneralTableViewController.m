//
//  GerneralTableViewController.m
//  ximalaya
//
//  Created by mac on 16/9/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GerneralTableViewController.h"
#import "PlayingViewController.h"
#import "ViewController.h"
#import "XMSDK.h"

@interface GerneralTableViewController ()

@end

@implementation GerneralTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"TableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:SimpleTableIdentifier];
    }
    id model = self.array[indexPath.row];
    //if ([model containsValueForKey:self.titleWillShow])
    if(self.titleWillShow.length >0)
    {
        //显示获取到内容
        cell.textLabel.text = [model valueForKeyPath:self.titleWillShow];
        NSLog(@" %@\n",[model valueForKeyPath:self.titleWillShow]);
    }
    else
    {
        cell.textLabel.text = self.array[indexPath.row];
        NSLog(@"......tableView array %@\n",self.array[indexPath.row]);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) sself = self;
    NSLog(@"获取分类[%d]\n",indexPath.row);
    if ([self.array[0] isKindOfClass:[XMCategory class]])
    {
        //获取到分类列表容器对象，存放在self.array 数组当中
        XMCategory *category = self.array[indexPath.row];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@(category.categoryId) forKey:@"category_id"];
        [params setObject:@0 forKey:@"type"];
        [[XMReqMgr sharedInstance] requestXMData:XMReqType_TagsList params:params withCompletionHander:^(id result, XMErrorModel *error) {
            [sself showReceivedData:result className:@"XMTag" valuePath:nil titleNeedShow:@"tagName"];
            
        }];
        NSLog(@"获取分类[%d] %@\n",indexPath.row,category.categoryName);
        
        
    }
    else if ([self.array[0] isKindOfClass:[XMAlbum class]])
    {
        XMAlbum *album = self.array[indexPath.row];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@(album.albumId) forKey:@"album_id"];
        [params setObject:@20 forKey:@"count"];
        [params setObject:@1 forKey:@"page"];
        
        [[XMReqMgr sharedInstance] requestXMData:XMReqType_AlbumsBrowse params:params withCompletionHander:^(id result, XMErrorModel *error) {
            [sself showReceivedData:result className:@"XMTrack" valuePath:@"tracks" titleNeedShow:@"trackTitle"];
        }];
        NSLog(@"进入推荐[%d] =%@ [%d] \n",indexPath.row,album.albumTitle,album.albumId);
    }
    else if([self.array[0] isKindOfClass:[XMTrack class]])
    {
        PlayingViewController *playingViewController = [[PlayingViewController alloc] init];
        playingViewController.track = self.array[indexPath.row];
        playingViewController.trackList = self.array;
        [self.navigationController pushViewController:playingViewController animated:YES];
    }
    else if([self.array[0] isKindOfClass:[XMRadio class]]){
        PlayingViewController *playingViewController = [[PlayingViewController alloc] init];
        playingViewController.radio = self.array[indexPath.row];
        [self.navigationController pushViewController:playingViewController animated:YES];
    }
    else if ([self.array[0] isKindOfClass:[XMRadioSchedule class]]){
        PlayingViewController *playingViewController = [[PlayingViewController alloc] init];
        playingViewController.programList = self.array;
        playingViewController.radioSchedule = self.array[indexPath.row];
        [self.navigationController pushViewController:playingViewController animated:YES];
    }else if([self.array[0] isKindOfClass:[XMTag class]]){
        XMTag *xmtag = self.array[indexPath.row];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@6 forKey:@"category_id"];
        [params setObject:xmtag.tagName forKey:@"tag_name"];
        [params setObject:@1 forKey:@"calc_dimension"];  //设置值为1、2、3
        [params setObject:@20 forKey:@"count"];
        [params setObject:@1 forKey:@"page"];
        [[XMReqMgr sharedInstance] requestXMData:XMReqType_AlbumsList params:params withCompletionHander:^(id result, XMErrorModel *error) {
            if(!error)
                [sself showReceivedData:result className:@"XMAlbum" valuePath:@"albums" titleNeedShow:@"albumTitle"];
            else
                NSLog(@"%@   %@",error.description,result);
        }];
        NSLog(@"XMTag 分类[%d] %@  kind =%@\n",indexPath.row,xmtag.tagName,xmtag.kind);
    }else{
        NSLog(@"未知分类[%d]\n",indexPath.row);
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
            for (NSDictionary *dic in result[path]) {
                id model = [[dataClass alloc] initWithDictionary:dic];
                [models addObject:model];
            }
        }
    }
    GerneralTableViewController *vc = [[GerneralTableViewController alloc] init];
    vc.array = models;
    vc.titleWillShow = title;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
