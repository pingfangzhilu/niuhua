//
//  WSTabBarController.m
//  voices
//
//  Created by pc on 16/10/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WSTabBarController.h"
#import "MainViewController.h"


WSTabBarController *OCP=nil ;
@implementation WSTabBarController
{

 BOOL isOpen;

}


void ocCallBack(int type,char *msg,int size)
{
    printf("type = %d\n",type);
    
    [OCP ocCallMsg:type];
}
/**char * /const char *和NSString之间的转化
 
 //char * /const char * 转NSString
 NSString * strPath = [NSString stringWithUTF8String:filename];
 
 //NSString转char * /const char *
 const char * filePathChar = [filePath UTF8String];*/


- (void)text:(NSString *)textString Time:(int )TimeBase  playState:(int)State
{
//self.markStringSele = @"yes";
 NSLog(@"valuevaluevaluevaluevaluevalue%d",TimeBase);
    dispatch_async(dispatch_get_main_queue(), ^{
         _BottomLabel.text =[NSString stringWithFormat:@"%@",textString];
        _BottomSlider.value = TimeBase;
        //  1  是开始    2 是暂停        3 停止 （timebase大于95 ）切换下一首
        if (State==1) {
            NSLog(@"开始");
//
//              self.markStringSele.selected =_BottomBtn.selected;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [self BottomBtn:_BottomBtn];
            });
             _BottomBtn.selected=YES;
        }
        else if(State==2)
        {
            NSLog(@"暂停");
            _BottomBtn.selected =NO;
//               self.markStringSele.selected =_BottomBtn.selected;
            
        }else if (State==0)
        {
         _BottomBtn.selected =NO;
            if (TimeBase>95) {
                
                [self ShebiNext];
                
                
            }
            
        }
      else
      {
      
      
      
      }
        
//
//       [self BottomBtn:_BottomBtn];
        
//      self.BottomBtn.selected =!self.BottomBtn.selected;
    });
    NSLog(@"777------888888%@",textString);
}





- (void)ocCallMsg:(int)type
{
//     [self BottomView];
    
    if (type==SYS_EVENT) {
        Sysdata_t *sys = nativeGetSysdata();
        
        NSDictionary *dict = @{@"leftpower":[NSString stringWithFormat:@"%d",sys->power],@"leftpowerData":[NSString stringWithFormat:@"%d",sys->powerData],@"leftlockState":[NSString stringWithFormat:@"%d",sys->lockState]};
        
        NSNotification *notification =[NSNotification notificationWithName:@"leftUIredata" object:nil userInfo:dict];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
//        sys->power;
        printf("电量。。。。＝－－－－－play->name = %d\n",sys->powerData);
        
    }else if(type==PLAY_EVENT){
        Mplayer_t * play = nativeGetPlayer();
        printf("play->playState = %d\n",play->playState);
        printf("名字歌啊。。。。＝－－－－－play->name = %s\n",play->musicName);
        printf("时间：：：：%d\n",play->snycSeekBar);
//        play->voldata;

//        self.BottomSlider.value  =play->progress;
        NSString * strPath = [NSString stringWithUTF8String:play->musicName];

        
        [OCP text:strPath Time:play->snycSeekBar playState:(int)play->playState];
        
        
    }else{      //NETWORK_EVENT
        
         Sysdata_t *sys = nativeGetSysdata();
       
        printf("%d\n",sys->netState);
        NSString *StrShebi = [NSString stringWithFormat:@"%d",sys->netState];
        
        NSLog(@"=====================================%@",StrShebi);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shebiyunxing" object:StrShebi];
           switch (sys->netState) {
            case 0:
            {
                
                [OCP shuanxinBottomLabel];
                
            }
                
                break;
                  case 1:
               {
               
                 [OCP BottomUIData];
               
               }
                   
                    break;
                
            default:
                break;
        }
        
    }
    
    
    
    //    sys->
}


- (void)shuanxinBottomLabel
{
dispatch_async(dispatch_get_main_queue(), ^{
      _BottomLabel.text = @"设备未连接";
});

}


- (void)BottomUIData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _BottomLabel.text = @"设备连接正常";
    });


}




