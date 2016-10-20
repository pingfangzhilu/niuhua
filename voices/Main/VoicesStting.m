//
//  VoicesStting.m
//  voices
//
//  Created by pc on 16/10/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "VoicesStting.h"

@implementation VoicesStting

+(VoicesStting *)sharedInstance
{
    static VoicesStting *voices =nil;
    if (voices ==nil) {
        
        voices =[[VoicesStting alloc]init];
    }
    return voices;

}

- (void)setDataMuArray:(NSArray *)DataMuArray
{


    
    
    
    


}


@end
