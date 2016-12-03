#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <limits.h>
#include <signal.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <unistd.h>
#include <fcntl.h>
#include <assert.h>
#include <netinet/tcp.h>

#include "debug.h"

#ifdef IOS
#include "udp_sock.h"
#include "cJSON.h"
#include "pool.h"
#include "demo_tcp.h"
#include "queWorkCond.h"
#include "netInter.h"
#else
#include "base/udp_sock.h"
#include "base/cJSON.h"
#include "base/pool.h"
#include "base/demo_tcp.h"
#include "base/queWorkCond.h"
#include "netInter.h"
#endif
#include "netInter.h"

typedef struct{
    unsigned char quit;
    unsigned char menusync;
    unsigned char workState;
    char serverip[16];
    int port;
    int sockfd;
    int maxsock;
    void (*networkEvent)(int type,char *msg,int size);
    int broSock;
    struct sockaddr_in broaddr;
    WorkQueue *Nlist;
    int timeout;
    unsigned char sendsign;
}NetServer_t;

typedef struct{
    char buf[1500];
    int sockfd;
}NetMsg_t;

#define REPORT_PROGRESS 1   //上报进度条
#define SYNC_DEVICES    2   //同步设备状态

static NetServer_t *Net=NULL;
Mplayer_t *player=NULL;

static void getServerIp(void);

static int __sendto(char *msg,int size,struct sockaddr_in *dest){
    if(sendto(Net->broSock, msg,size , 0,(struct sockaddr*)dest, sizeof(struct sockaddr))<0)
    {
        return -1;
    }
    return 0;
}
int SendBro(char *buf,int size){
    return __sendto(buf, size,&Net->broaddr);
}

static void intnet_timeout(int type){
    char* szJSON = NULL;
    cJSON* pItem = NULL;
    pItem = cJSON_CreateObject();
    switch(type){
        case INTNET_FAILED:
            cJSON_AddStringToObject(pItem, "handler", "devState");
            cJSON_AddStringToObject(pItem, "status","failed");
            break;
        case INTNET_OK:
            cJSON_AddStringToObject(pItem, "handler", "devState");
            cJSON_AddStringToObject(pItem, "status","ok");
            break;
    }
    szJSON = cJSON_Print(pItem);
    Net->networkEvent(0x01,szJSON,strlen(szJSON));
    NET_DBG_WARN("intnet_timeout szJSON =%s\n",szJSON);
    cJSON_Delete(pItem);
}

int sendMsg(NetServer_t *Net,char *msg,int size){
    if(Net->sockfd<=0)
        return -1;
    int ret = (int)send(Net->sockfd,msg,size,0);
    if(ret==-1){
        NET_DBG("send msg failed \n");
    }else if(ret ==0){
        NET_DBG("send msg failed socket is close\n");
        if(Net->sockfd>0)
            close(Net->sockfd);
        Net->sockfd=-1;
        intnet_timeout(INTNET_FAILED);
    }else{
        ret=0;
        Net->sendsign=TCP_SEND;
        Net->timeout=0;
    }
    return ret;
}

static void *requestSyncState(void *arg){
    NET_DBG("requestSyncState :sockfd =%d serverip = %s port=%d\n",Net->sockfd,Net->serverip,Net->port);
    while(Net->quit){
        sleep(1);
        if(Net->menusync==SYNC_MENU_OK)
            break;
        mplayerGetState();
    }
    return NULL;
}
static int setnoblock(int sockfd,int blocking){
    int flags;
    if ((flags = fcntl(sockfd, F_GETFL)) == -1) {
        return -1;
    }
    if (blocking)
        flags &= ~O_NONBLOCK;
    else
        flags |= O_NONBLOCK;
    
    if (fcntl(sockfd, F_SETFL, flags) == -1) {
        return -1;
    }
    return 0;
}
static int SetTcpNoDelay(int sockfd) {
    int yes = 1;
    if (setsockopt(sockfd, IPPROTO_TCP, TCP_NODELAY, &yes, sizeof(yes)) == -1) {
        NET_DBG_ERROR("setsockopt(TCP_NODELAY) failed");
        return -1;
    }
    return 0;
}
#ifndef IOS
//fd:网络连接描述符
//start:首次心跳侦测包发送之间的空闲时间
 //interval:两次心跳侦测包之间的间隔时间