#define currentWindow  [UIApplication sharedApplication].keyWindow
- (void)viewDidLoad
{
    [super viewDidLoad];
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(BottomLabelUI:) name:@"BottomLabel" object:nil];
    VVVVVVV=0;
    OCP =self;
   
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
    
    
      isOpen = NO;
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    
    swipeGesture.direction =UISwipeGestureRecognizerDirectionUp;
    
    [self.myView addGestureRecognizer:swipeGesture];
    
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
    
nativeInitSystem(ocCallBack);
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shebiUrl:) name:@"shebiUrl" object:nil];
    
}

- (void)shebiUrl:(NSNotification *)notif
{

//    _PlayUrlData 
    self.PlayUrlData = (NSMutableArray *)notif.userInfo[@"shebiData"];
    
   
    self.PlayURLindex = [(NSString *)notif.userInfo[@"shebiTwo"]  integerValue];
    
  

}

- (NSMutableArray *)PlayUrlData
{
    if (!_PlayUrlData) {
        _PlayUrlData =[NSMutableArray array];
    }

    return _PlayUrlData;

}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [XMSDKPlayer sharedPlayer].trackPlayDelegate=self;


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
    
    self.PlayBtn.selected = NO;
    [self PlayBtn:self.PlayBtn];
   
    
//    [[XMSDKPlayer sharedPlayer] setPlayMode:XMSDKPlayModeTrack];
//    
//    [[XMSDKPlayer sharedPlayer] setTrackPlayMode:XMTrackPlayerModeEnd];
//    [[XMSDKPlayer sharedPlayer] playWithTrack:self.track playlist:self.AllDataArray];
//
//    self.PlayBtn.selected =YES;
//    self.PlayBtn.selected = !self.PlayBtn.selected;

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
    
    
//    self.NameLabel.center =self.myView.center;
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


- (void)swipeGesture:(UISwipeGestureRecognizer *)tap
{
    
    NSLog(@"滑动");
    //移动结束
    
    [self BottomView];
  
    _BottomBackView.hidden =NO;
    [UIView animateWithDuration:0.5 animations:^{
       _BottomView.frame =CGRectMake(0, currentWindow.frame.size.height-200, currentWindow.frame.size.width, 200);    }];
    
}

- (void)swipeGestureBottom:(UISwipeGestureRecognizer *)tap
{

    [UIView animateWithDuration:0.5 animations:^{
        
//        [self.BottomBackView removeFromSuperview];
       _BottomBackView.hidden =YES;
        _BottomView.frame =CGRectMake(0, currentWindow.frame.size.height, currentWindow.frame.size.width, 200);    }];


}


 - (void)BottomViewUIV
{
    self.BottomBackView =[[UIView alloc]init];
    
    self.BottomBackView.backgroundColor =[UIColor blackColor];
    
    self.BottomBackView.alpha =0.6;
    
    self.BottomBackView.hidden =YES;
    
    [currentWindow addSubview:self.BottomBackView];
    [self.BottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.edges.equalTo(currentWindow).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
        
    }];
    
    self.BottomView =[[UIView alloc]init];
    self.BottomView.frame =CGRectMake(0, currentWindow.frame.size.height, currentWindow.frame.size.width, 200);
    
    self.BottomView.backgroundColor =[UIColor grayColor];
    [currentWindow addSubview:self.BottomView];
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureBottom:)];
    
    swipeGesture.direction =UISwipeGestureRecognizerDirectionDown;
    
    [self.BottomView addGestureRecognizer:swipeGesture];
    




}






- (UIView *)BottomBackView
{
    if (!_BottomBackView) {
        
       _BottomBackView =[[UIView alloc]init];
        
        _BottomBackView.backgroundColor =[UIColor blackColor];
        
        _BottomBackView.alpha =0.6;
        
        _BottomBackView.hidden =YES;
        
        [currentWindow addSubview:self.BottomBackView];
        [_BottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.edges.equalTo(currentWindow).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            
            
        }];

        
        
        
        
    }



    return _BottomBackView;

}


