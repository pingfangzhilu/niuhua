//
//  Interface.c
//  voices
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 mac. All rights reserved.
//
#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>
#include "Interface.h"
#include "netInter.h"
/*
 char * /const char *和NSString之间的转化
 
 //char * /const char * 转NSString
 NSString * strPath = [NSString stringWithUTF8String:filename];
 
 //NSString转char * /const char *
 const char * filePathChar = [filePath UTF8String];
*/



//初始化网络
int nativeInitSystem(void networkEvent(int type,char *msg,int size))
{
    initSystem(networkEvent);
    return 0;
}
//退出清理后台网络线程
void nativeCleanSystem()
{
    cleanSystem();
}
//刷新网络
int nativeUpdateNet()
{
    return updateNetwork();
}
//设置定时开机时间  格式--->时:分
int nativeOpenHostTime(char *time)
{
    return openHostTime(time);
}
//设置定时关机时间 格式--->时:分
int nativeCloseHostTime(char *time)
{
    return closeHostTime(time);
}
//对设备上锁
int nativeLockHost(){
    return lockHost();
}
//对设备解锁
int nativeUnlockHost(){
    return unlockHost();
}
//切换到播放状态
int nativeIsPlay(){
    return mplayerPlay();
}
//切换到暂停状态
int nativeIsPause(){
    return mplayerPause();
}
//切换到停止状态
int nativeIsStop(){
    return mplayerStop();
}
//加声音
int nativeAddVol(){
    return AddVol();
}
//减声音
int nativeSubVol(){
    return SubVol();
}
//设置固定声音
int nativeSetVol_Data(int vol){
    return SetVol_Data(vol);
}
//推送url到设备
int nativeMplayer(char * url){
    return mplayerPlayUrl(url);
}
//播放进度 0-99
int nativeSeekTo(int progress){
    return mplayerSeekBar(progress);
}
//设备端版本更新设置 --->0 取消 1确定更新 （注:设备端有新版本，自动通知app）
int nativeVersionUpdate(int state){
    return versionUpdate(state);
}
int nativeTestDevState(){
    return testDevices();
}
int nativeTestHostQtts(char * text){
    return testHostQtts(text);
}


typedef struct{
    void (*call)(int type,char *msg,int size);
}NetMsg;
static NetMsg *net=NULL;
static void *runSystem(void *arg)
{
    int i=0;
    for(i=0;i<5;i++){
        printf("runSystem net ... =%d\n",i);
        sleep(1);
        net->call(0,"runSystem net",10);
    }
    return NULL;
}
void initNet(void call(int type,char *msg,int size))
{
    pthread_t tid;
    printf("init net ... \n");
    net = (NetMsg *)calloc(1,sizeof(NetMsg));
    if(net==NULL){
        perror("calloc failed \n");
        return;
    }
    net->call =call;
    pthread_create(&tid,NULL,runSystem,NULL);
}