//count:探测次数，即将几次探测失败判定为TCP断开
int set_tcp_keepAlive(int fd, int start, int interval, int count){
    int keepAlive = 1;
    if (fd < 0 || start < 0 || interval < 0 || count < 0)
    	return -1;
    //启用心跳机制，如果您想关闭，将keepAlive置零即可
    if(setsockopt(fd,SOL_SOCKET,SO_KEEPALIVE,(void*)&keepAlive,sizeof(keepAlive)) == -1){
        perror("setsockopt");
        return -1;
    }
    //启用心跳机制开始到首次心跳侦测包发送之间的空闲时间
    if(setsockopt(fd,SOL_TCP,TCP_KEEPIDLE,(void *)&start,sizeof(start)) == -1){
        perror("setsockopt");
        return -1;
    }
    //两次心跳侦测包之间的间隔时间
    if(setsockopt(fd,SOL_TCP,TCP_KEEPINTVL,(void *)&interval,sizeof(interval)) == -1){
        perror("setsockopt");
        return -1;
    }
    //探测次数，即将几次探测失败判定为TCP断开
    if(setsockopt(fd,SOL_TCP,TCP_KEEPCNT,(void *)&count,sizeof(count)) == -1){
        perror("setsockopt");
        return -1;
    }
    return 0;
}
#endif
static void checkNetworkState(void){
    if(Net->sockfd<=0){
        if(Net->port!=0){
            Net->sockfd = create_client(Net->serverip,Net->port);
            NET_DBG("++++++++++++start connect devices+++++++++++++++++++++\n");
            if(Net->sockfd<=0){
                NET_DBG("++++++++++++ connect failed devices  clean ipaddr+++++++++++++++++++++\n");
                Net->port=0;
                memset(Net->serverip,0,sizeof(Net->serverip));
                //NET_DBG("connect server failed IP(%s) PORT(%d)\n",Net->serverip,Net->port);
                intnet_timeout(INTNET_FAILED);
                return ;
            }
            intnet_timeout(INTNET_OK);
            setnoblock(Net->sockfd,0);
            SetTcpNoDelay(Net->sockfd);
#ifndef IOS
            set_tcp_keepAlive(Net->sockfd, 5, 3, 3);
#endif
            Net->menusync=SYNC_MENU_FAILED;
            //pool_add_task(requestSyncState, NULL) ;
            Net->workState=SYNC_DEVICES;
        }else{
            intnet_timeout(INTNET_FAILED);
            getServerIp();
        }
    }
}

