//
//  VoicesStting.h
//  voices
//
//  Created by pc on 16/10/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoicesStting : NSObject

+(VoicesStting *)sharedInstance;

@property (nonatomic,strong)NSArray *DataMuArray;

@end
