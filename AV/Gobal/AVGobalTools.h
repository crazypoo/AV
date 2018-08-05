//
//  AVGobalTools.h
//  AV
//
//  Created by H-L on 2018/8/5.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVGobalTools : NSObject
+(BOOL)isHD:(NSString *)hdString;
+(NSString *)unixTimeToLifeTime:(NSString *)unixTime;
+(NSString *)likes:(NSString *)_l unLike:(NSString *)_ul;
+(NSString *)getHHMMSSFromSS:(NSString *)totalTime;
+(NSString *)getMMSSFromSS:(NSString *)totalTime;

@end
