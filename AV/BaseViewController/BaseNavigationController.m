//
//  BaseNavigationController.m
//  OC-Base
//
//  Created by MYX on 2017/3/21.
//  Copyright © 2017年 邓杰豪. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController () <UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

- (void)dealloc
{
    NSLog(@"NavigationController Dealloc: %@", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    NSLog(@"NavigationController viewDidLoad: %@", self);
 
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
}

- (void)pushViewController:(UIViewController *)vc animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:vc animated:animated];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];

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
-(BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
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

