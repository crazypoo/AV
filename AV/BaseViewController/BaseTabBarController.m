//
//  BaseTabBarController.m
//  OC-Base
//
//  Created by MYX on 2017/3/21.
//  Copyright © 2017年 邓杰豪. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)dealloc
{
    NSLog(@"TabBarController Dealloc: %@", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49)];
    self.tabBar.opaque = YES;
    
    NSLog(@"TabBarController viewDidLoad: %@", self);    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNav:(UIColor *)navColor hideLine:(BOOL)isHideLine tintColor:(UIColor *)tColor
{
    if (navColor == AppWhite) {
        [self.navigationController.navigationBar setTintColor:tColor];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self.navigationController.navigationBar setTintColor:AppWhite];
    }
    
    [self.navigationController.navigationBar setBackgroundImage:[BaseViewConfig createImageWithColor:navColor] forBarMetrics:UIBarMetricsDefault];
    if (isHideLine) {
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
}

#pragma mark ------>屏幕旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight;
}

-(void)turnTheScreen:(UIInterfaceOrientation)type
{
    if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)]) {
        
        SEL selector = NSSelectorFromString(@"setOrientation:");
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        
        [invocation setSelector:selector];
        
        [invocation setTarget:[UIDevice currentDevice]];
        
        int val = type;
        
        [invocation setArgument:&val atIndex:2];
        
        [invocation invoke];
    }
}

@end
