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
#ifdef ANDROID

#include "base/udp_sock.h"
#include "base/cJSON.h"
#include "base/pool.h"
#include "base/demo_tcp.h"
#include "base/queWorkCond.h"

#elif defined(IOS)
#include "udp_sock.h"
#include "cJSON.h"
#include "pool.h"
#include "demo_tcp.h"
#include "queWorkCond.h"

#endif

#include "netInter.h"
#include "event.h"


typedef struct{
	unsigned char quit;
	unsigned char menusync;
	char serverip[16];
	int port;
	int sockfd;
	int maxsock;
	void (*networkEvent)(int type,char *msg,int size);
	int broSock;
	int cmdSock;
	struct sockaddr_in broaddr;
	WorkQueue *Nlist;
}NetServer_t;

static NetServer_t *Net=NULL;
#define TEST_NETWORK 	0x01
#define BROCAST			0x02

static int __sendto(char *msg,int size,struct sockaddr_in *dest)
{
	if(sendto(Net->broSock, msg,size , 0,(struct sockaddr*)dest, sizeof(struct sockaddr))<0)
	{
        NET_DBG("__sendto msg failed \n");
    	return -1;
	}
    NET_DBG("__sendto msg ok \n");
    return 0;
}


int test_Sendbro(char *buf,int size)
{
#if 0
    if(sendto(Net->broSock, buf,size , 0,(struct sockaddr*)&Net->broaddr, sizeof(struct sockaddr))<0)
    {
        NET_DBG("__sendto msg failed \n");
        return -1;
    }
#endif
    NET_DBG("....sendto msg ok\n");
    return 0;
}

int BrocastMsg(char *msg,int size)
{
#if 1
    if(sendto(Net->broSock, msg,size , 0,(struct sockaddr*)&Net->broaddr, sizeof(struct sockaddr))<0)
    {
        NET_DBG(" msg failed \n");
        return -1;
    }
#endif
    NET_DBG("ok\n");
    return 0;
}

int sendMsg(NetServer_t *Net,char *msg,int size)
{
	if(Net->sockfd<=0)
		return -1;
	int ret = send(Net->sockfd,msg,size,0);
	if(ret==-1){
		NET_DBG("send msg failed \n");
	}else if(ret ==0){
		NET_DBG("send msg failed socket is close\n");
		if(Net->sockfd>0)
			close(Net->sockfd);
		Net->sockfd=-1;
	}else{
		ret=0;
	}
	return ret;
}

static void *requestSyncState(void *arg)
{
	NET_DBG("Net->sockfd =%d Net->serverip = %s Net->port=%d\n",Net->sockfd,Net->serverip,Net->port);
	while(1)
	{
		sleep(1);
		if(Net->menusync==1)
			break;
		mplayerGetState();

	}
    return NULL;
}
static int setnoblock(int sockfd,int blocking)
{
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
    	NET_DBG("setsockopt(TCP_NODELAY) failed");
        return -1;
    }
    return 0;
}
static void autoConnectStart(void)
{
	if(Net->sockfd<=0){
		if(Net->port!=0){
			if(Net->sockfd<=0){
				Net->sockfd = create_client(Net->serverip,Net->port);
				setnoblock(Net->sockfd,0);
				SetTcpNoDelay(Net->sockfd);
				if(Net->sockfd<=0){
					//Net->port=0;
					//memset(Net->serverip,0,sizeof(Net->serverip));
					NET_DBG("connect server failed \n");
					return ;
				}
				pool_add_task(requestSyncState, NULL) ;
			}
		}
	}
}


