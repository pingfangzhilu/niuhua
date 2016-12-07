//
//  WSPlayTabViewController.m
//  voices
//
//  Created by pc on 16/10/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WSPlayTabViewController.h"
//#import "JXCircleSlider.h"
@implementation WSPlayTabViewController
{ UILabel *TimeAllLabel;
    UIImageView *headImageV;
 UISlider *proView;
    
    
    UILabel *nameLabel;
    UILabel *TitleLabel;
}
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
    
    
    
   headImageV =[[UIImageView alloc]init];
    
    [headImageV sd_setImageWithURL:[NSURL URLWithString:[[XMSDKPlayer sharedPlayer]currentTrack ].coverUrlMiddle] placeholderImage:[UIImage imageNamed:@"placeholder_disk"]];
    
    headImageV.layer.masksToBounds =YES;
    
    headImageV.layer.cornerRadius = WhithWide*0.5;
    
    [self.view addSubview:headImageV];
    
    [headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.and.width.equalTo(@(WhithWide));
        
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.centerY.equalTo(self.view.mas_centerY).with.offset(-60);
        
    }];
    
    
    self.TimeLabel =[[UILabel alloc]init];
    
    self.TimeLabel.font =[UIFont systemFontOfSize:28];
    self.TimeLabel.textAlignment =NSTextAlignmentCenter;
    self.TimeLabel.textColor =[UIColor whiteColor];
    
    [headImageV addSubview:self.TimeLabel];
    
    [self.TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(headImageV).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
        
    }];
