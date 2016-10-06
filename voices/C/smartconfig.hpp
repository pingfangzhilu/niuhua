//
//  smartconfig.hpp
//  voices
//
//  Created by pc on 16/10/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#ifndef smartconfig_hpp
#define smartconfig_hpp

#include <stdio.h>
#ifdef __cplusplus
extern "C" {
#endif
int InitSmartConnection(char *v,int sendV1, int sendV4);
int StartSmartConnection(char *ssid, char *password, char *custom);
#ifdef __cplusplus
};
#endif
#endif /* smartconfig_hpp */
