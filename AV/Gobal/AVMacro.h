//
//  AVMacro.h
//  AV
//
//  Created by H-L on 2018/8/4.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#ifndef AVMacro_h
#define AVMacro_h

//App所用到的颜色
#define AppWhite [UIColor whiteColor]
#define AppBlack [UIColor blackColor]
#define AppRed kColorFromHex(0xCF2326)
#define AppOrange kColorFromHex(0xed6f55)
#define AppSensorGreen kColorFromHex(0x6EBA43)
#define AppGreen kColorFromHex(0x00a79b) //kRGBColor(1, 167, 155)
#define AppGray kColorFromHex(0xafafaf)
#define AppLightGray kColorFromHex(0xE3E2E2)
#define AppSuperLightGray kColorFromHex(0xf2f2f2)
#define AppBlue kRGBColor(0, 84, 166) //0054A6

//#define GETDATASUCCESS [ isEqual:1]

//特大字号,用在我的界面的用户名字
#define AppSuperLargeTitleFont_SIZE (PSFont(80))
#define AppSuperLargeTitleFont APPFONT(AppSuperLargeTitleFont_SIZE)
#define AppSuperLargeTitleFont_BOLD APPFONTBOLD(AppSuperLargeTitleFont_SIZE)
//大标题title字体
#define AppLargeTitleFont_SIZE (PSFont(52))
#define AppLargeTitleFont APPFONT(AppLargeTitleFont_SIZE)
#define AppLargeTitleFont_BOLD APPFONTBOLD(AppLargeTitleFont_SIZE)
//App最小的字体
#define AppNavCoupleButton_SIZE (PSFont(33))
#define AppNavCoupleButton APPFONT(AppNavCoupleButton_SIZE)
#define AppNavCoupleButton_BOLD APPFONTBOLD(AppNavCoupleButton_SIZE)
//App一般字体
#define AppFontNormal_SIZE (PSFont(60))
#define AppFontNormal APPFONT(AppFontNormal_SIZE)
#define AppFontNormal_BOLD APPFONTBOLD(AppFontNormal_SIZE)

//ps的字号转换
#define PSFont(x) kPSFontToiOSFont(x/3)
//ps的像素转换
#define PSViewPointToiOSViewPoint(x) (x/3)

#define FontName @"HelveticaNeue-Light"
#define FontNameBold @"HelveticaNeue-Medium"

#define APPFONT(R) kDEFAULT_FONT(FontName,kAdaptedWidth(R))
#define APPFONTBOLD(R) kDEFAULT_FONT(FontNameBold,kAdaptedWidth(R))

#define AppNullDataImage kImageNamed(@"image_empty")
#define AppNullDataString @"本页无数据"
#define AppMustLoginString @"您还没有登录"
#define AppMustLoginTapString @"点击屏幕登录"
#define AppNullDataTapString @"点击屏幕重新尝试"

//Appcell的通用高度
#define CellHeight PSViewPointToiOSViewPoint(230)*ViewScale
//App下拉框的高度
#define DropDownCellH 50
//App按钮角的弧度
#define AppRadius 5
//导航栏的高度(不带Status高度)
#define NavigationBarAddHeight 55
//导航栏的高度(用于我的界面)
#define MyViewControllerNavHeight NavigationBarAddHeight
//App所用的导航栏高度
#define NavigationBarNormalHeight (NavigationBarAddHeight+kScreenStatusBottom)
//导航栏按钮长宽
#define NavButtomH PSViewPointToiOSViewPoint(86)
#define NavButtomW PSViewPointToiOSViewPoint(205)

#define ViewScale (kSCREEN_WIDTH/iPhone6SPViewPointW)

//App的间隙
#define ViewSpace 10
//Cell的上下Space
#define CellSpace PSViewPointToiOSViewPoint(73)*ViewScale

//6SPPoint
#define iPhone6SPViewPointW 414
#define iPhone6SPViewPointH 736

//按钮内图片与字体的间隙
#define BackBtnSpace 5
////////////////
#define AppFooterHeight 15
#define TextViewH 44
#define ButtonH 44
#define RightArrowWH 11
#define GetMessageBtnW 100
#define TextAndMessageSpace 10
#define NavButonH 44
#define NavButonW 44
#define LineHeigh 0.5
#define VerticalImageAndTitleSpace 10 * ViewScale
#define BackImageW 44

#endif /* AVMacro_h */
