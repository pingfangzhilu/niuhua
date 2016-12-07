//
//  IntervalSinceNow.h
//  voices
//
//  Created by pc on 16/10/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntervalSinceNow : NSObject
- (NSString *)intervalSinceNow: (NSString *) theDate;

- (NSString *)TimeSinceNow: (NSString *) theDateTime;




-(NSString*)TimeformatFromSeconds:(NSInteger)seconds;
@end
