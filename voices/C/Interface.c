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
#include "cJSON.h"
/*
 char * /const char *和NSString之间的转化
 
 //char * /const char * 转NSString
 NSString * strPath = [NSString stringWithUTF8String:filename];
 
 //NSString转char * /const char *
 const char * filePathChar = [filePath UTF8String];
*/

static SysCall_t *sys=NULL;

Player_t *GetPlayer(void)
{
    return &sys->player;
}
Sysdata_t *GetSysdata(void)
{
    return &sys->sysdata;
}
static void parseNetworkdData(int type,char *msg,int size)
{
    printf("recv msg =%s\n",msg);
    cJSON * pJson = cJSON_Parse(msg);
    if(NULL == pJson){
        return ;
    }
    cJSON * pSub = cJSON_GetObjectItem(pJson, "handler");
    if(NULL == pSub){
        printf("get json data  failed\n");
        goto exit ;
    }
    if(!strcmp(pSub->valuestring,"host")){
        pSub= cJSON_GetObjectItem(pJson, "type");
        if(!strcmp(pSub->valuestring,"open")){
            pSub=cJSON_GetObjectItem(pJson, "time ");
            snprintf(sys->sysdata.opentime, 64, "%s",pSub->valuestring);
        }else if(!strcmp(pSub->valuestring,"close")){
            pSub=cJSON_GetObjectItem(pJson, "time ");
            snprintf(sys->sysdata.closetime, 64, "%s",pSub->valuestring);
        }
    }else if(!strcmp(pSub->valuestring,"vol")){
        sys->player.voldata=cJSON_GetObjectItem(pJson, "data")->valueint;
    }else if(!strcmp(pSub->valuestring,"lock")){
        int state= cJSON_GetObjectItem(pJson, "state")->valueint;
        if(state==0){
            sys->sysdata.lockState=0;
        }else if(state==1){
            sys->sysdata.lockState=1;
        }
    }else if(!strcmp(pSub->valuestring,"mplayer")){
        pSub= cJSON_GetObjectItem(pJson, "state");
        if(!strcmp(pSub->valuestring,"pause")){
            sys->player.playState=1;
        }else if(!strcmp(pSub->valuestring,"play")){
            sys->player.playState=0;
        }else if(!strcmp(pSub->valuestring,"stop")){
            sys->player.playState=2;
        }else if(!strcmp(pSub->valuestring,"switch")){
            sys->player.playState=0;
        }
        sys->player.progress=cJSON_GetObjectItem(pJson, "progress")->valueint;
        if(strstr(msg,"lock")){
            sys->sysdata.lockState =cJSON_GetObjectItem(pJson, "lock")->valueint;
        }
        if(strstr(msg,"vol")){
            sys->player.voldata=cJSON_GetObjectItem(pJson, "vol")->valueint;
        }
        if(strstr(msg,"url")){
            pSub=cJSON_GetObjectItem(pJson, "url");
            snprintf(sys->player.playUrl, 128, "%s",pSub->valuestring);
        }
    }else if(!strcmp(pSub->valuestring,"sys")){
        sys->sysdata.powerData =cJSON_GetObjectItem(pJson,"state")->valueint;
        sys->sysdata.power =cJSON_GetObjectItem(pJson,"power")->valueint;
        pSub =cJSON_GetObjectItem(pJson,"openTime");
        snprintf(sys->sysdata.closetime, 64, "%s",pSub->valuestring);
        pSub =cJSON_GetObjectItem(pJson,"closeTime");
        snprintf(sys->sysdata.closetime, 64, "%s",pSub->valuestring);
    }else if(!strcmp(pSub->valuestring,"battery")){
        sys->sysdata.powerData =cJSON_GetObjectItem(pJson,"state")->valueint;
        sys->sysdata.power =cJSON_GetObjectItem(pJson,"power")->valueint;
    }else if(!strcmp(pSub->valuestring,"newImage")){
        int version =cJSON_GetObjectItem(pJson,"version")->valueint;
        char *status =cJSON_GetObjectItem(pJson,"status")->valuestring;
        if(!strcmp(status, "unkown")){//接收到新的更新设备版本请求
        }else if(!strcmp(status, "start")){//开始下载
        }else if(!strcmp(status, "error")){//下载错误
        }else if(!strcmp(status, "progress")){//下载进度
        }
    }else if(!strcmp(pSub->valuestring,"TestNet")){
        char *status =cJSON_GetObjectItem(pJson,"status")->valuestring;
        if(!strcmp(status, "timeout")){
        }else if(!strcmp(status, "ok")){
        }
    }
    sys->networkEvent(1,"",10);
exit:
    cJSON_Delete(pJson);
    return ;
}




//初始化网络
int nativeInitSystem(void networkEvent(int type,char *msg,int size))
{
    sys = (SysCall_t *)calloc(1, sizeof(SysCall_t));
    if(sys==NULL){
        perror("calloc sys failed \n");
        return -1;
    }
    sys->networkEvent =networkEvent;
    initSystem(parseNetworkdData);
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

