//
//  BaseViewController.m
//  OC-Base
//
//  Created by MYX on 2017/3/21.
//  Copyright © 2017年 邓杰豪. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) UIView * buttomView;

@end

@implementation BaseViewController

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    if (self.buttomView) {
        if (!self.buttomView.superview) {
            [self.navigationController.view addSubview:self.buttomView];
            [self.buttomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.buttomView.superview);
                make.right.equalTo(self.buttomView.superview);
                make.bottom.equalTo(self.buttomView.superview.mas_bottom).offset(self.buttomView.frame.size.height);
            }];
            self.buttomView.alpha = 0.0;
            [self.buttomView.superview layoutIfNeeded];
        }
        __weak typeof(self) weakself = self;
        [self.buttomView.layer removeAllAnimations];
        [UIView animateWithDuration:0.3 animations:^{
            [weakself.buttomView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(weakself.buttomView.superview.mas_bottom);
            }];
            [weakself.buttomView.superview layoutIfNeeded];
            self.buttomView.alpha = 1.0;
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    __weak typeof(self) weakself = self;
    if (self.buttomView) {
        [self.buttomView.layer removeAllAnimations];
        [UIView animateWithDuration:0.3 animations:^{
            weakself.buttomView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                [weakself.buttomView removeFromSuperview];
                weakself.buttomView = nil;
            }
        }];
    }
}

- (void)dealloc
{
    NSLog(@"ViewController Dealloc: %@", self);
}

- (void)viewDidLoad
{
    NSLog(@"ViewController ViewDidLoad: %@", self);
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (UIView *)buttomView {
    if (!_buttomView) {
        _buttomView = [self setNavigationBottomView];
    }
    return _buttomView;
}

- (UIView *) setNavigationBottomView {
    return nil;
}

#pragma mark ------> Orientation
//- (BOOL)shouldAutorotate{
//    return YES;
//}
//
////返回支持的方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
//}
//
////由模态推出的视图控制器 优先支持的屏幕方向
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return  UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
//}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight ;
}

-(BOOL)shouldAutorotate
{
    return NO;
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

-(void)backAction:(UIButton *)sender
{
    kReturnsToTheUpperLayer;
}
@end