static int handler_CtrlMsg(int sockfd,char *recvdata,int size)
{
	cJSON * pJson = cJSON_Parse(recvdata);
	if(NULL == pJson){
		return -1;
	}
//	NET_DBG("handler_CtrlMsg recvdata =%s\n",recvdata);
	cJSON * pSub = cJSON_GetObjectItem(pJson, "handler");
	if(NULL == pSub){
		printf("get json data  failed\n");
		goto exit;
	}
	if(!strcmp(pSub->valuestring,"brocast")){	  // --------------------> brocast �㲥��ַ
		//NET_DBG("brocast msg :%s \n",recvdata);
		Net->networkEvent(0x01,recvdata,size);
		char *status = cJSON_GetObjectItem(pJson, "status")->valuestring;
		if(!strcmp(status,"ok")){
			char *ip =cJSON_GetObjectItem(pJson, "ip")->valuestring;
			int port = cJSON_GetObjectItem(pJson, "port")->valueint;
			sprintf(Net->serverip,"%s",ip);
			Net->port = port;
			autoConnectStart();
		}
	}else if(!strcmp(pSub->valuestring,"TestNet")){
		removeEvent(TEST_NETWORK);

		Net->networkEvent(0x01,recvdata,size);
	}
	else{
//		NET_DBG("recvdata = %s\n",recvdata);
#if 0
	if(!strcmp(pSub->valuestring,"host")){     // --------------------> host ��ʱ���ػ�
		Net->networkEvent(0x01,recvdata,size);
	}else if(!strcmp(pSub->valuestring,"vol")){   // --------------------> vol ��������
		Net->networkEvent(0x01,recvdata,size);
	}else if(!strcmp(pSub->valuestring,"lock")){  	// --------------------> lock �豸��
		Net->networkEvent(0x01,recvdata,size);
	}else if(!strcmp(pSub->valuestring,"mplayer")){  // --------------------> mplayer ������״̬
		Net->networkEvent(0x01,recvdata,size);
	}else if(!strcmp(pSub->valuestring,"sys")){      // --------------------> sys  ��¼��ȡ������Ϣ
		Net->networkEvent(0x01,recvdata,size);
	}
#else
	if(!strcmp(pSub->valuestring,"mplayer"))
		Net->menusync=1;
	Net->networkEvent(0x01,recvdata,size);
#endif
}
exit:
	cJSON_Delete(pJson);
	return 0;
}
static char cacheBuf[1500]={0};
void pasredata(int sockfd,char *data,int size)
{
	int len =0;
	int cacheSize=strlen(cacheBuf);
	int pos=0;
	char *recvdata;
	if(strstr(data,"head")==NULL){
		return;
	}
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
	size+=cacheSize;
//	NET_DBG("handler_CtrlMsg head =%s data=%s size=%d\n",data,data+16,size);
	while(1)
	{
		sscanf(recvdata+pos,"head:%d\n",&len);
		char *msg = (char *)calloc(1,len+1);
		if(msg==NULL){
			break;
		}
		if((pos+len+16)>size){
			memcpy(cacheBuf,recvdata+pos,size-pos);
			NET_DBG("pos+len > size\n");
			free(msg);
			break;
		}
		memcpy(msg,recvdata+pos+16,len);
		handler_CtrlMsg(sockfd, msg, len);
		free(msg);
		pos+=len+16;
		if(pos==size){
			NET_DBG("pos+len = size\n");
			break;
		}
	}
	free(recvdata);
}


typedef struct{
	char buf[1500];
	int sockfd;
}NetMsg_t;
static void AddNetMsg(int sockfd,char *rbuf,int size)
{
	NetMsg_t *msg = (NetMsg_t *)calloc(1,sizeof(NetMsg_t));
	if(msg==NULL){
		return ;
	}
	msg->sockfd = sockfd;
	memcpy(msg->buf,rbuf,size);
	putMsgQueue(Net->Nlist,(const char *)msg,size);
}
static void handleMsg(const char * msg,int msgSize)
{
	NetMsg_t *rMsg = (NetMsg_t *)msg;
#if 1
	pasredata(rMsg->sockfd,rMsg->buf, msgSize);
#else
	handler_CtrlMsg(rMsg->sockfd,rMsg->buf, msgSize);
#endif
	free((void *)rMsg);
}

