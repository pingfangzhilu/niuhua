//
//  ClassifyViewController.m
//  voices
//
//  Created by pc on 16/10/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ClassifyViewController.h"

@interface ClassifyViewController ()

@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor clearColor];
    
     [XMReqMgr sharedInstance].delegate = self;
  
    [self CreateUI];
     [self LoadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 [self.navigationController setNavigationBarHidden:NO animated:animated];
   

}


- (void)CreateUI
{
    self.MianTableView =[[UITableView alloc]init];
    self.MianTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.MianTableView.delegate =self;
    self.MianTableView.dataSource =self;
    
    [self.view addSubview:self.MianTableView];
    
    [self.MianTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.MianTableView.superview.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-49);
        
        
        
        
    }];

    UIView *foodView =[[UIView alloc]init];
    foodView.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    foodView.backgroundColor =[UIColor whiteColor];
    self.MianTableView.tableFooterView =foodView;
    
    UIImageView *foodimagv =[[UIImageView alloc]init];
    foodimagv.image =[UIImage imageNamed:@"ximalayalogo"];
    [foodView addSubview:foodimagv];
    [foodimagv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@13);
        
        make.width.equalTo(@90);
        make.centerX.equalTo(foodView.mas_centerX);
        make.top.equalTo(foodView.mas_top).with.offset(10);
        
    }];
    
    UILabel *ximalayaLabel =[[UILabel alloc]init];
    ximalayaLabel.text =@"由喜马拉雅开放平台提供技术支持";
    ximalayaLabel.textAlignment = NSTextAlignmentCenter;
    ximalayaLabel.font =[UIFont systemFontOfSize:16];
    ximalayaLabel.textColor =[UIColor blackColor];
    [foodView addSubview:ximalayaLabel];
    
    [ximalayaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(foodView.mas_left);
        make.right.equalTo(foodView.mas_right);
        make.height.equalTo(@20);
        make.top.equalTo(foodimagv.mas_bottom).with.offset(10);
        
    }];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *iden =@"iden";

    ClassMainTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:iden];
    if (cell==nil) {
        cell =[[ClassMainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    cell.headImage.image =[UIImage imageNamed:@"placeholder_disk"];
    cell.IMavg.image = [UIImage imageNamed:@"abc_ic_menu_moreoverflow_mtrl_alpha"];
    id model = self.array[indexPath.row];
    //if ([model containsValueForKey:self.titleWillShow])
    if(self.titleWillShow.length >0)
    {
        //显示获取到内容
        cell.CentLabel.text = [model valueForKeyPath:self.titleWillShow];
        NSLog(@" %@\n",[model valueForKeyPath:self.titleWillShow]);
    }
    else
    {
        cell.CentLabel.text = self.array[indexPath.row];
        NSLog(@"......tableView array %@\n",self.array[indexPath.row]);
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 80;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMTag *xmtag = self.array[indexPath.row];
    
    ClassListViewController *list =[[ClassListViewController alloc]init];
    list.tagName =xmtag.tagName;
    
    [self.navigationController pushViewController:list animated:YES];
    NSIndexPath *indexPathXXXX=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathXXXX,nil] withRowAnimation:UITableViewRowAnimationNone];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:@6 forKey:@"category_id"];
//    [params setObject:xmtag.tagName forKey:@"tag_name"];
//    [params setObject:@1 forKey:@"calc_dimension"];  //设置值为1、2、3
//    [params setObject:@20 forKey:@"count"];
//    [params setObject:@1 forKey:@"page"];
//    [[XMReqMgr sharedInstance] requestXMData:XMReqType_AlbumsList params:params withCompletionHander:^(id result, XMErrorModel *error) {
//        if(!error)
//            [self showReceivedData:result className:@"XMAlbum" valuePath:@"albums" titleNeedShow:@"albumTitle"];
//        else
//            NSLog(@"%@   %@",error.description,result);
//    }];




}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)LoadData
{

    [self showHUB];
    
    NSDictionary *params = @{@"category_id":@(6),@"type":@(0)};
    //            [params setObject:@6 forKey:@"category_id"];
    //            [params setObject:@0 forKey:@"type"];
    
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_TagsList params:params withCompletionHander:^(id result, XMErrorModel *error) {
        if (!error)
        {
            [self showReceivedData:result className:@"XMTag" valuePath:nil titleNeedShow:@"tagName"];
        }
        else
        {
            NSLog(@"Error: error_no:%ld, error_code:%@, error_desc:%@",(long)error.error_no, error.error_code, error.error_desc);
        [self hideHUB];
        [self LoadData];
        }
    }];



}
- (void)showReceivedData:(id)result className:(NSString*)className valuePath:(NSString *)path titleNeedShow:(NSString*)title
{
    [self hideHUB];
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
//    NSMutableArray *DataArry = [NSMutableArray array];
//    [DataArry addObjectsFromArray:models];
    
    
    NSMutableIndexSet *set=[NSMutableIndexSet indexSet];
    [ set addIndex:4];
//    [set addIndex:14];
    if (models.count>13) {
         [models removeLastObject];
        
    }
    [models removeObjectsAtIndexes:set];
//
    self.array = models;
    self.titleWillShow =title;
    
    [self.MianTableView reloadData];
//    GerneralTableViewController *vc = [[GerneralTableViewController alloc] init];
//    vc.array = models;
//    vc.titleWillShow = title;
//    
//    [self.navigationController pushViewController:vc animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
