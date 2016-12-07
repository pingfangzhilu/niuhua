//
//  IntervalSinceNow.m
//  voices
//
//  Created by pc on 16/10/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "IntervalSinceNow.h"

@implementation IntervalSinceNow
- (NSString *)intervalSinceNow: (NSString *) theDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime =[formatter stringFromDate:[NSDate date]];
    NSString *currTime =[NSString stringWithFormat:@"%@",[dateTime substringWithRange:NSMakeRange(8, 2)]];
    NSString *currnian =[NSString stringWithFormat:@"%@",[dateTime substringWithRange:NSMakeRange(0, 4)]];
    NSString *curryue =[NSString stringWithFormat:@"%@",[dateTime substringWithRange:NSMakeRange(5, 2)]];
    NSLog(@"当前的年%@",currnian);
    
    //将时间戳转为正常时间
    NSTimeInterval time=[theDate doubleValue]+28800;
    //+28800;//因为时差问题要加8小时 == 28800 sec
    //  NSTimeInterval time=[theDate doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    NSString *timeString =[NSString stringWithFormat:@"%@",[currentDateStr substringWithRange:NSMakeRange(8, 2)]];
    NSString *nianString =[NSString stringWithFormat:@"%@",[currentDateStr substringWithRange:NSMakeRange(0, 4)]];
    NSString *yueString =[NSString stringWithFormat:@"%@",[currentDateStr substringWithRange:NSMakeRange(5, 2)]];
    
    NSLog(@"传过来的%@",nianString);
    NSString *timeCompare =@"";
 
    
    if (([currnian intValue]-[nianString intValue])==0) {
        
        if (([curryue intValue]-[yueString intValue])==0) {
   
            
            timeCompare =[NSString stringWithFormat:@"%d天前",([currTime intValue] - [timeString intValue])];
            
        }
        else
        {
        
            
            timeCompare =[NSString stringWithFormat:@"%d月前",([curryue intValue]-[yueString intValue])];
            
        
        }
        
        
    }
    else
    {
    
    timeCompare =[NSString stringWithFormat:@"%d年前",([currnian intValue]-[nianString intValue])];
    
    }
    
    
    
 
    
    
    return timeCompare;
    




}


-(NSString*)TimeformatFromSeconds:(NSInteger)seconds
{
    //format of hour
//    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    return format_time;
}



@end
