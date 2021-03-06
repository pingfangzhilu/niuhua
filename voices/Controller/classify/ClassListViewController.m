//
//  ClassListViewController.m
//  voices
//
//  Created by pc on 16/10/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ClassListViewController.h"

@interface ClassListViewController ()

@end

@implementation ClassListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.DataArray =[[NSMutableArray alloc]init];
      pagenum = 1;
    [self CreateNav];
    [self LoadData:3];
    [self CreateUI];
}

- (void)LoadData:(NSInteger)tag
{
//    [self showHUB];
    [SVProgressHUD showWithStatus:@"正在下载数据"];
    NSDictionary *params=@{@"category_id":@(6),@"tag_name":self.tagName,@"calc_dimension":@(1),@"count":@(20),@"page":@(pagenum)};
    
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:@6 forKey:@"category_id"];
//    [params setObject:xmtag.tagName forKey:@"tag_name"];
//    [params setObject:@1 forKey:@"calc_dimension"];  //设置值为1、2、3
//    [params setObject:@20 forKey:@"count"];
//    [params setObject:@1 forKey:@"page"];
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_AlbumsList params:params withCompletionHander:^(id result, XMErrorModel *error) {
        if(!error)
        {
            [SVProgressHUD dismiss];
            [self showReceivedData:result className:@"XMAlbum" valuePath:@"albums" titleNeedShow:@"albumTitle":tag];
        }
        else
        {
            NSLog(@"%@   %@",error.description,result);
            [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
        }
//        [self hideHUB];
    }];



}



- (void)CreateNav
{
    
    UIView *whiteView =[[UIView alloc]init];
    whiteView.backgroundColor =[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    
    [self.view addSubview:whiteView];
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.equalTo(@64);
        
        
    }];
    
    
    UIButton *left =[[UIButton alloc]init];
    //    [left setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [left setImage:[UIImage imageNamed:@"taobao_xp_hl_ewall_back_normal"] forState:UIControlStateNormal];
    
    [left addTarget:self action:@selector(backUp:) forControlEvents:UIControlEventTouchUpInside];
    left.imageEdgeInsets = UIEdgeInsetsMake(5,-5,7,17);
    
    [whiteView addSubview:left];
    
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@50);
        make.height.equalTo(@30);
        make.bottom.equalTo(whiteView.mas_bottom).with.offset(-5);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        
    }];
    
    
    
    
    
    
    
    
    
}
- (void)backUp:(UIButton *)Btn
{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];


}


