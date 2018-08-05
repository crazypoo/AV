//
//  AppDelegate.h
//  AV
//
//  Created by 邓杰豪 on 2018/8/4.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AVMainTabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) AVMainTabBarViewController *tabBarController;

@property (strong, nonatomic) UIWindow *window;
+ (AppDelegate *)appDelegate;
-(void)setTabBar;

@end

