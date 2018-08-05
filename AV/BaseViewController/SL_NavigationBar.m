//
//  SL_NavigationBar.m
//  BigTitleNavigationController
//
//  Created by admin on 2017/2/21.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "SL_NavigationBar.h"

@interface SL_NavigationBar (){
    float _originTitleCenterX;
    CGFloat btnWidth;
}

@end

@implementation SL_NavigationBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _lineMargin = ViewSpace;
        _lblTitleFontSize = 30;
        _lblTitleSmallFontSize = 16;
        
        [self addSubview:self.btnBack];
        [self addSubview:self.lineView];
        
        btnWidth = NavButonH;
        _btnBack.frame = CGRectMake(ViewSpace, kScreenStatusBottom, btnWidth, btnWidth);
        _btnBack.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _lineView.frame = CGRectMake(0, frame.size.height-LineHeigh, frame.size.width, LineHeigh);
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.lineView.bottom = self.height;
    switch (_scrollType) {
        case SL_NavigationBarScrollType_BigViewToSmallView:
        {
            _btnBack.frame = CGRectMake(ViewSpace, kScreenStatusBottom+(self.height-kScreenStatusBottom-btnWidth)/2, self.btnBack.width, btnWidth);
            self.rightCustomView.frame = CGRectMake(self.width-self.rightCustomView.width, kScreenStatusBottom+(self.height-kScreenStatusBottom-btnWidth)/2, self.rightCustomView.width, btnWidth);
            self.customView.frame = CGRectMake(self.btnBack.width+ViewSpace, kScreenStatusBottom+(self.height-kScreenStatusBottom-btnWidth)/2, self.customView.width, btnWidth);
        }
            break;
        default:
        {
            _btnBack.frame = CGRectMake(ViewSpace, kScreenStatusBottom, self.btnBack.width, btnWidth);
            self.customView.bottom = self.height;
            self.rightCustomView.bottom = self.height;
        }
            break;
    }
}

