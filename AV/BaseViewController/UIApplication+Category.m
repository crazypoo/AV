//
//  UIApplication+Category.m
//  OC-Base
//
//  Created by MYX on 2017/3/21.
//  Copyright © 2017年 邓杰豪. All rights reserved.
//

#import "UIApplication+Category.h"

@implementation UIApplication (Category)
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [self setStatusBarStyle:statusBarStyle animated:YES];
#pragma clang diagnostic pop
}
@end
