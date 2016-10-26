//
//  MeViewController.m
//  voices
//
//  Created by pc on 16/10/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor blueColor];
    
    self.ImagevArray =@[@"topmenu_icn_time",@"menu_icon_dev_time",@"nav_menu_play_album",@"bottom_menu_download",@"menu_heart"];
    self.WenziArray =@[@"最近播放",@"设备最近播放",@"收藏的专辑",@"下载管理",@"我喜欢的"];
    
    
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:animated];


}
- (void)createUI
{
    self.MainTableView =[[UITableView alloc]init];
    
    self.MainTableView.delegate =self;
    self.MainTableView.dataSource =self;
    self.MainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.MainTableView];
    [self.MainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
         make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
        
    }];


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 1;
            break;
        default:
            break;
    }

    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
             return 70;
            break;
        case 1:
            return 50;
            break;
        default:
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (indexPath.section) {
        case 0:
        {
            static NSString *iden = @"hswdw";
            
            MEviewTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:iden];
            if (cell==nil) {
                cell =[[MEviewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
            }
            
//            [NSString stringWithFormat:@"%@",];
            cell.HeadImagev.image =[UIImage imageNamed:self.ImagevArray[indexPath.row]];
            
            NSString *STring =[NSString stringWithFormat:@"%@   共（0）首",self.WenziArray[indexPath.row]];
            NSString *lentRing =[NSString stringWithFormat:@"%@",self.WenziArray[indexPath.row]];
            NSMutableAttributedString *MUattt =[[NSMutableAttributedString alloc]initWithString:STring];
            
            [MUattt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, lentRing.length)];
            [MUattt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, lentRing.length)];
            
            cell.CentLabel.attributedText =MUattt;
            
            return cell;
            
        }
            break;
        case 1:
        {
            static NSString *idens = @"hswdwssss";
            
            MeSecondTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:idens];
            if (cell==nil) {
                cell =[[MeSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idens];
            }
            return cell;
            
        }
            break;
        default:
            break;
    }

    return nil;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
    [self.MainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];


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