- (void)showReceivedData:(id)result className:(NSString*)className valuePath:(NSString *)path titleNeedShow:(NSString *)title:(NSInteger)tag
{
    
    
    if (tag ==1&&self.DataArray) {
        [self.DataArray removeAllObjects];
    }
    NSMutableArray *models = [NSMutableArray array];
    Class dataClass = NSClassFromString(className);
    if([result isKindOfClass:[NSArray class]]){
        for (NSDictionary *dic in result) {
            id model = [[dataClass alloc] initWithDictionary:dic];
            [self.DataArray addObject:model];
            [models addObject:model];
        }
    }
    else if([result isKindOfClass:[NSDictionary class]]){
        if(path.length == 0)
        {
            id model = [[dataClass alloc] initWithDictionary:result];
            [self.DataArray addObject:model];
            [models addObject:model];
        }
        else
        {
            for (NSDictionary *dic in result[path]) {
                id model = [[dataClass alloc] initWithDictionary:dic];
                [self.DataArray addObject:model];
                [models addObject:model];
            }
        }
    }
    
    if (models.count>0) {
        
         [self.MainTableView.mj_footer endRefreshing];
        
         [self.MainTableView.mj_header endRefreshing];
        
    }else
    {
    
        [self.MainTableView.mj_header endRefreshing];
        [self.MainTableView.mj_footer endRefreshing];
        //
        [self.MainTableView.mj_footer setState:MJRefreshStateNoMoreData];
    
    }
    
    
    
    
//    [self hideHUB];
//    self.array = models;
    //    vc.titleWillShow = title;
    [self.MainTableView reloadData];
//    GerneralTableViewController *vc = [[GerneralTableViewController alloc] init];

//    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}





- (void)CreateUI
{
    header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
  
    self.MainTableView=[[UITableView alloc]init];
    self.MainTableView.delegate=self;
    self.MainTableView.dataSource=self;
    self.MainTableView.mj_header=header;
    self.MainTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.MainTableView.mj_footer =footer;
    [self.view addSubview:self.MainTableView];
    
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
      make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];

    UIView *foodView =[[UIView alloc]init];
    foodView.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    foodView.backgroundColor =[UIColor whiteColor];
    self.MainTableView.tableFooterView =foodView;
    
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


#pragma mark 下拉刷新
- (void)loadNewData
{
    NSLog(@"下拉刷新");
    //    [self.PostTabArray removeAllObjects];
    pagenum = 1;
    
   [self LoadData:1];
}
#pragma mark 上拉刷新
- (void)loadMoreData
{
    NSLog(@"上拉刷新");
    pagenum++;
   [self LoadData:2];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

static NSString *iden =@"iden";
    
    RecommeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:iden];
    if (cell==nil) {
        
        cell =[[RecommeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    XMAlbum *XMbum =self.DataArray[indexPath.row];
    id model = self.DataArray[indexPath.row];
    //if ([model containsValueForKey:self.titleWillShow])
    if(self.titleWillShow.length >0)
    {
        //显示获取到内容
        cell.CentLabel.text = [model valueForKeyPath:self.titleWillShow];
        NSLog(@" %@\n",[model valueForKeyPath:self.titleWillShow]);
    }
    else
    {
        cell.CentLabel.text = [NSString stringWithFormat:@"%@",XMbum.albumTitle];
        NSLog(@"......tableView array %@\n",self.DataArray[indexPath.row]);
    }
   
    cell.PassLabel.text =[NSString stringWithFormat:@"播放%.1f万次",(XMbum.playCount /10000.0)];
    [cell.headImaGv sd_setImageWithURL:[NSURL URLWithString:XMbum.coverUrlLarge] placeholderImage:[UIImage imageNamed:@"placeholder_disk"]];
    cell.ContenLabe.text =[NSString stringWithFormat:@"%@",XMbum.albumIntro];
    cell.NewLabe.text =[NSString stringWithFormat:@"更新至%ld集",(long)XMbum.includeTrackCount];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 XMAlbum *XMbum =self.DataArray[indexPath.row];
    
    DetailsRecommendViewController *detail =[[DetailsRecommendViewController alloc]init];
//    detail.tagName =[NSString stringWithFormat:@"%ld",(long)XMbum.albumId];
//  NSString *restricfff =  XMbum.announcer.nickname ;
    
    
    detail.tagName =[NSString stringWithFormat:@"%ld",(long)XMbum.albumId];
    detail.BigHeadURL =[NSString stringWithFormat:@"%@",XMbum.coverUrlLarge];
    detail.ZhuantiName =[NSString stringWithFormat:@"%@",XMbum.albumTitle];
    detail.nameStr =[NSString stringWithFormat:@"%@",XMbum.announcer.nickname];
    detail.headImageVUrl =[NSString stringWithFormat:@"%@",XMbum.announcer.avatarUrl];
    detail.palyCount =[NSString stringWithFormat:@"%ld",(long)XMbum.playCount];
    detail.genxinCount =[NSString stringWithFormat:@"%ld",(long)XMbum.includeTrackCount];
    detail.ContString =[NSString stringWithFormat:@"%@",XMbum.albumIntro];

    
    
    
    
    [self.navigationController pushViewController:detail animated:YES];
    
    NSIndexPath *indexPathXXXX=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
    [self.MainTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathXXXX,nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return self.DataArray.count;
    
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