-(void)navigationBarAnimationWithScale:(CGFloat)scale{
    switch (_scrollType) {
        case SL_NavigationBarScrollType_Scale:{
            CGRect navigationFrame = self.frame;
            navigationFrame.origin.y = (NavigationBarNormalHeight-(NavButonH+kScreenStatusBottom))*(scale);
            navigationFrame.size.height = NavigationBarNormalHeight-(NavigationBarNormalHeight-(NavButonH+kScreenStatusBottom))*(scale);
            self.frame = navigationFrame;
            
            self.customView.height = self.frame.size.height-kScreenStatusBottom;
            
            self.rightCustomView.frame = CGRectMake(self.width-self.rightCustomView.frame.size.width, self.customView.frame.origin.y, self.rightCustomView.frame.size.width, self.customView.height);

            if (self.delegate && [self.delegate respondsToSelector:@selector(returnCustomScale:)]) {
                [self.delegate returnCustomScale:self.customView.height/customOriginalHeight];
            }
        }
            break;
        case SL_NavigationBarScrollType_ScaleToCenter:{
            CGRect navigationFrame = self.frame;
            navigationFrame.origin.y = (NavigationBarNormalHeight-(NavButonH+kScreenStatusBottom))*(scale);
            navigationFrame.size.height = NavigationBarNormalHeight-(NavigationBarNormalHeight-(NavButonH+kScreenStatusBottom))*(scale);
            self.frame = navigationFrame;
            
            float lblTitleHeight = NavigationBarNormalHeight-self.btnBack.bottom;
            self.customView.height = lblTitleHeight-(lblTitleHeight-self.btnBack.height)*scale;

            self.rightCustomView.frame = CGRectMake(self.width-self.rightCustomView.frame.size.width, kScreenStatusBottom+(NavButonH - (NavButonH*scale)), self.rightCustomView.frame.size.width, self.customView.height);

            float customX = self.btnBack.width*scale+ViewSpace*scale;
            float customW = self.width-self.btnBack.width*scale-self.rightCustomView.width-ViewSpace*scale;
            self.customView.frame = CGRectMake(customX, kScreenStatusBottom+(NavButonH - (NavButonH*scale)), customW, lblTitleHeight-(lblTitleHeight-self.btnBack.height)*scale);
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(returnCustomScale:)]) {
                [self.delegate returnCustomScale:scale];
            }
        }
            break;
        case SL_NavigationBarScrollType_CenterScale:{
            CGRect navigationFrame = self.frame;
            navigationFrame.origin.y = (NavigationBarNormalHeight-(NavButonH+kScreenStatusBottom))*(scale);
            navigationFrame.size.height = NavigationBarNormalHeight-(NavigationBarNormalHeight-(NavButonH+kScreenStatusBottom))*(scale);
            self.frame = navigationFrame;
            
            float lblTitleHeight = NavigationBarNormalHeight-self.btnBack.bottom;
            self.customView.height = lblTitleHeight-(lblTitleHeight-self.btnBack.height)*scale;
            
            self.rightCustomView.frame = CGRectMake(self.width-self.rightCustomView.width, kScreenStatusBottom+(NavButonH - (NavButonH*scale)), self.rightCustomView.width, self.customView.height);

            if (self.delegate && [self.delegate respondsToSelector:@selector(returnCustomScale:)]) {
                [self.delegate returnCustomScale:self.customView.height/customOriginalHeight];
            }
            
        }
            break;
        case SL_NavigationBarScrollType_BigViewToSmallView:
        {
            CGRect navigationFrame = self.frame;
            navigationFrame.origin.y = (NavigationBarNormalHeight-(NavButonH+kScreenStatusBottom))*(scale);
            navigationFrame.size.height = NavigationBarNormalHeight-(NavigationBarNormalHeight-(NavButonH+kScreenStatusBottom))*(scale);
            self.frame = navigationFrame;
            
            float remainX = (NavigationBarNormalHeight- kScreenStatusBottom -btnWidth)/2;
            float cX = kScreenStatusBottom + (remainX-remainX*(scale/2));
            
            self.rightCustomView.frame = CGRectMake(self.width-self.rightCustomView.width, cX, self.rightCustomView.width, NavButonH);

            self.customView.frame = CGRectMake(self.btnBack.width+ViewSpace, cX, self.width-self.rightCustomView.width-self.btnBack.width-ViewSpace, NavButonH);

            self.btnBack.frame = CGRectMake(ViewSpace, cX, self.btnBack.width, btnWidth);
        }
            break;
        default:{
            CGRect navigationFrame = self.frame;
            navigationFrame.origin.y = (NavigationBarNormalHeight-(NavButonH+kScreenStatusBottom))*(scale);
            navigationFrame.size.height = NavigationBarNormalHeight-(NavigationBarNormalHeight-(NavButonH+kScreenStatusBottom))*(scale);
            self.frame = navigationFrame;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(returnViewAlphaScale:)]) {
                [self.delegate returnViewAlphaScale:fabs(1-scale*2)];
            }
            self.rightCustomView.frame = CGRectMake(self.width-self.rightCustomView.frame.size.width, kScreenStatusBottom+(NavButonH - (NavButonH*scale)), self.rightCustomView.frame.size.width, self.customView.height);

            if (self.delegate && [self.delegate respondsToSelector:@selector(returnCustomScale:)]) {
                [self.delegate returnCustomScale:scale];
            }
        }            
            break;
    }
}

-(UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor=[UIColor lightGrayColor];
    }
    return _lineView;
}

