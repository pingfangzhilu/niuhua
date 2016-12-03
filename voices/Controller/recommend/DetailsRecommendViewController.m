//
//  DetailsRecommendViewController.m
//  voices
//
//  Created by pc on 16/10/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DetailsRecommendViewController.h"

@interface DetailsRecommendViewController ()
{
  BOOL _isShow;
}
@end

@implementation DetailsRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.DataArray =[[NSMutableArray alloc]init];
    pagenum =1;
    // Do any additional setup after loading the view.
    
    self.ArrayDataBottom = @[@"设备播放",@"设备下一首播放",@"加入设备播放列表",@"收藏",@"下载",self.ContString];
    self.ArrAyImagVBottom =@[@"bottom_menu_dev_playlist",@"bottom_menu_dev_next",@"menu_add2dev_playlist",@"bottom_menu_collect",@"bottom_menu_download",@"bottom_menu_info"];
    [self CreateNav];
    [self CreateUI];
    [self LoadData:3];
    
   
    
    
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
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)LoadData:(NSInteger)tag
{
    
    [self showHUB];
    
    
//    XMAlbum *album = self.array[indexPath.row];
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:@(album.albumId) forKey:@"album_id"];
//    [params setObject:@20 forKey:@"count"];
//    [params setObject:@1 forKey:@"page"];
//    
//    [[XMReqMgr sharedInstance] requestXMData:XMReqType_AlbumsBrowse params:params withCompletionHander:^(id result, XMErrorModel *error) {
//        [self showReceivedData:result className:@"XMTrack" valuePath:@"tracks" titleNeedShow:@"trackTitle"];
//    }];
    
    NSDictionary *params=@{@"album_id":self.tagName,@"count":@(20),@"page":@(pagenum)};
    
    
    //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    [params setObject:@6 forKey:@"category_id"];
    //    [params setObject:xmtag.tagName forKey:@"tag_name"];
    //    [params setObject:@1 forKey:@"calc_dimension"];  //设置值为1、2、3
    //    [params setObject:@20 forKey:@"count"];
    //    [params setObject:@1 forKey:@"page"];
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_AlbumsBrowse params:params withCompletionHander:^(id result, XMErrorModel *error) {
        if(!error)
            [self showReceivedData:result className:@"XMTrack" valuePath:@"tracks" titleNeedShow:@"trackTitle" tag:tag];
//            [self showReceivedData:result className:@"XMAlbum" valuePath:@"albums" titleNeedShow:@"albumTitle":tag];
        else
            NSLog(@"%@   %@",error.description,result);
        [self hideHUB];
    }];
    
    
    
}

- (void)showReceivedData:(id)result className:(NSString*)className valuePath:(NSString *)path titleNeedShow:(NSString *)title  tag:(NSInteger)tag
{
    
    
//    if (tag ==1&&self.DataArray) {
//        [self.DataArray removeAllObjects];
//    }
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
        
//        [self.MainTableView.mj_header endRefreshing];
        
    }else
    {
        
//        [self.MainTableView.mj_header endRefreshing];
        [self.MainTableView.mj_footer endRefreshing];
        //
        [self.MainTableView.mj_footer setState:MJRefreshStateNoMoreData];
        
    }
    
    
    [self hideHUB];
    
    [self.MainTableView reloadData];
    //    self.array = models;
    //    vc.titleWillShow = title;
//    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
//    [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    //    GerneralTableViewController *vc = [[GerneralTableViewController alloc] init];
    
    //    [self.navigationController pushViewController:vc animated:YES];
}



