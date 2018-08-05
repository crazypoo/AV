//
//  LK_NavigationBar.h
//  BigTitleNavigationController
//
//  Created by admin on 2017/2/21.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum SL_NavigationBarScrollType:NSInteger{
    SL_NavigationBarScrollType_Fade = 0,//淡入淡出
    SL_NavigationBarScrollType_Scale,//放大缩小
    SL_NavigationBarScrollType_ScaleToCenter,//放大缩小并居中
    SL_NavigationBarScrollType_CenterScale,//放大缩小并居中
    SL_NavigationBarScrollType_BigViewToSmallView
}SL_NavigationBarScrollType;

@class SL_NavigationBar;

@protocol SL_NavigationBarDelegate <NSObject>
@optional
-(void)returnCustomScale:(CGFloat)customScale;
-(void)returnViewAlphaScale:(CGFloat)viewScale;

@end

@interface SL_NavigationBar : UIView
{
    CGFloat customOriginalHeight;
}

@property (nonatomic,strong)UIView *customView;
@property (nonatomic,strong)UIView *rightCustomView;

@property (nonatomic,strong)UIButton *btnBack;
@property (nonatomic,strong)UIView   *lineView;

@property (nonatomic,assign)CGFloat lblTitleFontSize;
@property (nonatomic,assign)CGFloat lblTitleSmallFontSize;

@property (nonatomic,assign)CGFloat lineMargin;

@property (nonatomic,assign)SL_NavigationBarScrollType scrollType;

@property (nonatomic,weak) id<SL_NavigationBarDelegate>delegate;

-(void)navigationBarAnimationWithScale:(CGFloat)scale;
-(void)setTitleCustom:(UIView *)custom;
-(void)setRightView:(UIView *)rightView;
@end
