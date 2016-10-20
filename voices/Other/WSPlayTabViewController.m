//
//  WSPlayTabViewController.m
//  voices
//
//  Created by pc on 16/10/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WSPlayTabViewController.h"

@implementation WSPlayTabViewController
 - (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor grayColor];

    
    [XMSDKPlayer sharedPlayer].trackPlayDelegate =self;
    [self CreteuiBlack];
    [self CreateUI];


}


- (void)CreateUI
{

    NSLog(@"传过来多少%lu", (unsigned long)[[XMSDKPlayer sharedPlayer]playList].count);
//    [[XMSDKPlayer sharedPlayer]playList].count;

    NSLog(@"你好啊1=＝＝＝%@",[[XMSDKPlayer sharedPlayer]currentTrack].trackTitle);
    
    
    CGFloat WhithWide = self.view.frame.size.width - 100;
    
    
    
    UIImageView *headImageV =[[UIImageView alloc]init];
    
    [headImageV sd_setImageWithURL:[NSURL URLWithString:[[XMSDKPlayer sharedPlayer]currentTrack ].coverUrlMiddle] placeholderImage:[UIImage imageNamed:@"placeholder_disk"]];
    
    headImageV.layer.masksToBounds =YES;
    
    headImageV.layer.cornerRadius = WhithWide*0.5;
    
    [self.view addSubview:headImageV];
    
    [headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.and.width.equalTo(@(WhithWide));
        
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.centerY.equalTo(self.view.mas_centerY).with.offset(-50);
        
    }];
    
    
    self.TimeLabel =[[UILabel alloc]init];
    
    self.TimeLabel.font =[UIFont systemFontOfSize:28];
    self.TimeLabel.textAlignment =NSTextAlignmentCenter;
    self.TimeLabel.textColor =[UIColor whiteColor];
    [headImageV addSubview:self.TimeLabel];
    
    [self.TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(headImageV).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
        
    }];
    
    
//    UIButton *StopBtn =[[UIButton alloc]init];
//    
//    [StopBtn setTitle:@"暂停" forState:UIControlStateNormal];
//    
//    [StopBtn addTarget:self action:@selector(StopBtn:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:StopBtn];
//    
//    [StopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.width.and.height.equalTo(@50);
//        make.left.equalTo(self.view.mas_left).with.offset(50);
//        make.centerY.equalTo(self.view.mas_centerY);
//        
//        
//    }];
//    
//    
//    UIButton *NextBtn =[[UIButton alloc]init];
//    
//    [NextBtn setTitle:@"下一首" forState:UIControlStateNormal];
//    
//    [NextBtn addTarget:self action:@selector(nextBtn:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    [self.view addSubview:NextBtn];
//    
//    [NextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.width.and.height.equalTo(@50);
//        make.left.equalTo(StopBtn.mas_right).with.offset(10);
//        make.centerY.equalTo(self.view.mas_centerY);
//        
//        
//    }];
    
}
- (void)XMTrackPlayNotifyProcess:(CGFloat)percent currentSecond:(NSUInteger)currentSecond
{

    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:currentSecond];
    //    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    
    self.TimeLabel.text = [NSString stringWithFormat:@"%@",currentDateStr];

}
//- (void)StopBtn:(UIButton *)Btn
//{
//
//
//[[XMSDKPlayer sharedPlayer] pauseTrackPlay];
//
//
//
//}
//
//- (void)nextBtn:(UIButton *)Btn
//{
//
//
//  [[XMSDKPlayer sharedPlayer] playNextTrack];
//
//}
//




- (void)CreteuiBlack
{

    
    UIButton *BTn =[[UIButton alloc]init];
    
//    [BTn setTitle:@"返回" forState:UIControlStateNormal];
    
    [BTn setImage:[UIImage imageNamed:@"taobao_xp_hl_ewall_back_normal副本"] forState:UIControlStateNormal];
    [BTn addTarget:self action:@selector(black:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:BTn];
    
    [BTn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(5);
        make.top.equalTo(self.view.mas_top).with.offset(20);
        make.width.equalTo(@50);
        make.height.equalTo(@40);
        
        
    }];
    
    
    UILabel *TitleLabel =[[UILabel alloc]init];
    
    TitleLabel.font =[UIFont systemFontOfSize:16];
    
    TitleLabel.textColor =[UIColor whiteColor];
    TitleLabel.text = [[XMSDKPlayer sharedPlayer]currentTrack].trackTitle;
    [self.view addSubview:TitleLabel];
    
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(BTn.mas_right);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.equalTo(@20);
        
         make.top.equalTo(self.view.mas_top).with.offset(20);
        
    }];
    
    
    UILabel *nameLabel =[[UILabel alloc]init];
    
    nameLabel.textColor =[UIColor whiteColor];
    nameLabel.text =self.NmaeStr;
    
    nameLabel.font =[UIFont systemFontOfSize:12];
    
    [self.view addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(@15);
        make.top.equalTo(TitleLabel.mas_bottom);
        make.left.equalTo(BTn.mas_right);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        
        
    }];
    
    
    


}


- (void)black:(UIButton *)Btn
{


[self dismissViewControllerAnimated:YES completion:^{
    
}];

}

@end