- (void)CreateUI
{

    footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.MainTableView = [[UITableView alloc]init];
    self.MainTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
     self.MainTableView.mj_footer =footer;
    self.MainTableView.delegate=self;
    self.MainTableView.tag =1000;
    
    self.MainTableView.dataSource =self;
    
    [self.view addSubview:self.MainTableView];
    
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(64, 0, 0, 0));
        
        
    }];
    
    for (int XXX=0 ; XXX<3; XXX++) {
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:XXX];
        [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
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

- (void)loadMoreData
{


    pagenum++;
    [self LoadData:2];


}

- (void)Playing
{

    
    [[XMSDKPlayer sharedPlayer] setPlayMode:XMSDKPlayModeTrack];
    [[XMSDKPlayer sharedPlayer] setTrackPlayMode:XMTrackPlayerModeList];
    [[XMSDKPlayer sharedPlayer] playWithTrack:self.track playlist:self.DataArray];

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1000) {
        
        switch (indexPath.section) {
            case 3:
            {
                XMTrack *XMbum =self.DataArray[indexPath.row];
                
                self.BottomArray = self.DataArray;
                
                self.track = self.DataArray[indexPath.row];
                //            [self.navigationController pushViewController:playingViewController animated:YES];
                [self.BottomHeadImageV  sd_setImageWithURL:[NSURL URLWithString:XMbum.coverUrlLarge] placeholderImage:[UIImage imageNamed:@"placeholder_disk"]];
                
////                [self Playing];
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"dataArray" object:self.DataArray];
//                
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"indexPathRow" object:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                //添加 字典，将label的值通过key值设置传递
//                NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:self.DataArray,@"textOne",indexPath.row,@"textTwo", nil];
                //创建通知
                
                
                
                
                
                
                
                
                NSDictionary *dict = @{@"textOne":self.DataArray,@"textTwo":[NSString stringWithFormat:@"%ld",(long)indexPath.row],@"textSan":self.nameStr};
                
                NSNotification *notification =[NSNotification notificationWithName:@"dataArray" object:nil userInfo:dict];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
                
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
                [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                
                
                [self POstNotif];
                
          
                
            }
                break;
                
            default:
                break;
        }

        
        
    }
    else
    {
    
        if (indexPath.section==1) {
            
            switch (indexPath.row) {
                case 0:
                {
                    NSDictionary *dict = @{@"shebiData":self.DataArray,@"shebiTwo":[NSString stringWithFormat:@"%ld",(long)indexPath.row]};
                    
                    NSNotification *notification =[NSNotification notificationWithName:@"shebiUrl" object:nil userInfo:dict];
                    //通过通知中心发送通知
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    [self devplayTrack];
                    
                    
                
                }
                    break;
                    
                default:
                    break;
            }
            
            [self.SecondTableView removeFromSuperview];
            [self.BackView removeFromSuperview];
           
            
            
        }
        else
        {
        
        }
        
        
    
    
    
    }
    
    
    
    
    
    

}

