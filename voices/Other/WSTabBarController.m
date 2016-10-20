//
//  WSTabBarController.m
//  voices
//
//  Created by pc on 16/10/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WSTabBarController.h"
#import "MainViewController.h"
@implementation WSTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.UpdateArray  =[[NSMutableArray alloc]init];
    self.currentArray =[[NSMutableArray alloc]init];
    //删除现有的tabBar
    CGRect rect = self.tabBar.frame;
    [self.tabBar removeFromSuperview];  //移除TabBarController自带的下部的条
    
    //测试添加自己的视图
    self.myView = [[UIView alloc] init];
    self.myView.userInteractionEnabled =YES;
    self.myView.frame = rect;
    self.myView.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.myView];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MyvIEWtAP:)];
    
    [self.myView addGestureRecognizer:tap];
    
    
    
    
    MainViewController *sdkDemoViewController = [[MainViewController alloc]init];
    
    UINavigationController *navConttroller = [[UINavigationController alloc] initWithRootViewController:sdkDemoViewController];
    

     [self addChildViewController:navConttroller];
    
    indecxxx =0 ;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dataArray:) name:@"dataArray" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(indexPathRow:) name:@"indexPathRow" object:nil];
    
    
    [[XMSDKPlayer sharedPlayer] setAutoNexTrack:YES];
    [XMSDKPlayer sharedPlayer].trackPlayDelegate = self;
    [[XMSDKPlayer sharedPlayer] setTrackPlayMode:XMTrackPlayerModeEnd];
    
    [self CreateUI];
    

}


- (void)MyvIEWtAP:(UITapGestureRecognizer *)tap
{

      WSPlayTabViewController *ttttt =[[WSPlayTabViewController alloc]init];
    
    if (self.UpdateArray.count>0) {
         ttttt.NmaeStr =self.nameStr;
        
        [self  presentViewController:ttttt animated:YES completion:^{
            
//            ttttt.currChooseIndex = [[XMSDKPlayer sharedPlayer]currentTrack].orderNum;
            
           
        }];
        
        
    }
    
    
  
    
    
    


}

- (void)indexPathRow:(NSNotification *)notif
{

    
//    indecxxx = (int)[notif object];


//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"indexPathRow" object:nil];
}