Mplayer_t *	GetMplayer_t(void){
    return player;
}
static int handler_CtrlMsg(int sockfd,const char *recvdata,int size){
    cJSON * pJson = cJSON_Parse(recvdata);
    if(NULL == pJson){
        return -1;
    }
    cJSON * pSub = cJSON_GetObjectItem(pJson, "handler");
    if(NULL == pSub){
        printf("get json data  failed\n");
        goto exit;
    }
    if(!strcmp(pSub->valuestring,"brocast")){	  // --------------------> brocast �㲥��ַ
        Net->networkEvent(0x01,recvdata,size);
        char *status = cJSON_GetObjectItem(pJson, "status")->valuestring;
        if(!strcmp(status,"ok")){
            char *ip =cJSON_GetObjectItem(pJson, "ip")->valuestring;
            int port = cJSON_GetObjectItem(pJson, "port")->valueint;
            sprintf(Net->serverip,"%s",ip);
            Net->port = port;
            checkNetworkState();
        }
    }else if(!strcmp(pSub->valuestring,"TestNet")){
        Net->networkEvent(0x01,recvdata,size);
    }
    else{
        int musicTime=0,progress=0;
        if(!strcmp(pSub->valuestring,"mplayer")){
            PLAY_DBG("-----------------%s\n",recvdata);
            if(cJSON_GetObjectItem(pJson, "name")!=NULL){
                snprintf(player->musicName,64,"%s",cJSON_GetObjectItem(pJson,"name")->valuestring);
                //			PLAY_DBG("play state get player->musicName ok %s\n",player->musicName);
                musicTime = cJSON_GetObjectItem(pJson, "time")->valueint;
                //			PLAY_DBG("play state get musicTime ok %d\n",musicTime);
                progress = cJSON_GetObjectItem(pJson, "progress")->valueint;
                //			PLAY_DBG("play state get progress ok %d\n",progress);
                if(musicTime!=0){	//同步时间
                    player->musicTime=musicTime;
                    if(progress==0)
                        player->curTime =progress*player->musicTime/100;
                    else	//本地播放进度相对减少一些
                        player->curTime =progress*player->musicTime/100-2;
                    PLAY_DBG("---handler play ok--- player->musicTime=%d player->curTime=%d\n",player->musicTime,player->curTime);
                }
                snprintf(player->url,128,"%s",cJSON_GetObjectItem(pJson,"url")->valuestring);
                //			PLAY_DBG("+++handler play ok+++ musicTime=%d progress=%d\n",musicTime,progress);
            }
            if(cJSON_GetObjectItem(pJson, "vol")!=NULL){
                player->voldata =cJSON_GetObjectItem(pJson, "vol")->valueint;
            }
            Net->menusync=SYNC_MENU_OK;
            char *state =cJSON_GetObjectItem(pJson, "state")->valuestring;
            if(!strcmp(state,"switch")){	//
                player->playState= MEDIA_PLAY;
            }else if(!strcmp(state,"play")){
                player->playState= MEDIA_PLAY;
                player->snycSeekBar =(unsigned char)progress;
            }else if(!strcmp(state,"pause")){
                player->playState= MEDIA_PUASE;
            }else if(!strcmp(state,"stop")){
                player->playState= MEDIA_STOP;
                player->curTime=0;
                player->snycSeekBar=0;
            }
        }
        Net->networkEvent(0x01,recvdata,size);
    }
exit:
    cJSON_Delete(pJson);
    return 0;
}
static char cacheBuf[1500]={0};
void pasredata(int sockfd,char *data,int size){
    int len =0;
    int cacheSize=strlen(cacheBuf);
    int pos=0;
    char *recvdata;
    
    if(cacheSize>0){
        recvdata = (char *)calloc(1,size+cacheSize+1);
        if(recvdata==NULL){
            return;
        }
        memcpy(recvdata,cacheBuf,cacheSize);
        memset(cacheBuf,0,1500);
    }else{
        recvdata = (char *)calloc(1,size+1);
        if(recvdata==NULL){
            return;
        }
    }
    memcpy(recvdata+cacheSize,data,size);
    if(strstr(recvdata,"head")==NULL){
        return;
    }
    size+=cacheSize;
    //NET_DBG("handler_CtrlMsg head =%s data=%s size=%d\n",data,data+16,size);
    while(1)
    {
        sscanf(recvdata+pos,"head:%d\n",&len);
        char *msg = (char *)calloc(1,len+1);
        if(msg==NULL){
            break;
        }
        if((pos+len+16)>size){
            memcpy(cacheBuf,recvdata+pos,size-pos);
//            NET_DBG("pos+len > size\n");
            free(msg);
            break;
        }
        memcpy(msg,recvdata+pos+16,len);
        handler_CtrlMsg(sockfd, (const char *)msg, len);
        free(msg);
        pos+=len+16;
        if(pos==size){
//            NET_DBG("pos+len = size\n");
            break;
        }
    }
    free(recvdata);
}