static void *Client(void *arg)
{
	NetServer_t *Net = (NetServer_t *)arg;
	struct timeval tv;
	fd_set fdsr;
	char rbuf[1500]={0};
	int ret =0,timeout=0;
	struct sockaddr_in peer;
	int  len=sizeof(struct sockaddr),size;
	memset(&tv, 0, sizeof(struct timeval));
    Net->port =20000;
    snprintf(Net->serverip, 16, "%s","192.168.17.107");
    Net->sockfd = create_client(Net->serverip,Net->port);
    NET_DBG("Client Net->sockfd =%d Net->broSock =%d\n",Net->sockfd,Net->broSock);
	tv.tv_sec = 2;
	tv.tv_usec = 0;
	Net->quit=1;
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
			NET_DBG("Net->sockfd =%d Net->broSock =%d\n",Net->sockfd,Net->broSock);
			if(++timeout>10)
				autoConnectStart();
			continue;
		}
		memset(rbuf,0,1500);
		if (FD_ISSET(Net->broSock, &fdsr)){
			if((size = recvfrom(Net->broSock, rbuf, 1500, 0, (struct sockaddr*)&peer, (socklen_t *)&len))<=0)
			{
				perror("recvfrom broadcast failed");
				usleep(100);
			}
			AddNetMsg(Net->broSock,rbuf, size);
		}

		if (FD_ISSET(Net->sockfd, &fdsr)){
			while(1){
				size = recv(Net->sockfd, rbuf, 1500, 0);
				if(size==-1){
					perror("recv failed");
					break;
				}else if(size==0){
					close(Net->sockfd);
					Net->sockfd=-1;
				}
				AddNetMsg(Net->sockfd,rbuf, size);
			}
		}
	}
	Net->quit=2;
	return  NULL;
}


static void timeout_cb(Event_t *ev)
{
	char* szJSON = NULL;
	cJSON* pItem = NULL;

	pItem = cJSON_CreateObject();
	switch(ev->event){
		case TEST_NETWORK:
			cJSON_AddStringToObject(pItem, "handler", "TestNet");
			cJSON_AddStringToObject(pItem, "ip","");
			cJSON_AddNumberToObject(pItem, "port", 20000);
			break;
		case BROCAST:
			cJSON_AddStringToObject(pItem, "handler", "brocast");
			cJSON_AddStringToObject(pItem, "ip","");
			cJSON_AddNumberToObject(pItem, "port", 20000);
			break;
	}
	cJSON_AddStringToObject(pItem, "status","timeout");
	szJSON = cJSON_Print(pItem);
	Net->networkEvent(0x01,szJSON,strlen(szJSON));
	NET_DBG("timeout_cb szJSON =%s\n",szJSON);
	cJSON_Delete(pItem);
}
static void *CmdRecvFrom(void *arg)
{
	char rbuf[1500]={0};
	struct sockaddr_in peer;
	int  len=sizeof(struct sockaddr),size;
	while(Net->quit){
		if((size = recvfrom(Net->cmdSock, rbuf, 1500, 0, (struct sockaddr*)&peer, (socklen_t *)&len))<=0)
		{
			NET_DBG ("recvfrom udp failed");
			usleep(100);
		}
		AddNetMsg(Net->cmdSock,rbuf, size);
		memset(rbuf,0,size);
	}
    return NULL;
}
int initSystem(void networkEvent(int type,char *msg,int size))
{
	if(Net)
		return 0;
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
#if 1
	Net->cmdSock= create_listen_udp(NULL,20001);
	if(Net->cmdSock==-1){
		NET_DBG("create listen sock  failed \n");
		goto exit0;
	}
	Net->Nlist = InitCondWorkPthread(handleMsg);
	if(Net->Nlist==NULL)
	{
		goto exit1;
	}
	Net->networkEvent = networkEvent;

	set_pthread_sigblock();
	pool_init(1);

	if(pthread_create_attr(Client,(void *)Net))
	{
		NET_DBG("pthread_create_attr failed \n");
		goto exit2;
	}
	if(pthread_create_attr(CmdRecvFrom,(void *)Net))
	{
		NET_DBG("pthread_create_attr failed \n");
		goto exit2;
	}
	InitWorkEvent(timeout_cb);
#endif
    NET_DBG("initSystem success \n");
	updateNetwork();
	return 0;

exit2:
	free(Net->Nlist);
exit1:
	close(Net->broSock);
exit0:
	free(Net);
	return -1;
}

void cleanSystem(void)
{
	int timeout=0;
	destoryWorkEvent();
	if(Net)
	{
		Net->quit=0;
		close(Net->broSock);
		Net->broSock=-1;
		close(Net->cmdSock);
		Net->cmdSock=-1;
		if(Net->sockfd>0){
			close(Net->sockfd);
			Net->sockfd=-1;
		}
		while(++timeout<20)
		{
			usleep(10000);
			if(Net->quit!=0)
				break;
		}
		CleanCondWorkPthread(Net->Nlist,handleMsg);
		free(Net);
	}
	pool_destroy();
}

