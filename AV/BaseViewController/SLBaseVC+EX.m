//
//  SLBaseVC+EX.m
//  CloudGateCustom
//
//  Created by 邓杰豪 on 2018/7/31.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#import "SLBaseVC+EX.h"

@implementation SL_BaseViewController (EX)

-(void)setNavBack:(NSString *)title
{
    [self.navigationBar.btnBack setImage:kImageNamed(@"image_Back") forState:UIControlStateNormal];
    [self.navigationBar.btnBack setTitle:title forState:UIControlStateNormal];
    [self.navigationBar.btnBack setTitleColor:AppBlack forState:UIControlStateNormal];
    self.navigationBar.btnBack.titleLabel.font = AppLargeTitleFont_BOLD;
    [self.navigationBar.btnBack layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:BackBtnSpace];
    self.navigationBar.btnBack.width = BackImageW+BackBtnSpace+AppLargeTitleFont_SIZE*self.navigationBar.btnBack.titleLabel.text.length;
}

-(void)setNavBack_White:(NSString *)title
{
    [self.navigationBar.btnBack setImage:kImageNamed(@"image_back_white") forState:UIControlStateNormal];
    [self.navigationBar.btnBack setTitle:title forState:UIControlStateNormal];
    [self.navigationBar.btnBack setTitleColor:AppWhite forState:UIControlStateNormal];
    self.navigationBar.btnBack.titleLabel.font = AppLargeTitleFont_BOLD;
    [self.navigationBar.btnBack layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:BackBtnSpace];
    self.navigationBar.btnBack.width = BackImageW+BackBtnSpace+AppLargeTitleFont_SIZE*self.navigationBar.btnBack.titleLabel.text.length;
}
@end