static void AddNetMsg(int sockfd,char *rbuf,int size){
    NetMsg_t *msg = (NetMsg_t *)calloc(1,sizeof(NetMsg_t));
    if(msg==NULL){
        return ;
    }
    msg->sockfd = sockfd;
    memcpy(msg->buf,rbuf,size);
    putMsgQueue(Net->Nlist,(const char *)msg,size);
}
static void handleMsg(const char * msg,int msgSize){
    NetMsg_t *rMsg = (NetMsg_t *)msg;
#if 1
    pasredata(rMsg->sockfd,rMsg->buf, msgSize);
#else
    handler_CtrlMsg(rMsg->sockfd,(const char *)rMsg->buf, msgSize);
#endif
    free((void *)rMsg);
}
static void *Client(void *arg){
    NetServer_t *Net = (NetServer_t *)arg;
    struct timeval tv;
    fd_set fdsr;
    char rbuf[1500]={0};
    int ret =0;
    struct sockaddr_in peer;
    int  len=sizeof(struct sockaddr),size;
    memset(&tv, 0, sizeof(struct timeval));
    tv.tv_sec = 2;
    tv.tv_usec = 0;
    while(Net->quit){
        tv.tv_sec = 2;
        tv.tv_usec = 0;
        FD_ZERO(&fdsr);
        FD_SET(Net->broSock, &fdsr);
        Net->maxsock = Net->broSock;
        if(Net->sockfd>0){
            FD_SET(Net->sockfd, &fdsr);
            Net->maxsock = Net->sockfd;
        }
        ret = select(Net->maxsock + 1, &fdsr, NULL, NULL, &tv);
        if (ret < 0){
            perror("select error ");
            break;
        }
        else if (ret == 0){
            usleep(100000);
            if(++Net->timeout>5){
                if(Net->sockfd>0&&Net->sendsign==TCP_SEND){
                    NET_DBG("timeout Net->sockfd =%d\n",Net->sockfd);
                    close(Net->sockfd);
                    Net->sockfd=-1;
                }
                checkNetworkState();
                Net->timeout=0;
            }
            continue;
        }
        Net->timeout=0;
        memset(rbuf,0,1500);
        if (FD_ISSET(Net->broSock, &fdsr)){
            if((size = recvfrom(Net->broSock, rbuf, 1500, 0, (struct sockaddr*)&peer, (socklen_t *)&len))<=0)
            {
                perror("recvfrom broadcast failed");
                usleep(100);
            }
            AddNetMsg(Net->broSock,rbuf, size);
        }
        
        if (Net->sockfd>0&&FD_ISSET(Net->sockfd, &fdsr)){
            while(1){
                size = recv(Net->sockfd, rbuf, 1500, 0);
                if(size==-1){
                    perror("recv failed");
                    break;
                }else if(size==0){
                    close(Net->sockfd);
                    Net->sockfd=-1;
                }
                Net->sendsign=TCP_ACK;
                AddNetMsg(Net->sockfd,rbuf, size);
            }
        }
    }
    Net->quit=2;
    return  NULL;
}

