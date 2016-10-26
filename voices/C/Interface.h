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
#include "netInter.h"

typedef struct{
    char opentime[64];              //定时开机时间
    char closetime[64];             //定时关机时间
    unsigned char lockState;        //设备上锁情况
    unsigned char netState;         //网络状态
    int powerData;                  //电量值
    int power;                      //充电状态
    
}Sysdata_t;;

typedef struct {
    void (*networkEvent)(int type,char *msg,int size);
    Sysdata_t sysdata;
    Mplayer_t * player;
}SysCall_t;

//#define VOL_EVENT       0x10
//#define LOCK_EVENT      0x11
//#define PLAY_EVENT      0x12
//#define SYS_EVENT       0x13        //系统消息
//#define HOST_EVENT      0x14        //定时开关机
//#define BATTERY_EVENT   0x15        //电池电量


#define SYS_EVENT           0x01        //系统事件
#define PLAY_EVENT          0x02        //播放事件
#define NETWORK_EVENT       0x03        //网络状态

extern Sysdata_t *nativeGetSysdata(void);
extern Mplayer_t *nativeGetPlayer(void);

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
extern int nativeMplayer(const char * url,const char *name,int muisctime);	//推送url到设备
extern int nativeSeekTo(int progress);	//播放进度 0-99
extern int nativeVersionUpdate(int state);  //设备端版本更新设置 --->0 取消 1确定更新 （注:设备端有新版本，自动通知app）

extern int nativeTestDevState();
extern int nativeTestHostQtts(char* text);

extern void initNet(void call(int type,char *msg,int size));


#endif /* Interface_h */
