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
    [self CreateUI];
    [self LoadData:3];
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
    self.MainTableView.dataSource =self;
    
    [self.view addSubview:self.MainTableView];
    
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
        
    }];
    
    for (int XXX=0 ; XXX<3; XXX++) {
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:XXX];
        [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
   

}

- (void)loadMoreData
{


    pagenum++;
    [self LoadData:2];


}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{



}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


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
            
            
            
            
            cell.PassLabel.text =[NSString stringWithFormat:@"播放%ld次",XMbum.playCount ];
            [cell.HeaadImagv sd_setImageWithURL:[NSURL URLWithString:XMbum.coverUrlLarge] placeholderImage:[UIImage imageNamed:@"placeholder_disk"]];
            
            return cell;

            
        }
            break;
        default:
            break;
    }
    
    
    
    
    return nil;
    
    
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return 230;
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

    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section==3) {
        
       return self.DataArray.count;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 4;
}

#pragma mark -- Dalegate
- (void)remarksCellShowContrntWithDic:(NSDictionary *)dic andCellIndexPath:(NSIndexPath *)indexPath
{
    _isShow = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"isShow"]] boolValue];
    
    [self.MainTableView reloadData];
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