-(void)POstNotif
{
    
    NSDictionary *dict = @{@"tagName":self.tagName,@"BigHeadURL":self.BigHeadURL,@"ZhuantiName":self.ZhuantiName,@"nameStr":self.nameStr,@"headImageVUrl":self.headImageVUrl,@"palyCount":self.palyCount,@"genxinCount":self.genxinCount,@"ContString":self.ContString};
    
    NSNotification *notification =[NSNotification notificationWithName:@"DetailsRecommendData" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];




}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView.tag==1000) {
        switch (indexPath.section) {
            case 0:
            {
                static NSString *jjjj =@"2222";
                RecommHeadImageVTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:jjjj];
                if (cell ==nil) {
                    cell =[[RecommHeadImageVTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jjjj];
                    
                }
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                [cell.BigHeadImagv sd_setImageWithURL:[NSURL URLWithString:self.BigHeadURL] placeholderImage:[UIImage imageNamed:@"placeholder_disk"]];
                
                //            cell
                [cell contString:self.ZhuantiName];
                return cell;
                
                
            }
                break;
            case 1:
            {
                static NSString *LLLLL=@"esvea";
                RecommJieSTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:LLLLL];
                if (cell==nil) {
                    cell =[[RecommJieSTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LLLLL];
                }
                [cell.headImageV sd_setImageWithURL:[NSURL URLWithString:self.headImageVUrl] placeholderImage:[UIImage imageNamed:@"placeholder_disk"]];
                cell.NameLabel.text =self.nameStr;
                cell.genxinLAbel.text =[NSString stringWithFormat:@"更新至%@集",self.genxinCount];
                cell.PassLabel.text =[NSString stringWithFormat:@"专辑总播放%.1f万次",([self.palyCount intValue]/10000.0)];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
            case 2:
            {
                static NSString *cellName = @"meTableViewCell";
                RemarksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                if (!cell) {
                    cell = [[RemarksTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellName];
                    cell.delegate = self;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                [cell setCellContent:self.ContString andIsShow:_isShow  andCellIndexPath:indexPath];
                
                return cell;
                
            }
                break;
            case 3:
            {
                static NSString *iden =@"iden";
                
                ClassDetailTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:iden];
                if (cell==nil) {
                    
                    cell =[[ClassDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
                }
                XMTrack *XMbum =self.DataArray[indexPath.row];
                
                cell.CentLabel.text = [NSString stringWithFormat:@"%@",XMbum.trackTitle];
                
                IntervalSinceNow *inter =[[IntervalSinceNow alloc]init];
                
                cell.LookLabel.text= [inter intervalSinceNow:[NSString stringWithFormat:@"%f",XMbum.updatedAt/1000]];
                
                
                if (XMbum.playCount >10000) {
                      cell.PassLabel.text =[NSString stringWithFormat:@"播放%.2f万次",XMbum.playCount/10000.0 ];
                }
                else
                {
                cell.PassLabel.text =[NSString stringWithFormat:@"播放%ld次",XMbum.playCount ];
                }
                [cell.HeaadImagv sd_setImageWithURL:[NSURL URLWithString:XMbum.coverUrlLarge] placeholderImage:[UIImage imageNamed:@"placeholder_disk"]];
                
                [cell.ArrowImgv addTarget:self  action:@selector(cellbutton:) forControlEvents:UIControlEventTouchUpInside];
                cell.ArrowImgv.tag = indexPath.row;
                for (id obj in cell.subviews)
                {
                    if ([NSStringFromClass([obj class])isEqualToString:@"ClassDetailTableViewCell"])
                    {
                        UIScrollView *scroll = (UIScrollView *) obj;
                        scroll.delaysContentTouches =NO;
                        break;
                    }
                }
                
                
                return cell;
                
                
            }
                break;
            default:
                break;
        }

        
    }
    else
    {
    
        
        
        switch (indexPath.section) {
            case 0:
            {
             static   NSString *lll =@"fffffffff";
                RecommOneLabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:lll];
                if (cell ==nil) {
                    cell =[[RecommOneLabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lll];
                    
                    
                }
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                cell.CnetLabel.text = self.RowNameSting;
            
                return cell;
                
            }
                break;
            case 1:
            {
                
                static NSString *kskskk =@"hgdwwwq";
                RecommSecondTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:kskskk];
                if (cell ==nil) {
                    cell =[[RecommSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kskskk];
                    
                }
                
                cell.CentLabel.text =self.ArrayDataBottom[indexPath.row];
                
                cell.headImageV.image =[UIImage imageNamed:self.ArrAyImagVBottom[indexPath.row]];
                
                
                return cell;
            }
                break;
            default:
                break;
        }
        
        
        
        
        
    
    
    }
    
    
    
    return nil;
    
    
  
}

-(void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
  
     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"dataArray" object:nil];
    
}


 - (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
       [self.navigationController setNavigationBarHidden:YES animated:animated];

}

- (void)TAppp:(UITapGestureRecognizer *)tap
{
    [self.BackView removeFromSuperview];
    [self.SecondTableView removeFromSuperview];
    

}


- (void)cellbutton:(UIButton *)Btn
{

    
       XMTrack *XMbum =self.DataArray[Btn.tag];
    self.RowNameSting =[NSString stringWithFormat:@"%@",XMbum.trackTitle];
    
     UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    
    self.BackView =[[UIView alloc]init];
    self.BackView.backgroundColor =[UIColor blackColor];
    self.BackView.alpha=0.6;
    [currentWindow addSubview:self.BackView];
    
    self.track = self.DataArray[Btn.tag];
    
    
    
    [self.BackView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
         make.edges.equalTo(currentWindow).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UITapGestureRecognizer *tapp =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TAppp:)];
    
    [self.BackView addGestureRecognizer:tapp];
    
    
    self.SecondTableView =[[UITableView alloc]init];
    self.SecondTableView.delegate=self;
    self.SecondTableView.tag=2000;
    self.SecondTableView.dataSource =self;
    self.SecondTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [currentWindow addSubview:self.SecondTableView];
    
    
    [self.SecondTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(@290);
        make.left.equalTo(currentWindow.mas_left);
        make.right.equalTo(currentWindow.mas_right);
        make.bottom.equalTo(currentWindow.mas_bottom);
        
        
    }];
    
    
    
    
    
    
    

    NSLog(@"%ld",(long)Btn.tag);

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==1000) {
        switch (indexPath.section) {
            case 0:
            {
                return 250;
            }
                break;
            case 1:
            {
                return 65;
            }
                break;
            case 2:
            {
                if ([self.ContString isEqualToString:@""]) {
                    return 0;
                }
                else
                {
                    
                    return [RemarksCellHeightModel cellHeightWith:self.ContString andIsShow:_isShow andLableWidth:BOUNDS.size.width-30 andFont:13 andDefaultHeight:35 andFixedHeight:20 andIsShowBtn:8];
                    
                }
                
                
            }
                break;
            case 3:
            {
                return 110;
            }
                break;
                
            default:
                break;
        }

    }
    else
    {
    
    
        if (indexPath.section==0) {
            
            return 50;
        }else
        {
        
            return 40;
        }
    
    
    
    }
   
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 1000:
        {
        
            if (section==3) {
                
                return self.DataArray.count;
            }
            else
            {
                return 1;
            }
        }
            break;
            
            case 2000:
        {
            if (section==0) {
                return 1;
            }
            else
            {
                return 6;
            
            }
            
        
        }
         break;
        default:
            break;
    }

    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (tableView.tag) {
        case 1000:
        {
        return 4;
        }
            break;
        case 2000:
        {
            return 2;
        }
            break;
        default:
            break;
    }
    return 0;
}

#pragma mark -- Dalegate
- (void)remarksCellShowContrntWithDic:(NSDictionary *)dic andCellIndexPath:(NSIndexPath *)indexPath
{
    _isShow = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"isShow"]] boolValue];
    
    [self.MainTableView reloadData];
}

- (void)devplayTrack
{
    
    
    
       //NSString转char * /const char *
    const char * playurl = [self.track.playUrl32 UTF8String];
    const char * name = [self.track.trackTitle UTF8String];
    
    
    int ret =nativeMplayer((char *)playurl,name,(int)self.track.duration);
    
    NSLog(@"时间啊啊%ld",self.track.duration);
    
    printf("ret = %d playurl = %s\n ",ret,playurl);
    return ;

}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