static int GetsockOpt(int sock,int optname, int *size){
    socklen_t optlen = sizeof(int);/* 获得原始接收缓冲区大小*/
    int err = getsockopt(sock, SOL_SOCKET, optname, size, &optlen);
    if(err<0){
        NET_DBG("getsockopt failed \n");
        return -1;
    }
    return 0;
}
static void progressTimer(void) {
    char* szJSON = NULL;
    cJSON* pItem = NULL;
    unsigned int progress=0;
    switch(player->playState){
        case MEDIA_STOP:
            PLAY_DBG("  ......music state : stop......\n");
            break;
        case MEDIA_PLAY:
            if(player->musicTime>0){
                player->curTime++;
                pItem = cJSON_CreateObject();
                cJSON_AddStringToObject(pItem, "handler", "mplayer");
                progress =player->curTime*100/player->musicTime;
                cJSON_AddNumberToObject(pItem, "progress", progress);
                cJSON_AddStringToObject(pItem, "state", "play");
                cJSON_AddStringToObject(pItem, "url", player->url);
                cJSON_AddStringToObject(pItem, "name", player->musicName);
                cJSON_AddNumberToObject(pItem, "time", player->musicTime);
                cJSON_AddStringToObject(pItem, "status","ok");
                szJSON = cJSON_Print(pItem);
                Net->networkEvent(0x01,szJSON,strlen(szJSON));
                cJSON_Delete(pItem);
                if(progress>23&&progress<48){
                    if(player->snycSeekBar<10)
                        player->playState=MEDIA_PUASE;
                }else if(progress>48&&progress<53){
                    if(player->snycSeekBar<48)
                        player->playState=MEDIA_PUASE;
                }else if(progress>73&&progress<78){
                    if(player->snycSeekBar<73)
                        player->playState=MEDIA_PUASE;
                }else if(progress>99){
                	player->curTime=0;
                    player->playState=MEDIA_STOP;
                }
                PLAY_DBG(" ...... report progress:%d\n",progress);
            }else{
                NET_DBG_WARN(" warning message ......musicTime :%d ......\n",player->musicTime);
            }
            break;
        case MEDIA_PUASE:
            PLAY_DBG("  ......music state : pause......\n");
            break;
        case MEDIA_NEXT:
            PLAY_DBG("  ......music state : next......\n");
            break;
        default:
            NET_DBG_WARN("  ......unkown music state =%d......\n",player->playState);
            break;
    }
    return ;
}
static void *RunProgress(void){
    Net->workState=REPORT_PROGRESS;
    while(Net->quit){
        switch(Net->workState){
            case REPORT_PROGRESS:
                progressTimer();
                break;
            case SYNC_DEVICES:
                if(Net->menusync==SYNC_MENU_OK){
                    //已经连接上设备，切换工作状态，上报进度条信息
                    Net->workState=REPORT_PROGRESS;
                }else{  //获取设备状态
                    mplayerGetState();
                }
                break;
            default:
                break;
           }
        sleep(1);
    }
    return NULL;
}

char *GetVersion(void){
    return (char *)VERSION;
}

static void sig_function(int sig){
	if(sig==SIGPIPE){
		NET_DBG("recv sig SIGPIPE error \n");
	}
}
int initSystem(void networkEvent(int type,char *msg,int size)){
    if(Net)
        return 0;
    NET_DBG("jni version =%s",VERSION);
    Net= (NetServer_t *)calloc(1,sizeof(NetServer_t));
    if(Net==NULL)
    {
        NET_DBG("calloc failed \n");
        return -1;
    }
    Net->networkEvent = networkEvent;
    Net->broSock = create_client_brocast(&Net->broaddr,20001);
    if(Net->broSock==-1){
        NET_DBG("create_client_brocast failed \n");
        goto exit0;
    }
    
    Net->Nlist = InitCondWorkPthread(handleMsg);
    if(Net->Nlist==NULL){
        goto exit1;
    }
    Net->networkEvent = networkEvent;
//    set_pthread_sigblock();
    struct sigaction action;                    //信号处理结构体
    action.sa_handler = sig_function;         //产生信号时的处理函数
    sigemptyset(&action.sa_mask);
    action.sa_flags = 0;
    sigaction(SIGPIPE,&action,NULL); //信号类型

//    pool_init(1);
    
    player  = (Mplayer_t *)calloc(1,sizeof(Mplayer_t));
    if(player==NULL){
        NET_DBG("calloc failed \n");
        goto exit2;
    }
    Net->quit=1;
    if(pthread_create_attr(Client,(void *)Net)){
        NET_DBG("pthread_create_attr failed \n");
        goto exit3;
    }
    if(pthread_create_attr(RunProgress,NULL)){
        NET_DBG("pthread_create_attr failed \n");
        goto exit3;
    }
    updateNetwork();
    return 0;
exit3:
    free(player);
exit2:
    free(Net->Nlist);
exit1:
    close(Net->broSock);
exit0:
    free(Net);
    return -1;
}

