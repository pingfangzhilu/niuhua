//
//  RecommendViewController.m
//  voices
//
//  Created by pc on 16/10/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RecommendViewController.h"

@interface RecommendViewController ()

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor clearColor];
    
 
    
    [self CreateUI];
   
    
}

 - (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:animated];
   self.ALLArray =@[@"新妈听听看",@"爱听故事",@"英文磨耳朵",@"儿歌大全",@"科普涨知识",@"国学启蒙",@"亲子学堂",@"口袋故事集",@"宝贝SHOW",@"卡通动画片",@"中小学必备"];

    [self tuijianLaod];
    [self LoadData];
}







- (void)tuijianLaod
{
    [self showHUB];
    NSDictionary *params=@{@"category_id":@(6),@"calc_dimension":@(1),@"count":@(6),@"page":@(1)};
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_AlbumsList params:params withCompletionHander:^(id result, XMErrorModel *error) {
        if(!error)
        {
            [self showReceivedData:result className:@"XMAlbum" valuePath:@"albums" titleNeedShow:@"albumTitle":0];
        }
        else
        {
            NSLog(@"%@   %@",error.description,result);
        [self hideHUB];
        [self tuijianLaod];
        }
    }];




}

- (void)LoadData
{
    [self showHUB];
    for (int XXX=0; XXX<self.ALLArray.count; XXX++) {
        NSDictionary *params=@{@"category_id":@(6),@"tag_name":self.ALLArray[XXX],@"calc_dimension":@(1),@"count":@(6),@"page":@(1)};
        [[XMReqMgr sharedInstance] requestXMData:XMReqType_AlbumsList params:params withCompletionHander:^(id result, XMErrorModel *error) {
            if(!error)
            {
                [self showReceivedData:result className:@"XMAlbum" valuePath:@"albums" titleNeedShow:@"albumTitle":XXX+1];
            }
            else
            {
                NSLog(@"%@   %@",error.description,result);
            
            [self hideHUB];
            [self LoadData];
            }
        }];
    }
    
    //    [self.MainTableView reloadData];


}
- (void)showReceivedData:(id)result className:(NSString*)className valuePath:(NSString *)path titleNeedShow:(NSString *)title:(NSInteger)tag
{
    
    [self hideHUB];
       NSMutableArray *models = [NSMutableArray array];
    Class dataClass = NSClassFromString(className);
    if([result isKindOfClass:[NSArray class]]){
        for (NSDictionary *dic in result) {
            id model = [[dataClass alloc] initWithDictionary:dic];
//            [self.DataArray addObject:model];
            [models addObject:model];
        }
    }
    else if([result isKindOfClass:[NSDictionary class]]){
        if(path.length == 0)
        {
            id model = [[dataClass alloc] initWithDictionary:result];
//            [self.DataArray addObject:model];
            [models addObject:model];
        }
        else
        {
            for (NSDictionary *dic in result[path]) {
                id model = [[dataClass alloc] initWithDictionary:dic];
//                [self.DataArray addObject:model];
                [models addObject:model];
            }
        }
    }
     NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:tag];
     [self.MainTableView.mj_header endRefreshing];
    switch (tag) {
        case 0:
            self.TuijianArray =models;
            
            
             [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            
            break;
        case 1:
            self.xinMamaArray =models;
             [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case 2:
            self.GushiArray =models;
             [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case 3:
            self.YwenArray =models;
             [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case 4:
            self.ErgeArray =models;
             [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case 5:
            self.KepuArray =models;
             [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case 6:
            self.GuoxueArray =models;
             [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case 7:
            self.QinziArray =models;
             [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case 8:
            self.KedaiArray =models;
             [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case 9:
            self.ShowArray =models;
             [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case 10:
            self.KatongArray =models;
             [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case 11:
            self.ZhongxiaoArray =models;
             [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
            
            
            
        default:
            break;
    }
    
    
   
   
   
    
    
 
}
#pragma mark 刷新
- (void)loadNewData
{


    [self tuijianLaod];
    [self LoadData];

}
- (void)CreateUI
{
 header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.MainTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.MainTableView.delegate=self;
    self.MainTableView.dataSource=self;
    self.MainTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.MainTableView.mj_header=header;
    [self.view addSubview:self.MainTableView];
    
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
         make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 49, 0));
        
    }];


    
  
    

}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
static NSString *head =@"headd";
    ZYMyTableViewHeader *hf =[tableView dequeueReusableHeaderFooterViewWithIdentifier:head];
    if (!hf) {
        hf =[[ZYMyTableViewHeader alloc]initWithReuseIdentifier:head];
    }

       if (section==0) {
         hf.CentLabel.text=@"今日推荐";
        hf.MoreBtn.hidden =YES;
    }
    else
    {
        hf.CentLabel.text =self.ALLArray[section-1];
        hf.MoreBtn.tag = section-1;
     hf.MoreBtn.hidden =NO;
    
    }
    
    [hf.MoreBtn addTarget:self action:@selector(MOredata:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return hf;

}


#pragma mark  查看更多
- (void)MOredata:(UIButton *)Btn
{
    ClassListViewController *list =[[ClassListViewController alloc]init];
    list.tagName = self.ALLArray[Btn.tag];
    [self.navigationController pushViewController:list animated:YES];
    


}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XMAlbum *XMbum =[[XMAlbum alloc]init];
    
    switch (indexPath.section) {
        case 0:
            XMbum =self.TuijianArray[indexPath.row];
            break;
        case 1:
            XMbum =self.xinMamaArray[indexPath.row];
            
            break;
        case 2:
            XMbum =self.GushiArray[indexPath.row];
            
            break;
        case 3:
            XMbum =self.YwenArray[indexPath.row];
            
            break;
        case 4:
            XMbum =self.ErgeArray[indexPath.row];
            
            break;
        case 5:
            XMbum =self.KepuArray[indexPath.row];
            
            break;
        case 6:
            XMbum =self.GuoxueArray[indexPath.row];
            
            break;
        case 7:
            XMbum =self.QinziArray[indexPath.row];
            
            break;
        case 8:
            XMbum =self.KedaiArray[indexPath.row];
            
            break;
        case 9:
            XMbum =self.ShowArray[indexPath.row];
            
            break;
        case 10:
            XMbum =self.KatongArray[indexPath.row];
            
            break;
        case 11:
            XMbum =self.ZhongxiaoArray[indexPath.row];
            
            break;
            
            
            
            
            
        default:
            break;
    }

    
    
    
    DetailsRecommendViewController *recomm =[[DetailsRecommendViewController alloc]init];
    
    recomm.tagName =[NSString stringWithFormat:@"%ld",(long)XMbum.albumId];
    recomm.BigHeadURL =[NSString stringWithFormat:@"%@",XMbum.coverUrlLarge];
    recomm.ZhuantiName =[NSString stringWithFormat:@"%@",XMbum.albumTitle];
    recomm.nameStr =[NSString stringWithFormat:@"%@",XMbum.announcer.nickname];
    recomm.headImageVUrl =[NSString stringWithFormat:@"%@",XMbum.announcer.avatarUrl];
    recomm.palyCount =[NSString stringWithFormat:@"%ld",(long)XMbum.playCount];
    recomm.genxinCount =[NSString stringWithFormat:@"%ld",(long)XMbum.includeTrackCount];
    recomm.ContString =[NSString stringWithFormat:@"%@",XMbum.albumIntro];
    
    [self.navigationController pushViewController:recomm animated:YES];
    
    
    NSIndexPath *indexPathXXXX=[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathXXXX,nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

static NSString *iden =@"iden";
    RecommeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:iden];
    if (cell==nil) {
        cell =[[RecommeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    XMAlbum *XMbum =[[XMAlbum alloc]init];
    
    switch (indexPath.section) {
        case 0:
              XMbum =self.TuijianArray[indexPath.row];
            break;
        case 1:
             XMbum =self.xinMamaArray[indexPath.row];
            
            break;
        case 2:
           XMbum =self.GushiArray[indexPath.row];
            
            break;
        case 3:
            XMbum =self.YwenArray[indexPath.row];
            
            break;
        case 4:
             XMbum =self.ErgeArray[indexPath.row];
            
            break;
        case 5:
             XMbum =self.KepuArray[indexPath.row];
            
            break;
        case 6:
            XMbum =self.GuoxueArray[indexPath.row];
            
            break;
        case 7:
             XMbum =self.QinziArray[indexPath.row];
            
            break;
        case 8:
             XMbum =self.KedaiArray[indexPath.row];
            
            break;
        case 9:
             XMbum =self.ShowArray[indexPath.row];
            
            break;
        case 10:
            XMbum =self.KatongArray[indexPath.row];
            
            break;
        case 11:
            XMbum =self.ZhongxiaoArray[indexPath.row];
            
            break;

       
            
            
            
        default:
            break;
    }
    
 
   cell.CentLabel.text = [NSString stringWithFormat:@"%@", XMbum.albumTitle];
    
    cell.PassLabel.text =[NSString stringWithFormat:@"播放%.1f万次",( XMbum.playCount /10000.0)];
    [cell.headImaGv sd_setImageWithURL:[NSURL URLWithString: XMbum.coverUrlLarge] placeholderImage:[UIImage imageNamed:@"placeholder_disk"]];
    cell.ContenLabe.text =[NSString stringWithFormat:@"%@",XMbum.albumIntro];
    cell.NewLabe.text =[NSString stringWithFormat:@"更新至%ld集",(long) XMbum.includeTrackCount];
    
    

    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return 6;

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{


    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 110;
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