- (void)dataArray:(NSNotification *)notif
{
    [self.UpdateArray removeAllObjects];

    self.AllDataArray = (NSArray *)notif.userInfo[@"textOne"];
    
    [self.UpdateArray addObjectsFromArray:self.AllDataArray];
    self.MarkStr = (NSString *)notif.userInfo[@"textTwo"];
 
    self.nameStr =(NSString *)notif.userInfo[@"textSan"];
    
     self.track = self.UpdateArray[[self.MarkStr intValue]];
    
//    self.NameLabel.text =[NSString stringWithFormat:@"%@",self.track.trackTitle];
    self.zhuanjiLabel.text =[NSString stringWithFormat:@"%@",self.nameStr];
    
//    [self.HeadImageView sd_setImageWithURL:[NSURL URLWithString:self.track.coverUrlMiddle] placeholderImage:[UIImage imageNamed:@"placeholder_disk"]];
//    
    
   
    
    
    [self.MianTableView reloadData];
    
    
    
    [self plying];
    
    

}


 - (void)plying
{

   
    
    [[XMSDKPlayer sharedPlayer] setPlayMode:XMSDKPlayModeTrack];
    
    [[XMSDKPlayer sharedPlayer] setTrackPlayMode:XMTrackPlayerModeEnd];
    [[XMSDKPlayer sharedPlayer] playWithTrack:self.track playlist:self.AllDataArray];

    self.PlayBtn.selected =YES;

}
- (void)CreateUI
{

    self.HeadImageView =[[UIImageView alloc]init];
    self.HeadImageView.image =[UIImage imageNamed:@"placeholder_disk"];
    
    [self.myView addSubview:self.HeadImageView];
    
    [self.HeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.myView.mas_left);
        make.top.equalTo(self.myView.mas_top);
        make.bottom.equalTo(self.myView.mas_bottom);
        make.width.equalTo(@49);
        
    }];
    

    self.NextBtn =[[UIButton alloc]init];
    
    [self.NextBtn setImage:[UIImage imageNamed:@"playbar_btn_next"] forState:UIControlStateNormal];
    
    [self.NextBtn addTarget:self action:@selector(NextBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myView addSubview:self.NextBtn];
    
    [self.NextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
       make.top.equalTo(self.myView.mas_top).with.offset(1);
        make.bottom.equalTo(self.myView.mas_bottom);
        make.right.equalTo(self.myView.mas_right);
        make.width.equalTo(@40);
        
    }];
    
    
    self.PlayBtn =[[UIButton alloc]init];
    
    [self.PlayBtn setImage:[UIImage imageNamed:@"play_btn"] forState:UIControlStateNormal];
    [self.PlayBtn setImage:[UIImage imageNamed:@"pause_btn"] forState:UIControlStateSelected];
    
    [self.PlayBtn addTarget:self action:@selector(PlayBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myView addSubview:self.PlayBtn];
    
    [self.PlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
       make.top.equalTo(self.myView.mas_top).with.offset(1);
        make.bottom.equalTo(self.myView.mas_bottom);
        make.right.equalTo(self.NextBtn.mas_left);
        make.width.equalTo(@40);
        
        
    }];
    
    
    self.ListBtn =[[UIButton alloc]init];
    
    [self.ListBtn setImage:[UIImage imageNamed:@"playbar_btn_playlist"] forState:UIControlStateNormal];
    
    [self.ListBtn addTarget:self action:@selector(ListBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.myView addSubview:self.ListBtn];
    
    [self.ListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myView.mas_top).with.offset(1);
        make.bottom.equalTo(self.myView.mas_bottom);
        make.right.equalTo(self.PlayBtn.mas_left);
        make.width.equalTo(@40);
        
        
    }];
    
    self.NameLabel =[[UILabel alloc]init];
    self.NameLabel.font= [UIFont systemFontOfSize:16];
    self.NameLabel.textColor =[UIColor blackColor];
    self.NameLabel.text =@"糍粑糖";
   
    [self.myView addSubview:self.NameLabel];
    
    [self.NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@24);
        make.top.equalTo(self.myView.mas_top).with.offset(1);
        make.left.equalTo(self.HeadImageView.mas_right).with.offset(5);
        make.right.equalTo(self.ListBtn.mas_left).with.offset(-5);
        
    }];
    
    self.zhuanjiLabel =[[UILabel alloc]init];
    self.zhuanjiLabel.font =[UIFont systemFontOfSize:14];
    self.zhuanjiLabel.textColor =[UIColor grayColor];
    self.zhuanjiLabel.text =@"糍粑糖";
    [self.myView addSubview:self.zhuanjiLabel];
    [self.zhuanjiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.NameLabel.mas_bottom);
        make.left.equalTo(self.HeadImageView.mas_right).with.offset(5);
        make.right.equalTo(self.ListBtn.mas_left).with.offset(-5);
        make.bottom.equalTo(self.myView.mas_bottom);
    }];
    
    self.ProgressView =[[UIProgressView alloc]init];
    self.ProgressView.progressTintColor =[UIColor redColor];
    self.ProgressView.trackTintColor =[UIColor whiteColor];
    [self.myView addSubview:self.ProgressView];
    [self.ProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.HeadImageView.mas_right);
        make.right.equalTo(self.myView.mas_right);
        make.height.equalTo(@1);
        make.top.equalTo(self.myView.mas_top);
        
        
    }];
    
    
    
    
    
    
    
    
}


#define currentWindow  [UIApplication sharedApplication].keyWindow
- (void)NextBtn:(UIButton *)Btn
{

    if (self.UpdateArray.count>0) {
        
        
        
        [[XMSDKPlayer sharedPlayer] playNextTrack];
        

        
        
    }
    else
    {
    
    
    }

    NSLog(@"下一首");
}


- (void)PlayBtn:(UIButton *)Btn
{

    if (self.UpdateArray.count>0) {
        
        if (self.PlayBtn.selected == NO) {
            
            
            [[XMSDKPlayer sharedPlayer] setPlayMode:XMSDKPlayModeTrack];
            
            [[XMSDKPlayer sharedPlayer] setTrackPlayMode:XMTrackPlayerModeEnd];
            [[XMSDKPlayer sharedPlayer] playWithTrack:self.track playlist:self.AllDataArray];
            
        }else
        {
            
            
             [[XMSDKPlayer sharedPlayer] pauseTrackPlay];
            
        }
    }
    
    else
    {
    
        return;
    }
   
    
    
    self.PlayBtn.selected =!self.PlayBtn.selected;
    
    NSLog(@"播放");

}
- (void)XMTrackPlayNotifyProcess:(CGFloat)percent currentSecond:(NSUInteger)currentSecond
{
    
    [self.ProgressView setProgress:percent animated:YES];
    //        LOGCA(@"percent: %f, second: %d", percent, currentSecond);
//    proView.value = percent;
    //    NSLog(@"percent: %f, second: %lu", percent, (unsigned long)currentSecond);
}