/*-----------------------------------------------------------------------------------*/
static void getServerIp(void)
{
	char* szJSON = NULL;
	cJSON* pItem = NULL;
	int wsize=0;
    NET_DBG("getServerIp \n");
#if 1
	pItem = cJSON_CreateObject();
	cJSON_AddStringToObject(pItem, "handler", "brocast");
	cJSON_AddStringToObject(pItem, "ip", "null");
	cJSON_AddNumberToObject(pItem, "port", 0);
	cJSON_AddStringToObject(pItem, "status","unkown");

	szJSON = cJSON_Print(pItem);
	wsize = strlen(szJSON);
	printf("%s \nwsize =%d\n",szJSON,wsize);
    //test_Sendbro(szJSON,wsize);
    BrocastMsg(szJSON,wsize);
	cJSON_Delete(pItem);
#endif

    NET_DBG("SendBro ....... \n");
}

/*
static int GetDevicesState(void)
{
	char* szJSON = NULL;
	cJSON* pItem = NULL;
	int wsize=0,ret=-1;
	pItem = cJSON_CreateObject();
	cJSON_AddStringToObject(pItem, "handler", "state");
	cJSON_AddStringToObject(pItem, "status","unkown");
	szJSON = cJSON_Print(pItem);
	wsize = strlen(szJSON);
	printf("%s \nwsize =%d\n",szJSON,wsize);
	ret =sendMsg(&Net->sockfd,szJSON,wsize);
	cJSON_Delete(pItem);
	return ret;
}
*/
int updateNetwork(void)
{
	//GetDevicesState();
	if(Net->sockfd>0)
		return 0;
	Net->menusync=0;
	//getServerIp();
	getServerIp();
	return 0;
}
static  int SetDevicesTime(char *time,char *type)
{
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
int openHostTime(char *time)
{
	return SetDevicesTime(time,"open");
}
int closeHostTime(char *time)
{
	return SetDevicesTime(time,"close");
}

static int __setlock(int lock)
{
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
int lockHost(void)
{
	return __setlock(1);
}
int unlockHost(void)
{
	return __setlock(0);
}
/*-----------------------------------------------------------------------------------*/


/*-----------------------------------------------------------------------------------*/

static int setVol(char *dir,int data)
{
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

int AddVol(void)
{
	return setVol("add",0);
}
int SubVol(void)
{
	return setVol("sub",0);
}
int SetVol_Data(int data)
{
	return setVol("no",data);
}
static int setMplayerState(char *state,char *url,int progress)
{
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
	NET_DBG("%s \nwsize =%d\n",szJSON,wsize);
	ret =sendMsg(Net,szJSON,wsize);
	cJSON_Delete(pItem);
	return ret;
}

int mplayerGetState(void)
{
	return setMplayerState("get","null",0);
}
int mplayerPause(void)
{
	return setMplayerState("pause","null",0);
}
int mplayerStop(void)
{
	return setMplayerState("stop","null",0);
}
int mplayerPlay(void)
{
	return setMplayerState("play","null",0);
}
int mplayerPlayUrl(char *url)
{
	return setMplayerState("switch",url,0);
}
int mplayerSeekBar(int progress)
{
	return setMplayerState("seekto","null",progress);
}

int versionUpdate(int state)
{
	if(state==0){	//�����¹̼�

	}else{			//���¹̼�

	}
    return 0;
}

int testDevices(void)
{
	char* szJSON = NULL;
	cJSON* pItem = NULL;
	int wsize=0,ret=-1;
	pItem = cJSON_CreateObject();
	cJSON_AddStringToObject(pItem, "handler", "TestNet");
	cJSON_AddStringToObject(pItem, "status","unkown");

	szJSON = cJSON_Print(pItem);
	wsize = strlen(szJSON);
	ret = BrocastMsg(szJSON,wsize);
	cJSON_Delete(pItem);
	AddEvent(TEST_NETWORK,20);
	return ret;
}

int testHostQtts(char *text)
{
	char* szJSON = NULL;
	cJSON* pItem = NULL;
	int wsize=0,ret=-1;
	pItem = cJSON_CreateObject();
	cJSON_AddStringToObject(pItem, "handler", "qtts");
	cJSON_AddStringToObject(pItem, "text",text);

	szJSON = cJSON_Print(pItem);
	wsize = strlen(szJSON);
	ret = BrocastMsg(szJSON,wsize);
	cJSON_Delete(pItem);
	return ret;
}
/*-----------------------------------------------------------------------------------*/
