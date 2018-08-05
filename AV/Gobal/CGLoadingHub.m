//
//  CGLoadingHub.m
//  CloudGateCustom
//
//  Created by 邓杰豪 on 15/5/18.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#import "CGLoadingHub.h"

@implementation CGLoadingHub
+(void)showLoadingHub
{
    [WMHub setColors:@[AppGreen,AppGreen]];
    [WMHub setLineWidth:10];
    [WMHub show];
}
@end