- (void)XMTrackPlayerDidStart
{
       self.NameLabel.text = [[XMSDKPlayer sharedPlayer] currentTrack].trackTitle;
    
    [self.HeadImageView sd_setImageWithURL:[NSURL URLWithString:[[XMSDKPlayer sharedPlayer] currentTrack].coverUrlMiddle] placeholderImage:[UIImage imageNamed:@"placeholder_disk"]];
    
    
//    NSInteger selectedIndex = 0;
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:[[XMSDKPlayer sharedPlayer]currentTrack].orderNum inSection:0];
    [self.MianTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
      NSLog(@"当前%ld",[[XMSDKPlayer sharedPlayer]currentTrack].orderNum);
    //    NSLog(@"volume didstart---%f", [XMPlayer sharedPlayer].volume);
    //    NSLog(@"sdkplayervolume didstart---%f", [XMSDKPlayer sharedPlayer].sdkPlayerVolume);
    NSLog(@"是什么%ld", (long)[[XMSDKPlayer sharedPlayer] getTrackPlayMode]);
    
}



//播放列表结束时被调用
- (void)XMTrackPlayerDidPlaylistEnd
{


    [[XMSDKPlayer sharedPlayer]replacePlayList:self.UpdateArray];

}

- (BOOL)XMTrackPlayerShouldContinueNextTrackWhenFailed:(XMTrack *)track
{
    return NO;
}

- (void)ListBtn:(UIButton *)Btn
{

    NSLog(@"列表");
    
    if (self.UpdateArray.count>0) {
        
          [self CreteTableview];
        
    }
    
  
    
    
}


- (void)CreteTableview
{

//    [self BackView];
//    
//    [self MianTableView];
  
    
    self.BackView.hidden =NO;
    
    self.MianTableView.hidden =NO;




}




- (UIView *)BackView
{


    if (!_BackView) {
        
        self.BackView =[[UIView alloc]init];
        
        self.BackView.backgroundColor =[UIColor blackColor];
        
        self.BackView.alpha =0.6;
        
        self.BackView.hidden =YES;
        
        [currentWindow addSubview:self.BackView];
        [self.BackView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.edges.equalTo(currentWindow).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            
            
        }];
        
        
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapTure:)];
        
        [self.BackView addGestureRecognizer:tap];
        
    }
    

    return _BackView;


}

- (UITableView *)MianTableView
{

    [self BackView];
    if (!_MianTableView) {
        self.MianTableView =[[UITableView alloc]init];
        self.MianTableView.delegate=self;
        self.MianTableView.dataSource=self;
        self.MianTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        self.MianTableView.hidden=YES;
        [currentWindow addSubview:self.MianTableView];
        
        [self.MianTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(currentWindow.mas_bottom);
            make.left.equalTo(currentWindow.mas_left);
            make.right.equalTo(currentWindow.mas_right);
            make.height.equalTo(@300);
            
            
        }];
    }


    return _MianTableView;

}







- (void)TapTure:(UITapGestureRecognizer *)tap
{

    self.BackView.hidden =YES;
    
    self.MianTableView.hidden =YES;
    
//    [self.BackView removeFromSuperview];
//    
//    [self.MianTableView removeFromSuperview];


}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

static NSString *iden =@"hefiuq";
    MainListTabBarViewcell *cell =[tableView dequeueReusableCellWithIdentifier:iden];
    if (cell ==nil) {
        
        cell =[[MainListTabBarViewcell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    cell.CentLabel.highlightedTextColor = [UIColor redColor];
    
    XMTrack *track =[[XMTrack alloc]init];
    track =self.UpdateArray[indexPath.row];
    

    cell.CentLabel.text =[NSString stringWithFormat:@"%@",track.trackTitle];
    
    [cell.DeleteBtn addTarget:self action:@selector(DeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.DeleteBtn.tag = indexPath.row;
    
    for (id obj in cell.subviews)
            {
                if ([NSStringFromClass([obj class])isEqualToString:@"MainListTabBarViewcell"])
                {
                    UIScrollView *scroll = (UIScrollView *) obj;
                    scroll.delaysContentTouches =NO;
                    break;
                }
            }
        //
    
    
    return cell;


}

- (void)DeleteBtn:(UIButton *)Btn
{
    
    [self.currentArray removeAllObjects];

    [self.UpdateArray removeObjectAtIndex:Btn.tag];
    
    [self.currentArray addObjectsFromArray:self.UpdateArray];
    


    [[XMSDKPlayer sharedPlayer]playWithTrack:self.track playlist:self.currentArray];
    
    [self.MianTableView reloadData];
    
  

    NSLog(@"删除%ld",self.UpdateArray.count);

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return self.UpdateArray.count;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    self.track =self.UpdateArray[indexPath.row];
    
//    self.NameLabel.text =[NSString stringWithFormat:@"%@",self.track.trackTitle];
    
    
//    [self.HeadImageView sd_setImageWithURL:[NSURL URLWithString:self.track.coverUrlMiddle] placeholderImage:[UIImage imageNamed:@"placeholder_disk"]];
    
    
    [self plying];


    NSIndexPath *indexPathAAA=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
    [self.MianTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathAAA,nil] withRowAnimation:UITableViewRowAnimationNone];




}



@end
