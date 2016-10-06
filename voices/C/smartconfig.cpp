//
//  smartconfig.cpp
//  voices
//
//  Created by pc on 16/10/7.
//  Copyright © 2016年 mac. All rights reserved.
//
#include <string.h>
#include "smartconfig.hpp"
#include "elian.h"
static void *context = NULL;

int  GetProtoVersion(void)
{
    int protoVersion = 0;
    int libVersion = 0;
    
    elianGetVersion(&protoVersion, &libVersion);
    return protoVersion;
}

int GetLibVersion(void)
{
    int protoVersion = 0;
    int libVersion = 0;
    
    elianGetVersion(&protoVersion, &libVersion);
    return libVersion;
}

int InitSmartConnection(char *v,int sendV1, int sendV4)
{
    unsigned char target[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
    unsigned int flag = 0;
    
    if (context)
    {
        elianStop(context);
        elianDestroy(context);
        context = NULL;
    }
    
    if (sendV1)
    {
        flag |= ELIAN_SEND_V1;
    }
    if (sendV4)
    {
        flag |= ELIAN_SEND_V4;
    }
    context = elianNew(NULL, 0, target, flag);
    if (context == NULL)
    {
        return -1;
    }
    return 0;
}

/*
 * Class:     com_mediatek_elian_ElianNative
 * Method:    StartSmartConnection
 * Signature: (Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;B)I
 */
int StartSmartConnection(char *ssid, char *password, char *custom)
{
    
    if (context == NULL)
    {
        return -1;
    }
    
    //    elianPut(context, TYPE_ID_AM, (char *)&authmode, 1);
    elianPut(context, TYPE_ID_SSID, (char *)ssid, strlen(ssid));
    elianPut(context, TYPE_ID_PWD, (char *)password, strlen(password));
    elianPut(context, TYPE_ID_CUST, (char *)custom, strlen(custom));
    
    printf("StartSmartConnection ... \n");
    elianStart(context);
    
    return 0;
}

/*
 * Class:     com_mediatek_elian_ElianNative
 * Method:    StopSmartConnection
 * Signature: ()I
 */
int StopSmartConnection()
{
    if (context)
    {
        elianStop(context);
        elianDestroy(context);
        context = NULL;
    }
    return 0;
}
