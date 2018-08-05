//
//  BaseCollectionViewController.m
//  OC-Base
//
//  Created by MYX on 2017/3/21.
//  Copyright © 2017年 邓杰豪. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()

@property (nonatomic, strong) UIView * buttomView;

@end

@implementation BaseCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)dealloc
{
    NSLog(@"CollectionViewController Dealloc: %@", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"CollectionViewController Dealloc: %@", self);
    
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.emptyDataSetDelegate = self;
    self.collectionView.backgroundColor = AppWhite;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];


    if (self.buttomView && !self.buttomView.superview) {
        [self.navigationController.view addSubview:self.buttomView];
        [self.buttomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.buttomView.superview);
            make.right.equalTo(self.buttomView.superview);
            make.bottom.equalTo(self.buttomView.superview.mas_bottom).offset(self.buttomView.frame.size.height);
        }];
        self.buttomView.alpha = 0.0;
        [self.buttomView.superview layoutIfNeeded];
        __weak typeof(self) weakself = self;
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
    [UIView animateWithDuration:0.3 animations:^{
        weakself.buttomView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakself.buttomView removeFromSuperview];
    }];
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

- (nullable UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return AppNullDataImage;
}

- (nullable NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *emptyString = AppNullDataString;
    NSString *emptyTapString = AppNullDataTapString;
    NSDictionary *style = @{
                            @"HEAD":@[AppFontNormal,AppRed],
                            @"END":@[AppFontNormal,AppGray]
                            };
    
    return [[NSString stringWithFormat:@"<HEAD>%@</HEAD>\n<END>%@</END>",emptyString,emptyTapString] attributedStringWithStyleBook:style];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return NO;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
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

#pragma mark ------> Orientation
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight |UIInterfaceOrientationMaskPortrait |UIInterfaceOrientationMaskPortraitUpsideDown;
}

-(BOOL)shouldAutorotate
{
    return YES;
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