- (UIView *)BottomView
{
    [self BottomBackView];
    
    if (!_BottomView) {
        
        _BottomView =[[UIView alloc]init];
        _BottomView.frame =CGRectMake(0, currentWindow.frame.size.height, currentWindow.frame.size.width, 200);
        
        _BottomView.backgroundColor =[UIColor grayColor];
        [currentWindow addSubview:_BottomView];
        UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureBottom:)];
        
        swipeGesture.direction =UISwipeGestureRecognizerDirectionDown;
        
        [_BottomView addGestureRecognizer:swipeGesture];
        
        
      
        [self BottomLabel];
        [self BottomName];
        [self BottomSlider];
        [self BottomBtn];
        
        [self BottomNextBtn];
        [self BottomUpBtn];
    }
    return _BottomView;


}





- (UILabel *)BottomLabel
{
    if (!_BottomLabel) {
        _BottomLabel =[[UILabel alloc]init];
        
        _BottomLabel.font =[UIFont systemFontOfSize:15];
//             self.BottomLabel.text = @"设备未连接";
        
        _BottomLabel.textAlignment =NSTextAlignmentCenter;
        
       _BottomLabel.textColor =[UIColor whiteColor];
        
        [self.BottomView addSubview:_BottomLabel];
        
        [_BottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.left.equalTo(self.BottomView.mas_left).with.offset(10);
            make.right.equalTo(self.BottomView.mas_right).with.offset(-10);
            make.top.equalTo(self.BottomView.mas_top).with.offset(5);
            
            
            
        }];

    }


    return _BottomLabel;

}

- (UISlider *)BottomSlider
{
    if (!_BottomSlider) {

        
        _BottomSlider =[[UISlider alloc]init];
       _BottomSlider.thumbTintColor = [UIColor redColor];
        _BottomSlider.continuous =NO;
        _BottomSlider.minimumValue =0;
        _BottomSlider.maximumValue=99;
        
//        _BottomSlider.value =80;
        [self.BottomView addSubview:_BottomSlider];
       
        
        [_BottomSlider addTarget:self action:@selector(updateValue) forControlEvents:UIControlEventValueChanged];
        [_BottomSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.left.equalTo(self.BottomView.mas_left).with.offset(20);
            make.right.equalTo(self.BottomView.mas_right).with.offset(-20);
            make.height.equalTo(@20);
            make.top.equalTo(self.BottomName.mas_bottom).with.offset(20);
            
            
        }];
        
          
        
    }

    return _BottomSlider;

}


- (void)updateValue
{

    NSLog(@"-----------%f",_BottomSlider.value);

    
    nativeSeekTo((int)_BottomSlider.value);
    
}


- (UILabel *)BottomName
{
    if (!_BottomName) {
        _BottomName =[[UILabel alloc]init];
      _BottomName.textColor =[UIColor whiteColor];
       _BottomName.text =@"糍粑糖";
        _BottomName.textAlignment=NSTextAlignmentCenter;
        [_BottomView addSubview:_BottomName];
        
        [_BottomName mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(_BottomView.mas_left).with.offset(10);
            make.right.equalTo(_BottomView.mas_right).with.offset(-10);
            make.height.equalTo(@20);
            make.top.equalTo(_BottomLabel.mas_bottom).with.offset(15);
            
        }];
        
        
        
        
    }
    return _BottomName;



}
- (UIButton *)BottomBtn
{
    if (!_BottomBtn) {
        
        _BottomBtn =[[UIButton alloc]init];
        
        [_BottomBtn setImage:[UIImage imageNamed:@"ic_notify_play_normal"] forState:UIControlStateNormal];
        [_BottomBtn setImage:[UIImage imageNamed:@"ic_notify_pause_normal"] forState:UIControlStateSelected];
        [_BottomBtn addTarget:self action:@selector(BottomBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [_BottomView addSubview:_BottomBtn];
        
        [_BottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(_BottomView.mas_centerX);
            make.top.equalTo(_BottomSlider.mas_bottom).with.offset(30);
            make.width.and.height.equalTo(@40);
            
        }];
        

        
        
    }

    return _BottomBtn;

}
- (UIButton *)BottomNextBtn
{
    if (!_BottomNextBtn) {
        _BottomNextBtn =[[UIButton alloc]init];
        
        
         [_BottomNextBtn setImage:[UIImage imageNamed:@"next_icon_transparent_pressed"] forState:UIControlStateNormal];
        [_BottomNextBtn addTarget:self action:@selector(ShebiNext) forControlEvents:UIControlEventTouchUpInside];
        //next_icon_transparent_pressed
         [_BottomView addSubview:_BottomNextBtn];
        
        [_BottomNextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(_BottomBtn.mas_right).with.offset(40);
            make.top.equalTo(_BottomSlider.mas_bottom).with.offset(30);
            make.width.and.height.equalTo(@40);
            
        }];
        
        
    }
    
    return _BottomNextBtn;
    
}
- (void)ShebiNext
{
    
    if (_PlayURLindex  <self.PlayUrlData.count ){
        
        _PlayURLindex = _PlayURLindex+1;
        
        self.track = self.PlayUrlData[_PlayURLindex];
        
        const char * playurl = [self.track.playUrl32 UTF8String];
        const char * name = [self.track.trackTitle UTF8String];
        
        
        int ret =nativeMplayer((char *)playurl,name,(int)self.track.duration);
        
        NSLog(@"推送下一首名字%@",self.track.trackTitle);
        
        printf("ret = %d playurl = %s\n ",ret,playurl);
        return ;

        
    }
    
   
    
    
    

}