//    CGFloat HHHHH =self.view.frame.size.height *0.5 -(WhithWide +60)*0.5 -50;
////    
//    self.circularSlider =[[EFCircularSlider alloc]initWithFrame:CGRectMake(20,HHHHH, WhithWide+60, WhithWide+60)];
////    self.circularSlider.handleType = bigCircle;
//    self.circularSlider.handleColor = [UIColor redColor];
//    
//    
//     self.circularSlider.maximumValue = 1;
//    
//    [self.circularSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:self.circularSlider];
//
//    
//    
//        [self.circularSlider mas_makeConstraints:^(MASConstraintMaker *make) {
//    
//            make.width.and.height.equalTo(@(280));
//            make.centerX.equalTo(headImageV.mas_centerX);
//            make.centerY.equalTo(headImageV.mas_centerY);
//    
//    
//            
//        }];
    
  
    
    
    
    
    proView = [[UISlider alloc] initWithFrame:CGRectZero];
    //[proView setProgressViewStyle:UIProgressViewStyleDefault]; //设置进度条类型
    proView.backgroundColor = [UIColor clearColor];
    proView.thumbTintColor = [UIColor redColor];
    proView.continuous = NO;
    [proView setThumbImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
     [proView addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
//    proView.layer.cornerRadius  = (WhithWide+20)*0.5 ;
//    proView.layer.masksToBounds = YES;
    
    [self.view addSubview:proView];
[proView mas_makeConstraints:^(MASConstraintMaker *make) {
   
    make.height.equalTo(@(20));
    
//    make.centerX.equalTo(self.view.mas_centerX);
    
    make.top.equalTo(headImageV.mas_bottom).with.offset(20);
//    make.centerX.equalTo(self.view.mas_centerX);
    
    make.left.equalTo(self.view.mas_left).with.offset(20);
    make.right.equalTo(self.view.mas_right).with.offset(-20);
//    make.centerY.equalTo(self.view.mas_centerY).with.offset(-50);
    
    
}];
    
    self.PauseBtn = [[UIButton alloc]init];
    
    [self.PauseBtn setImage:[UIImage imageNamed:@"widget_play_pressed"] forState:UIControlStateNormal];
    [self.PauseBtn setImage:[UIImage imageNamed:@"widget_pause_pressed"] forState:UIControlStateSelected];
    [self.PauseBtn addTarget:self action:@selector(PauseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.PauseBtn];
    
    
    [self.PauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.and.height.equalTo(@43);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(proView.mas_bottom).with.offset(20);
        
    }];
    
    self.NextBtn = [[UIButton alloc]init];
    [self.NextBtn setImage:[UIImage imageNamed:@"next_icon_transparent_pressed"] forState:UIControlStateNormal];
    [self.NextBtn addTarget:self action:@selector(NextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.NextBtn];
    
    [self.NextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.and.height.equalTo(@43);
        
        make.centerY.equalTo(self.PauseBtn.mas_centerY);
        make.left.equalTo(self.PauseBtn.mas_right).with.offset(50);

        
        
        
    }];
    
    
    self.UPButton =[[UIButton alloc]init];
    [self.UPButton setImage:[UIImage imageNamed:@"pre_icon_transparent_pressed"] forState:UIControlStateNormal];
    [self.UPButton addTarget:self action:@selector(UPButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.UPButton];
    
    
    [self.UPButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.and.height.equalTo(@43);
        
        make.centerY.equalTo(self.PauseBtn.mas_centerY);
        make.right.equalTo(self.PauseBtn.mas_left).with.offset(-50);
        
    }];
    
    

    
    
    
//   self.Circleslider = [[JXCircleSlider alloc] initWithFrame:CGRectMake(0, 0, WhithWide+50, WhithWide+50)];
//    
//    self.Circleslider.center = self.view.center ;
//    
//    self.Circleslider.transform = CGAffineTransformMakeRotation(-M_PI/2);
//    [self.Circleslider addTarget:self action:@selector(newValue:) forControlEvents:UIControlEventValueChanged];
//    
//    [self.Circleslider changeAngle:0];
//    [self.view addSubview:self.Circleslider];
//

    
    //将时间戳转为正常时间
    
    ;
    NSString *theDate =[NSString stringWithFormat:@"%ld", (long)[[XMSDKPlayer sharedPlayer]currentTrack].duration];
//    
    NSTimeInterval time=[theDate doubleValue];
    //+28800;//因为时差问题要加8小时 == 28800 sec
    //  NSTimeInterval time=[theDate doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//    //    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    TimeAllLabel =[[UILabel alloc]init];
    TimeAllLabel.textColor =[UIColor whiteColor];
    TimeAllLabel.font =[UIFont systemFontOfSize:14];
    TimeAllLabel.textAlignment =NSTextAlignmentCenter;
    TimeAllLabel.text =currentDateStr;
    
    [self.view addSubview:TimeAllLabel];
    [TimeAllLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@15);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(headImageV.mas_top).with.offset(-5);
        
    }];
    
    
    
    
    UIImageView *BottomImageV =[[UIImageView alloc]init];
    BottomImageV.image =[UIImage imageNamed:@"Xalayajishu"];
    [self.view addSubview:BottomImageV];
    [BottomImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
        make.width.equalTo(@220);
        make.centerX.equalTo(self.view.mas_centerX);
        
        
        
    }];
    
    
    

    
}



- (void)PauseBtnClick
{

    
    
    
    if ([[XMSDKPlayer sharedPlayer] playerState]==0) {
        
        
         [[XMSDKPlayer sharedPlayer] pauseTrackPlay];
        
        
    }
    else{
    
    
        [[XMSDKPlayer sharedPlayer] resumeTrackPlay];
    }
    
    
    self.PauseBtn.selected = !self.PauseBtn.selected;
  

//    NSLog(@"  状态%ld", (long)[[XMSDKPlayer sharedPlayer] playerState]);


}
- (void)NextBtnClick
{


    [[XMSDKPlayer sharedPlayer] playNextTrack];

}

- (void)UPButtonClick
{

[[XMSDKPlayer sharedPlayer] playPrevTrack];

}
-(void)sliderValueChanged:(id)sender
{
    NSInteger second = [XMSDKPlayer sharedPlayer].currentTrack.duration*proView.value;
    //            NSLog(@"seek to %ld   total : %ld",(long)second,(long)[XMSDKPlayer sharedPlayer].currentTrack.duration);
    [[XMSDKPlayer sharedPlayer] seekToTime:second];

}

