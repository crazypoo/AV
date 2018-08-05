//
//  AVGobalTools.m
//  AV
//
//  Created by H-L on 2018/8/5.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#import "AVGobalTools.h"

@implementation AVGobalTools

+(BOOL)isHD:(NSString *)hdString
{
    if ([hdString isEqualToString:@"1"]) {
        return NO;
    }
    else
    {
        return YES;
    }
}

+(NSString *)unixTimeToLifeTime:(NSString *)unixTime
{
    NSTimeInterval interval    =[unixTime doubleValue];
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    
    return dateString;
}

+(NSString *)likes:(NSString *)_l unLike:(NSString *)_ul
{
    CGFloat likeF = [_l floatValue];
    CGFloat unLikeF = [_ul floatValue];
    CGFloat total = likeF + unLikeF;
    
    if ([[NSString stringWithFormat:@"%.0f%%",likeF/total*100] isEqualToString:@"nan%"]) {
        return @"0%";
    }
    else
    {
        return [NSString stringWithFormat:@"%.0f%%",likeF/total*100];
    }
}

+(NSString *)getHHMMSSFromSS:(NSString *)totalTime
{
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;
}

+(NSString *)getMMSSFromSS:(NSString *)totalTime
{
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%ld",seconds/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@分钟%@秒",str_minute,str_second];
    
    NSLog(@"format_time : %@",format_time);
    
    return format_time;
    
}

@end
