//
//  ViewController.m
//  voices
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#include "demo_tcp.h"
#include "Interface.h"

  ViewController *OCP=nil ;
@interface ViewController ()
{
    UISlider *proView;
    UIButton *playBtn;
    NSArray *array;
    int playCount;
  
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 把指针传给他
    OCP = self;

    array =   [NSArray arrayWithObjects:
               @"http://fdfs.xmcdn.com/group7/M01/A3/8D/wKgDX1d2Rr6w3CegABHDHZzUiUs448.mp3",
               @"http://fdfs.xmcdn.com/group4/M03/A3/84/wKgDs1d2RZ_RjSxuABV9gmXQeIc233.mp3",
               @"http://fdfs.xmcdn.com/group14/M01/A2/06/wKgDZFdzNujBdVzmABboXqMK5U0551.mp3",
               @"http://fdfs.xmcdn.com/group9/M08/A1/4A/wKgDZldzNWzRoXyzACZofeFKKKc093.mp3",
               @"http://fdfs.xmcdn.com/group14/M09/9F/EA/wKgDZFdwhHSyCmBsABE4V3MaLHU408.mp3",
               @"http://fdfs.xmcdn.com/group15/M05/99/61/wKgDaFdqbLaQq4oRABBQgZsXAcA203.mp3",
                 nil];
    playCount =0;
    UILabel *playurl = [[UILabel alloc] initWithFrame:CGRectMake(90,100, 60,40)];
    playurl.userInteractionEnabled=YES;
    playurl.text = @"播放url";
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    [playurl addGestureRecognizer:labelTapGestureRecognizer];
    [self.view addSubview:playurl];
    
    
    UILabel *processLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,200, 44,20)];
    processLabel.text = @"播放";
    [self.view addSubview:processLabel];
    proView = [[UISlider alloc] initWithFrame:CGRectMake(60, 200, 240, 20)];
    //[proView setProgressViewStyle:UIProgressViewStyleDefault]; //设置进度条类型
    proView.backgroundColor = [UIColor clearColor];
    proView.thumbTintColor = [UIColor redColor];
    proView.continuous = NO;
    [self.view addSubview:proView];
    
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

    
    nativeInitSystem(ocCallBack);
    
}




-(void)initUI_play{
        
}


    void ocCallBack(int type,char *msg,int size)
    {
        NSString * strMsg = [NSString stringWithUTF8String:msg];
        

       [OCP HHHHHHP:strMsg];
        
        NSLog(@"ocInterface onclick %@\n",strMsg);
    }



- (void)HHHHHHP:(NSString *)mstring
{

[playBtn setTitle:mstring forState:UIControlStateNormal];

}

- (void)play
{
    NSLog(@"play onclick");
}

-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
    UILabel *label=(UILabel*)recognizer.view;
   if(++playCount>=array.count)
       playCount=0;
    id obj = [array objectAtIndex:playCount];
    NSLog(@"%@被点击了  url:%@\n",label.text,obj);
    if ( [obj isKindOfClass:[NSString class]] ){
        const char * geturl = [obj UTF8String];
        NSLog(@"play url =%s",geturl);
        nativeMplayer((char *)geturl);
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