void cleanSystem(void){
    int timeout=0;
    if(Net){
        Net->quit=0;
        close(Net->broSock);
        Net->broSock=-1;
        if(Net->sockfd>0){
            close(Net->sockfd);
            Net->sockfd=-1;
        }
//        NET_DBG(" ...... start cleanSystem ......");
        while(1){
            usleep(100000);
            if(Net->quit!=0){
                NET_DBG(" ...... exit OK ......");
                break;
            }
        }
//        NET_DBG(" ...... CleanCondWorkPthread start......");
        CleanCondWorkPthread(Net->Nlist,handleMsg);
//        NET_DBG(" ...... CleanCondWorkPthread ok......");
        free(player);
        player=NULL;
        free(Net);
        Net=NULL;
    }
//    pool_destroy();
}

/*-----------------------------------------------------------------------------------*/
static void getServerIp(void){
    char* szJSON = NULL;
    cJSON* pItem = NULL;
    int wsize=0;
    pItem = cJSON_CreateObject();
    cJSON_AddStringToObject(pItem, "handler", "brocast");
    cJSON_AddStringToObject(pItem, "ip", "null");
    cJSON_AddNumberToObject(pItem, "port", 0);
    cJSON_AddStringToObject(pItem, "status","unkown");
    
    szJSON = cJSON_Print(pItem);
    wsize = strlen(szJSON);
    SendBro(szJSON,wsize);
    usleep(1000);
    SendBro(szJSON,wsize);
    NET_DBG("getServerIp :%s \nwsize =%d\n",szJSON,wsize);
    cJSON_Delete(pItem);
}

int updateNetwork(void){
    if(Net->sockfd>0)
        return 0;
    Net->menusync=SYNC_MENU_FAILED;
    Net->port=0;
    getServerIp();
    getServerIp();
    return 0;
}
static  int SetDevicesTime(char *time,char *type){
    char* szJSON = NULL;
    cJSON* pItem = NULL;
    int wsize=0,ret=-1;
    pItem = cJSON_CreateObject();
    cJSON_AddStringToObject(pItem, "handler", "host");
    cJSON_AddStringToObject(pItem, "type", type);
    cJSON_AddStringToObject(pItem, "time", time);
    cJSON_AddStringToObject(pItem, "status","unkown");
    
    szJSON = cJSON_Print(pItem);
    wsize = strlen(szJSON);
    NET_DBG("%s \nwsize =%d\n",szJSON,wsize);
    ret =sendMsg(Net,szJSON,wsize);
    cJSON_Delete(pItem);
    return ret;
}
int openHostTime(char *time){
    return SetDevicesTime(time,"open");
}
int closeHostTime(char *time){
    return SetDevicesTime(time,"close");
}

static int __setlock(int lock){
    char* szJSON = NULL;
    cJSON* pItem = NULL;
    int wsize=0,ret=-1;
    pItem = cJSON_CreateObject();
    cJSON_AddStringToObject(pItem, "handler", "lock");
    cJSON_AddNumberToObject(pItem, "state", lock);
    cJSON_AddStringToObject(pItem, "status","unkown");
    
    szJSON = cJSON_Print(pItem);
    wsize = strlen(szJSON);
    //	NET_DBG("%s \nwsize =%d\n",szJSON,wsize);
    ret =sendMsg(Net,szJSON,wsize);
    cJSON_Delete(pItem);
    return ret;
}
int lockHost(void){
    return __setlock(1);
}
int unlockHost(void){
    return __setlock(0);
}
/*-----------------------------------------------------------------------------------*/


/*-----------------------------------------------------------------------------------*/

static int setVol(char *dir,int data){
    char* szJSON = NULL;
    cJSON* pItem = NULL;
    int wsize=0,ret=-1;
    pItem = cJSON_CreateObject();
    cJSON_AddStringToObject(pItem, "handler", "vol");
    cJSON_AddStringToObject(pItem, "dir", dir);
    cJSON_AddNumberToObject(pItem, "data", data);
    cJSON_AddStringToObject(pItem, "status","unkown");
    
    szJSON = cJSON_Print(pItem);
    wsize = strlen(szJSON);
    printf("%s \nwsize =%d\n",szJSON,wsize);
    ret =sendMsg(Net,szJSON,wsize);
    cJSON_Delete(pItem);
    return ret;
}