- (void)shebiShangyishou
{

    if (_PlayURLindex  >0 ){
        _PlayURLindex = _PlayURLindex-1;
        self.track = self.PlayUrlData[_PlayURLindex ];
        
        const char * playurl = [self.track.playUrl32 UTF8String];
        const char * name = [self.track.trackTitle UTF8String];
        
        
        int ret =nativeMplayer((char *)playurl,name,(int)self.track.duration);
        
        NSLog(@"推送上一首名字%@",self.track.trackTitle);
        
        printf("ret = %d playurl = %s\n ",ret,playurl);
        return ;
        
        
    }


}



- (UIButton *)BottomUpBtn
{

    if (!_BottomUpBtn) {
        
        _BottomUpBtn =[[UIButton alloc]init];
        
        
        [_BottomUpBtn setImage:[UIImage imageNamed:@"pre_icon_transparent_pressed"] forState:UIControlStateNormal];
        [_BottomUpBtn addTarget:self action:@selector(shebiShangyishou) forControlEvents:UIControlEventTouchUpInside];
        //next_icon_transparent_pressed
        [_BottomView addSubview:_BottomUpBtn];
        
        [_BottomUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(_BottomBtn.mas_left).with.offset(-40);
            make.top.equalTo(_BottomSlider.mas_bottom).with.offset(30);
            make.width.and.height.equalTo(@40);
            
        }];

        
        
    }
    return _BottomUpBtn;


}









- (void)BottomBtn:(UIButton *)Btn
{

    NSLog(@"按下");

    if (!self.BottomBtn.selected) {
         nativeIsPlay();			//切换到播放状态
        
        
    }
    else
    {
   
    nativeIsPause();
        
    }
    
    self.BottomBtn.selected =!self.BottomBtn.selected;
   
}


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
//    [self.NameLabel setText:[[XMSDKPlayer sharedPlayer] currentTrack].trackTitle];
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




//-(UIView *)PLayBigView
//{
//    if (!_PLayBigView) {
//        
//        _PLayBigView =[[UIView alloc]init];
//        _PLayBigView.backgroundColor =[UIColor grayColor];
//        _PLayBigView.frame =CGRectMake(0, 0, -self.view.frame.size.height, self.view.frame.size.width);
//        
//        [currentWindow addSubview:_PLayBigView];
//        
//        
//    }
//    
//    return _PLayBigView;
//    
//    
//    
//}
//
//- (UIButton *)playViewBackBtn
//{
//    if (!_playViewBackBtn) {
//        
//        _playViewBackBtn =[[UIButton alloc]init];
//        [_playViewBackBtn addTarget:self action:@selector(playViewBackBtn) forControlEvents:UIControlEventTouchUpInside];
//        
//        [_playViewBackBtn setImage:[UIImage imageNamed:@"taobao_xp_hl_ewall_back_normal副本"] forState:UIControlStateNormal];
//        [_PLayBigView addSubview:_playViewBackBtn];
//        [_playViewBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_PLayBigView.mas_left).with.offset(5);
//            make.top.equalTo(self.view.mas_top).with.offset(20);
//            make.width.equalTo(@50);
//            make.height.equalTo(@40);
//        }];
//        
//        
//        
//    }
//
//    return _playViewBackBtn;
//
//}




@end
