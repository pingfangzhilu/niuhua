#ifndef _NETINTTER_H
#define _NETINTTER_H

#define TEST_NETWORK 	0x01
#define BROCAST			0x02

#define INTNET_FAILED	0
#define INTNET_OK		1

#define MEDIA_STOP	0
#define MEDIA_PLAY	1
#define MEDIA_PUASE	2
#define MEDIA_NEXT	3

#define TCP_SEND	1
#define TCP_ACK		0

#define SYNC_MENU_OK		0
#define SYNC_MENU_FAILED	1

#define VERSION		"v-2016-10-21.19:24"

typedef struct{
    unsigned char playState;
    unsigned char snycSeekBar;
    unsigned short voldata;
    int curTime;
    int musicTime;
    char url[128];
    char musicName[64];
}Mplayer_t;
//兼容IOS 获取状态
Mplayer_t *	GetMplayer_t(void);

extern int updateNetwork(void);
extern int initSystem(void networkEvent(int type,char *msg,int size));
extern void cleanSystem(void);

extern int openHostTime(char *time);
extern int closeHostTime(char *time);


extern int lockHost(void);
extern int unlockHost(void);

extern int SubVol(void);
extern int AddVol(void);
extern int SetVol_Data(int data);
extern int mplayerGetState(void);
extern int mplayerPause(void);
extern int mplayerStop(void);
extern int mplayerPlay(void);
extern int mplayerPlayUrl(const char *url,const char *musicName,int timeSec);
extern int mplayerSeekBar(int progress);

extern int versionUpdate(int state);

extern char *GetVersion(void);

extern int testDevices(void);
extern int testHostQtts(char *text);
#endif