-(void)newValue:(JXCircleSlider*)slider{
    NSLog(@"newValue:%d",slider.angle);
}


-(void)valueChanged:(EFCircularSlider*)slider {
   
    NSInteger second = [XMSDKPlayer sharedPlayer].currentTrack.duration*slider.currentValue;
    //            NSLog(@"seek to %ld   total : %ld",(long)second,(long)[XMSDKPlayer sharedPlayer].currentTrack.duration);
    [[XMSDKPlayer sharedPlayer] seekToTime:second];
    
//    [[XMSDKPlayer sharedPlayer]playNextTrack];
    
}



- (void)XMTrackPlayNotifyProcess:(CGFloat)percent currentSecond:(NSUInteger)currentSecond
{
//    dispatch_async(dispatch_get_main_queue(), ^{
    
    
    if ([[XMSDKPlayer sharedPlayer] playerState]==0) {
        
        
        self.PauseBtn.selected = YES;
        
        
    }else
    {
        
        self.PauseBtn.selected =NO;
    }

//        
      self.circularSlider.currentValue = percent;
//
//    });
     proView.value = percent;

    TitleLabel.text = [NSString stringWithFormat:@"%@",[[XMSDKPlayer sharedPlayer]currentTrack].trackTitle];
    
//   [[XMSDKPlayer sharedPlayer]currentTrack].trackTags
//    trackIntro;
//   trackTags;
//   trackTitle;
    
    
    NSLog(@"-----111%@",[[XMSDKPlayer sharedPlayer]currentTrack].trackIntro);
    NSLog(@"-----222%@",[[XMSDKPlayer sharedPlayer]currentTrack].trackTags);
    NSLog(@"-----333%@",[[XMSDKPlayer sharedPlayer]currentTrack].trackTitle);
    
    
    NSString *ALLtheDate =[NSString stringWithFormat:@"%ld", (long)[[XMSDKPlayer sharedPlayer]currentTrack].duration];
    //
    NSTimeInterval ALLtime=[ALLtheDate doubleValue];
    //+28800;//因为时差问题要加8小时 == 28800 sec
    //  NSTimeInterval time=[theDate doubleValue];
    NSDate *ALLdetaildate=[NSDate dateWithTimeIntervalSince1970:ALLtime];
    //    //    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *ALLdateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [ALLdateFormatter setDateFormat:@"mm:ss"];
    
    NSString *ALLcurrentDateStr = [ALLdateFormatter stringFromDate:ALLdetaildate];
    TimeAllLabel.text = [NSString stringWithFormat:@"%@",ALLcurrentDateStr];
    
    
    
    
    
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:currentSecond];
       NSLog(@"yuanhuan%f",percent);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
     [headImageV sd_setImageWithURL:[NSURL URLWithString:[[XMSDKPlayer sharedPlayer]currentTrack ].coverUrlMiddle] placeholderImage:[UIImage imageNamed:@"placeholder_disk"]];
    
    self.TimeLabel.text = [NSString stringWithFormat:@"%@",currentDateStr];

}
- (void)XMTrackPlayerDidPaused
{

    ;
    NSString *theDate =[NSString stringWithFormat:@"%ld", (long)[[XMSDKPlayer sharedPlayer]currentTrack].duration];
    //
    NSTimeInterval time=[theDate doubleValue];
    //+28800;//因为时差问题要加8小时 == 28800 sec
    //  NSTimeInterval time=[theDate doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //    //    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    
    
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
    
    
  TitleLabel =[[UILabel alloc]init];
    
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
    
    
   nameLabel =[[UILabel alloc]init];
    
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

   // [XMSDKPlayer sharedPlayer].trackPlayDelegate =nil;
    
[self dismissViewControllerAnimated:YES completion:^{
    
}];

}

@end
