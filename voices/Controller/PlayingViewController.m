//
//  PlayingViewController.m
//  voices
//
//  Created by mac on 16/9/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PlayingViewController.h"
#import "XMSDKPlayer.h"
#import <AVFoundation/AVFoundation.h>
#include "Interface.h"

@interface PlayingViewController ()
{
    UISlider *proView;
    UISlider *cacheView;
    UISlider *volumeView;
    
    UIButton *playBtn;
    UIButton *pauseBtn;
    UIButton *stopBtn;
    UIButton *preBtn;
    UIButton *nextBtn;
    
    double proValue;
    double cacheValeue;
    
    NSTimer *timer;
}
@end

@implementation PlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.track.trackTitle;
    
    UILabel *cacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,150, 45,20)];
    cacheLabel.text = @"缓冲";
    [self.view addSubview:cacheLabel];
    cacheView = [[UISlider alloc] initWithFrame:CGRectMake(60, 150, 240, 20)];
    cacheView.userInteractionEnabled = NO;
    [self.view addSubview:cacheView];
    
    UILabel *processLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,200, 44,20)];
    processLabel.text = @"播放";
    [self.view addSubview:processLabel];
    proView = [[UISlider alloc] initWithFrame:CGRectMake(60, 200, 240, 20)];
    //[proView setProgressViewStyle:UIProgressViewStyleDefault]; //设置进度条类型
    proView.backgroundColor = [UIColor clearColor];
    proView.thumbTintColor = [UIColor redColor];
    proView.continuous = NO;
    [self.view addSubview:proView];
    
    UILabel *volumeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,250, 44,20)];
    volumeLabel.text = @"音量";
    [self.view addSubview:volumeLabel];
    volumeView = [[UISlider alloc] initWithFrame:CGRectMake(60, 250, 240, 20)];
    //[proView setProgressViewStyle:UIProgressViewStyleDefault]; //设置进度条类型
    [self.view addSubview:volumeView];
    
    playBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    playBtn.frame = CGRectMake(60, 300, 60, 30);
    playBtn.backgroundColor = [UIColor clearColor];
    [playBtn setTitle:@"play" forState:UIControlStateNormal];
    [playBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//设置标题颜色
    [playBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal ];//阴影
    [playBtn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [playBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [playBtn.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
    [playBtn.layer setBorderColor:colorref];//边框颜色
    CFRelease(colorref);
    [self.view addSubview:playBtn];
    
    pauseBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    pauseBtn.frame = CGRectMake(160, 300, 60, 30);
    pauseBtn.backgroundColor = [UIColor clearColor];
    [pauseBtn setTitle:@"pause" forState:UIControlStateNormal];
    [pauseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//设置标题颜色
    [pauseBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal ];//阴影
    [pauseBtn addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [pauseBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [pauseBtn.layer setBorderWidth:1.0]; //边框宽度
    [pauseBtn.layer setBorderColor:colorref];//边框颜色
    [self.view addSubview:pauseBtn];
    
    stopBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    stopBtn.frame = CGRectMake(260, 300, 60, 30);
    stopBtn.backgroundColor = [UIColor clearColor];
    [stopBtn setTitle:@"stop" forState:UIControlStateNormal];
    [stopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//设置标题颜色
    [stopBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal ];//阴影
    [stopBtn addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [stopBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [stopBtn.layer setBorderWidth:1.0]; //边框宽度
    [stopBtn.layer setBorderColor:colorref];//边框颜色
    [self.view addSubview:stopBtn];
    
    preBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    preBtn.frame = CGRectMake(80, 380, 60, 30);
    preBtn.backgroundColor = [UIColor clearColor];
    [preBtn setTitle:@"pre" forState:UIControlStateNormal];
    [preBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//设置标题颜色
    [preBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal ];//阴影
    [preBtn addTarget:self action:@selector(playPreTrack) forControlEvents:UIControlEventTouchUpInside];
    [preBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [preBtn.layer setBorderWidth:1.0]; //边框宽度
    [preBtn.layer setBorderColor:colorref];//边框颜色
    [self.view addSubview:preBtn];
    
    nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextBtn.frame = CGRectMake(180, 380, 60, 30);
    nextBtn.backgroundColor = [UIColor clearColor];
    [nextBtn setTitle:@"next" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//设置标题颜色
    [nextBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal ];//阴影
    [nextBtn addTarget:self action:@selector(playNextTrack) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [nextBtn.layer setBorderWidth:1.0]; //边框宽度
    [nextBtn.layer setBorderColor:colorref];//边框颜色
    [self.view addSubview:nextBtn];
    
    XMSDKPlayer *player = [XMSDKPlayer sharedPlayer];
    
    [player setAutoNexTrack:YES];
    player.trackPlayDelegate = self;
    player.livePlayDelegate = self;
    
    [proView addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [volumeView addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    volumeView.value = 0.5;
    [[XMSDKPlayer sharedPlayer] setVolume:0.5];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [XMSDKPlayer sharedPlayer].trackPlayDelegate = nil;
    [XMSDKPlayer sharedPlayer].livePlayDelegate = nil;
    
}

-(void)sliderValueChanged:(id)sender
{
    if(sender == proView)
    {
        if(self.trackList.count){
            NSInteger second = [XMSDKPlayer sharedPlayer].currentTrack.duration*proView.value;
            //            NSLog(@"seek to %ld   total : %ld",(long)second,(long)[XMSDKPlayer sharedPlayer].currentTrack.duration);
            [[XMSDKPlayer sharedPlayer] seekToTime:second];
            
            //            if (proView.value == 1.0) {
            //                [[XMSDKPlayer sharedPlayer] pauseTrackPlay];
            //            }
        }
        else if (self.radioSchedule){
            //XMRadioSchedule *tmp = [XMSDKPlayer sharedPlayer].currentPlayingProgram;
            NSInteger second = [XMSDKPlayer sharedPlayer].currentPlayingProgram.duration*proView.value;
            [[XMSDKPlayer sharedPlayer] seekHistoryLivePlay:second];
        }
    }
    else if(sender == volumeView)
    {
        [[XMSDKPlayer sharedPlayer] setVolume:volumeView.value];
    }
    
    //    NSLog(@"volume valuechange---%f", [XMPlayer sharedPlayer].volume);
    //    NSLog(@"sdkplayervolume valuechange---%f", [XMSDKPlayer sharedPlayer].sdkPlayerVolume);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)play
{
    //NSString转char * /const char *
    const char * playurl = [self.track.playUrl32 UTF8String];
    int ret =nativeMplayer((char *)playurl);
    printf("ret = %d playurl = %s\n ",ret,playurl);
    return ;
//    NSLog(@"self.track.playUrl32 =%@ coverUrlSmall =%@\n",self.track.playUrl32,self.track.coverUrlSmall);
    if(self.trackList.count){
        
        proView.value = 0.0;
        cacheView.value = 0.0;
        [[XMSDKPlayer sharedPlayer] setPlayMode:XMSDKPlayModeTrack];
        [[XMSDKPlayer sharedPlayer] setTrackPlayMode:XMTrackPlayerModeList];
        [[XMSDKPlayer sharedPlayer] playWithTrack:self.track playlist:self.trackList];
    }
    else if(self.radio){
        [[XMSDKPlayer sharedPlayer] setPlayMode:XMSDKPlayModeLive];
        [[XMSDKPlayer sharedPlayer] startLivePlayWithRadio:self.radio];
    }
    else if (self.radioSchedule){
        [[XMSDKPlayer sharedPlayer] setPlayMode:XMSDKPlayModeLive];
        [[XMSDKPlayer sharedPlayer] startHistoryLivePlayWithRadio:nil withProgram:self.radioSchedule inProgramList:self.programList];
    }
    
}

- (void)pause
{
    if(self.trackList.count){
        [[XMSDKPlayer sharedPlayer] pauseTrackPlay];
    }
    else if(self.radio){
        [[XMSDKPlayer sharedPlayer] pauseLivePlay];
    }
    else if (self.radioSchedule){
        [[XMSDKPlayer sharedPlayer] pauseLivePlay];
    }
}

-(void)stop
{
    if(self.trackList.count){
        [[XMSDKPlayer sharedPlayer] stopTrackPlay];
    }
    else if(self.radio){
        [[XMSDKPlayer sharedPlayer] stopLivePlay];
    }
    else if (self.radioSchedule){
        [[XMSDKPlayer sharedPlayer] stopLivePlay];
    }
    proView.value = 0.0;
    cacheView.value = 0.0;
}

-(void)playPreTrack
{
    proView.value = 0.0;
    cacheView.value = 0.0;
    if(self.trackList.count){
        [[XMSDKPlayer sharedPlayer] playPrevTrack];
    }
    else if(self.radio){
        //[[XMSDKPlayer sharedPlayer] pauseLivePlay];
    }
    else if (self.radioSchedule){
        [[XMSDKPlayer sharedPlayer] playPreProgram];
    }
}

- (void)playNextTrack
{
    proView.value = 0.0;
    cacheView.value = 0.0;
    
    if(self.trackList.count){
        [[XMSDKPlayer sharedPlayer] playNextTrack];
    }
    else if(self.radio){
        //[[XMSDKPlayer sharedPlayer] pauseLivePlay];
    }
    else if (self.radioSchedule){
        [[XMSDKPlayer sharedPlayer] playNextProgram];
    }
}

- (void)XMTrackPlayNotifyProcess:(CGFloat)percent currentSecond:(NSUInteger)currentSecond
{
    //        LOGCA(@"percent: %f, second: %d", percent, currentSecond);
    proView.value = percent;
    //    NSLog(@"percent: %f, second: %lu", percent, (unsigned long)currentSecond);
}

- (void)XMTrackPlayNotifyCacheProcess:(CGFloat)percent
{
    cacheView.value = percent;
}

//- (void)player:(XMPlayer *)player notifyCacheProcess:(CGFloat)percent
//{
//    //_progressPane.processBar.cacheValue = percent;
//}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)XMTrackPlayerDidStart
{
    self.title = [[XMSDKPlayer sharedPlayer] currentTrack].trackTitle;
    
    //    NSLog(@"volume didstart---%f", [XMPlayer sharedPlayer].volume);
    //    NSLog(@"sdkplayervolume didstart---%f", [XMSDKPlayer sharedPlayer].sdkPlayerVolume);
    NSLog(@"playstate play %ld", (long)[[XMSDKPlayer sharedPlayer] playerState]);
    
}

- (void)XMTrackPlayerDidPaused
{
    NSLog(@"playstate pause %ld", (long)[[XMSDKPlayer sharedPlayer] playerState]);
}

- (void)XMTrackPlayerDidStopped
{
    NSLog(@"playstate stop %ld", (long)[XMSDKPlayer sharedPlayer].playerState);
}

- (void)XMTrackPlayerDidFailedToPlayTrack:(XMTrack *)track withError:(NSError *)error;
{
    NSLog(@"Play track failed due to error:%ld, %@, %@", (long)error.code, error.domain, error.userInfo[NSLocalizedDescriptionKey]);
}

- (BOOL)XMTrackPlayerShouldContinueNextTrackWhenFailed:(XMTrack *)track
{
    return NO;
}


#pragma mark - live radio

//- (void)XMLiveRadioPlayerDidFailWithError:(NSError *)error;

- (void)XMLiveRadioPlayerNotifyCacheProgress:(CGFloat)percent
{
    cacheView.value = percent;
}

- (void)XMLiveRadioPlayerNotifyPlayProgress:(CGFloat)percent currentTime:(NSInteger)currentTime
{
    proView.value = percent;
}

//- (void)XMLiveRadioPlayerDidEnd;
//
//- (void)XMLiveRadioPlayerDidPaused;
//
//- (void)XMLiveRadioPlayerDidPlaying;
//
- (void)XMLiveRadioPlayerDidStart
{
    if (self.radio) {
        self.title = [[XMSDKPlayer sharedPlayer] currentPlayingRadio].radioName;
    }
    else{
        self.title = [[XMSDKPlayer sharedPlayer] currentPlayingProgram].relatedProgram.programName;
    }
}
//
//- (void)XMLiveRadioPlayerDidStopped;
//
//- (void)XMLivePlayerWillPlaying;
//
//- (void)XMLivePlayerDidDataBufferStart;
//
//- (void)XMLivePlayerDidDataBufferEnd;

@end
