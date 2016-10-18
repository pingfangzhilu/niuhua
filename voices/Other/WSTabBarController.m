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
    

    //删除现有的tabBar
    CGRect rect = self.tabBar.frame;
    [self.tabBar removeFromSuperview];  //移除TabBarController自带的下部的条
    
    //测试添加自己的视图
    self.myView = [[UIView alloc] init];
    self.myView.frame = rect;
    self.myView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myView];
    
    MainViewController *sdkDemoViewController = [[MainViewController alloc]init];
    
    UINavigationController *navConttroller = [[UINavigationController alloc] initWithRootViewController:sdkDemoViewController];
    

     [self addChildViewController:navConttroller];
    
    
    
    [self CreateUI];
    

}




- (void)CreateUI
{

    self.HeadImageView =[[UIImageView alloc]init];
    self.HeadImageView.image =[UIImage imageNamed:@"rb_7"];
    
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
    self.NameLabel.text =@"你的看看书没耐心了呢";
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
    self.zhuanjiLabel.text =@"红红火火看看";
    [self.myView addSubview:self.zhuanjiLabel];
    [self.zhuanjiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.NameLabel.mas_bottom);
        make.left.equalTo(self.HeadImageView.mas_right).with.offset(5);
        make.right.equalTo(self.ListBtn.mas_left).with.offset(-5);
        make.bottom.equalTo(self.myView.mas_bottom);
    }];
    
    
    
    
    
    
}


#define currentWindow  [UIApplication sharedApplication].keyWindow
- (void)NextBtn:(UIButton *)Btn
{


    NSLog(@"下一首");
}

- (void)PlayBtn:(UIButton *)Btn
{

    self.PlayBtn.selected =!self.PlayBtn.selected;
    
    NSLog(@"播放");

}


- (void)ListBtn:(UIButton *)Btn
{

    NSLog(@"列表");
    [self CreteTableview];
}


- (void)CreteTableview
{

    
    self.BackView =[[UIView alloc]init];
    
    self.BackView.backgroundColor =[UIColor blackColor];
    
    self.BackView.alpha =0.6;
    
    [currentWindow addSubview:self.BackView];
    [self.BackView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
        make.edges.equalTo(currentWindow).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
        
    }];
    
    
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapTure:)];
    
    [self.BackView addGestureRecognizer:tap];
    
    self.MianTableView =[[UITableView alloc]init];
    self.MianTableView.delegate=self;
    self.MianTableView.dataSource=self;
    self.MianTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [currentWindow addSubview:self.MianTableView];
    
    [self.MianTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(currentWindow.mas_bottom);
        make.left.equalTo(currentWindow.mas_left);
        make.right.equalTo(currentWindow.mas_right);
        make.height.equalTo(@300);
        
        
    }];




}


- (void)TapTure:(UITapGestureRecognizer *)tap
{

    [self.BackView removeFromSuperview];
    
    [self.MianTableView removeFromSuperview];


}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

static NSString *iden =@"hefiuq";
    MainListTabBarViewcell *cell =[tableView dequeueReusableCellWithIdentifier:iden];
    if (cell ==nil) {
        
        cell =[[MainListTabBarViewcell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    

    cell.CentLabel.text =[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
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


    NSLog(@"删除%ld",Btn.tag);

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{



    NSIndexPath *indexPathAAA=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
    [self.MianTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathAAA,nil] withRowAnimation:UITableViewRowAnimationNone];




}



@end
