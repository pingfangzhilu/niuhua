//
//  Interface.h
//  voices
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#ifndef Interface_h
#define Interface_h

#include <stdio.h>

typedef struct{
    char playUrl[128];  //当前播放url
    int voldata;        //音量大小
    int playState;      //当前播放状态 0 暂停 1 播放
    int progress;       //播放的进度值
}Player_t;

typedef struct{
    char opentime[64];  //定时开机时间
    char closetime[64]; //定时关机时间
    int lockState;      //设备上锁情况
    int powerData;      //电量值
    int power;          //充电状态
}Sysdata_t;;

typedef struct {
    void (*networkEvent)(int type,char *msg,int size);
    Player_t player;
    Sysdata_t sysdata;
}SysCall_t;


Player_t *GetPlayer(void);
Sysdata_t *GetSysdata(void);
extern int nativeInitSystem(void networkEvent(int type,char *msg,int size));		//初始化网络
extern void nativeCleanSystem();		//退出清理后台网络线程
extern int nativeUpdateNet();			//刷新网络

extern int nativeOpenHostTime(char * time);//设置定时开机时间  格式--->时:分
extern int nativeCloseHostTime(char * time);//设置定时关机时间 格式--->时:分
extern int nativeLockHost();			//对设备上锁
extern int nativeUnlockHost();		//对设备解锁

extern int nativeIsPlay();			//切换到播放状态
extern int nativeIsPause();			//切换到暂停状态
extern int nativeIsStop();			//切换到停止状态
extern int nativeAddVol();			//加声音
extern int nativeSubVol();			//减声音
extern int nativeSetVol_Data(int vol);//设置固定声音
extern int nativeMplayer(char * url);	//推送url到设备
extern int nativeSeekTo(int progress);	//播放进度 0-99
extern int nativeVersionUpdate(int state);  //设备端版本更新设置 --->0 取消 1确定更新 （注:设备端有新版本，自动通知app）

extern int nativeTestDevState();
extern int nativeTestHostQtts(char* text);

extern void initNet(void call(int type,char *msg,int size));


#endif /* Interface_h */