-(UIButton *)btnBack{
    if (_btnBack == nil) {
        _btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _btnBack;
}

-(void)setTitleCustom:(UIView *)custom
{
    CGFloat navW = 0.0;
    CGFloat viewY = 0.0;
    CGFloat viewH = 0.0;
    CGFloat viewX = 0.0;

    switch (_scrollType) {
        case SL_NavigationBarScrollType_ScaleToCenter:
        {
            navW = self.width;
            viewY = self.btnBack.bottom;
            viewH = self.height-self.btnBack.bottom;
            viewX = 0;
        }
            break;
        case SL_NavigationBarScrollType_BigViewToSmallView:
        {
            viewY = (NavigationBarNormalHeight-btnWidth)/2;
            navW = self.width-self.btnBack.width-ViewSpace;
            viewH = btnWidth;
            viewX = self.btnBack.width;
        }
            break;
        case SL_NavigationBarScrollType_Scale:
        {
            navW = self.width-self.btnBack.width-ViewSpace;
            viewY = self.btnBack.bottom;
            viewH = self.height-kScreenStatusBottom;
            viewX = self.btnBack.width;
        }
            break;
        default:
        {
            navW = self.width-self.btnBack.width-ViewSpace;
            viewY = self.btnBack.bottom;
            viewH = self.height-self.btnBack.bottom;
            viewX = self.btnBack.width;
        }
            break;
    }
    self.customView = custom;
    self.customView.frame = CGRectMake(viewX, viewY, navW, viewH);
    customOriginalHeight = self.customView.height;
    [self addSubview:self.customView];
    if (self.height<=(NavButonH+kScreenStatusBottom)) {
        self.customView.height=(self.height-self.btnBack.top);
    }
    else{
        self.customView.height=(self.height-self.btnBack.bottom);
    }
}

-(void)setRightView:(UIView *)rightCustom
{
    self.rightCustomView = rightCustom;
    [self addSubview:self.rightCustomView];
    if (self.height<=(NavButonH+kScreenStatusBottom)) {
        self.rightCustomView.height=(self.height-self.btnBack.top);
    }
    else{
        self.rightCustomView.height=(self.height-self.btnBack.bottom);
    }
    
    switch (_scrollType) {
        case SL_NavigationBarScrollType_ScaleToCenter:
        {
            if (rightCustom.width > 100) {
                NSLog(@"不能大于100");
                [self.rightCustomView removeFromSuperview];
            }
            else
            {
                self.rightCustomView.frame = CGRectMake(self.width-rightCustom.frame.size.width, self.btnBack.bottom, rightCustom.frame.size.width, self.frame.size.height-self.btnBack.bottom);
                self.customView.frame = CGRectMake(0, self.btnBack.bottom, self.width-self.rightCustomView.width, self.height-self.btnBack.bottom);
            }
        }
            break;
        case SL_NavigationBarScrollType_BigViewToSmallView:
        {
            self.rightCustomView.frame = CGRectMake(self.width-rightCustom.frame.size.width, kScreenStatusBottom+(self.height-kScreenStatusBottom-btnWidth)/2, rightCustom.frame.size.width, btnWidth);
            self.customView.frame = CGRectMake(self.btnBack.width, kScreenStatusBottom+(self.height-kScreenStatusBottom-btnWidth)/2, self.width-self.btnBack.width-rightCustom.width-ViewSpace, btnWidth);
        }
            break;
        case SL_NavigationBarScrollType_CenterScale:
        {
            self.rightCustomView.frame = CGRectMake(self.width-rightCustom.frame.size.width, self.btnBack.bottom, rightCustom.frame.size.width, self.height-_btnBack.bottom);
            self.customView.frame = CGRectMake(self.btnBack.width, self.btnBack.bottom, self.width-self.rightCustomView.width-self.btnBack.width-ViewSpace, self.height-_btnBack.bottom);
        }
            break;
        case SL_NavigationBarScrollType_Scale:
        {
            self.rightCustomView.frame = CGRectMake(self.width-rightCustom.frame.size.width, kScreenStatusBottom, rightCustom.frame.size.width, self.height-kScreenStatusBottom);
            self.customView.frame = CGRectMake(self.btnBack.width, kScreenStatusBottom, self.width-self.rightCustomView.width-self.btnBack.width-ViewSpace, self.height-kScreenStatusBottom);
        }
            break;
        default:
        {
            if (rightCustom.width >= 300) {
                NSLog(@"不能大于300");
                [self.rightCustomView removeFromSuperview];
            }
            else
            {
                self.rightCustomView.frame = CGRectMake(self.width-rightCustom.frame.size.width, self.btnBack.bottom, rightCustom.frame.size.width, self.frame.size.height-self.btnBack.bottom);
                self.customView.frame = CGRectMake(self.btnBack.width, self.btnBack.bottom, self.width-self.rightCustomView.width-self.btnBack.width-ViewSpace, self.height-self.btnBack.bottom);
            }

        }
            break;
    }
}

-(void)setScrollType:(SL_NavigationBarScrollType)scrollType{
    _scrollType = scrollType;
    if (_scrollType == SL_NavigationBarScrollType_CenterScale)
    {        
        self.customView.left = self.btnBack.width;
    }
}
@end
