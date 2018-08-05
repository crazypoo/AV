//
//  BaseViewController.h
//  OC-Base
//
//  Created by MYX on 2017/3/21.
//  Copyright © 2017年 邓杰豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

-(UIView *)setNavigationBottomView;
-(void)turnTheScreen:(UIInterfaceOrientation)type;
-(void)setNav:(UIColor *)navColor hideLine:(BOOL)isHideLine tintColor:(UIColor *)tColor;
-(void)backAction:(UIButton *)sender;

@end