int AddVol(void){
    return setVol("add",0);
}
int SubVol(void){
    return setVol("sub",0);
}
int SetVol_Data(int data){
    return setVol("no",data);
}
static int setMplayerState(char *state,char *url,int progress){
    char* szJSON = NULL;
    cJSON* pItem = NULL;
    int wsize=0,ret=-1;
    pItem = cJSON_CreateObject();
    cJSON_AddStringToObject(pItem, "handler", "mplayer");
    if(!strcmp(state,"seekto")){
        cJSON_AddNumberToObject(pItem, "progress", progress);
    }
    cJSON_AddStringToObject(pItem, "state", state);
    cJSON_AddStringToObject(pItem, "url", url);
    cJSON_AddStringToObject(pItem, "status","unkown");
    
    szJSON = cJSON_Print(pItem);
    wsize = strlen(szJSON);
    //	NET_DBG("%s \nwsize =%d\n",szJSON,wsize);
    ret =sendMsg(Net,szJSON,wsize);
    cJSON_Delete(pItem);
    return ret;
}

int mplayerGetState(void){
    return setMplayerState("get","null",0);
}
int mplayerPause(void){
    return setMplayerState("pause","null",0);
}
int mplayerStop(void){
    return setMplayerState("stop","null",0);
}
int mplayerPlay(void){
    return setMplayerState("play","null",0);
}
int mplayerPlayUrl(const char *url,const char *musicName,int timeSec){
    char* szJSON = NULL;
    cJSON* pItem = NULL;
    int wsize=0,ret=-1;
    pItem = cJSON_CreateObject();
    cJSON_AddStringToObject(pItem, "handler", "mplayer");
    cJSON_AddStringToObject(pItem, "state", "switch");
    cJSON_AddStringToObject(pItem, "url", url);
    cJSON_AddStringToObject(pItem, "name", musicName);
    cJSON_AddNumberToObject(pItem, "time", timeSec);
    cJSON_AddStringToObject(pItem, "status","unkown");
    
    szJSON = cJSON_Print(pItem);
    wsize = strlen(szJSON);
    player->playState= MEDIA_NEXT;
    //	NET_DBG("%s \nwsize =%d\n",szJSON,wsize);
    ret =sendMsg(Net,szJSON,wsize);
    cJSON_Delete(pItem);
    return 0;
}
int mplayerSeekBar(int progress){
    return setMplayerState("seekto","null",progress);
}

int versionUpdate(int state){
    if(state==0){	//�����¹̼�
        
    }else{			//���¹̼�
        
    }
    return 0;
}

int testDevices(void){
    char* szJSON = NULL;
    cJSON* pItem = NULL;
    int wsize=0,ret=-1;
    pItem = cJSON_CreateObject();
    cJSON_AddStringToObject(pItem, "handler", "TestNet");
    cJSON_AddStringToObject(pItem, "status","unkown");
    
    szJSON = cJSON_Print(pItem);
    wsize = strlen(szJSON);
    ret = SendBro(szJSON,wsize);
    cJSON_Delete(pItem);
    
    return ret;
}
int testHostQtts(char *text){
    char* szJSON = NULL;
    cJSON* pItem = NULL;
    int wsize=0,ret=-1;
    pItem = cJSON_CreateObject();
    cJSON_AddStringToObject(pItem, "handler", "qtts");
    cJSON_AddStringToObject(pItem, "text",text);
    
    szJSON = cJSON_Print(pItem);
    wsize = strlen(szJSON);
    ret = SendBro(szJSON,wsize);
    cJSON_Delete(pItem);
    return ret;
}
/*-----------------------------------------------------------------------------------*/
