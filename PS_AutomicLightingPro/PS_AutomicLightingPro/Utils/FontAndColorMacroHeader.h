//
//  FontAndColorMacroHeader.h
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/3.
//  Copyright © 2019 psiot. All rights reserved.
//

#ifndef FontAndColorMacroHeader_h
#define FontAndColorMacroHeader_h
#import "UIColor+Kits.h"
/****************色值*******************/
#define ColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define ColorWithRGB(r,g,b) ColorWithRGBA(r,g,b,1)
#define ColorWithHexRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]
#define ColorWithHexRGB(rgbValue) ColorWithHexRGBA(rgbValue,1.0)

#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]
#define KClearColor [UIColor clearColor]
//主题色 导航栏颜色
#define CNavBgColor  [UIColor colorWithHexString:@"ffffff"]  //(255,255,255)

//导航栏字体颜色
#define CNavBgFontColor  [UIColor colorWithHexString:@"3E3E3E"]//(62,62,62)

//默认页面背景色
#define CViewBgColor [UIColor colorWithHexString:@"F7F7F7"] //(247,247,247)

//分割线颜色
#define CLineColor [UIColor colorWithHexString:@"EBEBEB"]  //(235,235,235)

//主蓝色
#define MainBlueColor [UIColor colorWithHexString:@"347AFC"]  //(52，122，252)

#define CMainTitleColor [UIColor colorWithHexString:@"393D49"] //57.61.73

//登录按钮蓝色色
#define BuleColor1 [UIColor colorWithHexString:@"25E3EF"]  //(37，227，239)

//黑色色标题字体
#define CMainFontColor [UIColor colorWithHexString:@"3E3E3E"]//(62,62,62)

//浅灰色标题字体
#define CFontColor1 [UIColor colorWithHexString:@"959392"]//((149，147，146))

//更浅浅灰色标题字体
#define CFontColor2 [UIColor colorWithHexString:@"CFCECF"]//(207，206，207)

//主红色调
#define CMainRedColor [UIColor colorWithHexString:@"F65147"]//(246,81,71)
//随机色
#define CRandomColor [UIColor random]

/****************字体*****************/
#define FFont17 [UIFont systemFontOfSize:17]
#define FFont16 [UIFont systemFontOfSize:16]
#define FFont14 [UIFont systemFontOfSize:14]
#define FFont12 [UIFont systemFontOfSize:12]
#define FFont10 [UIFont systemFontOfSize:10]

#endif /* FontAndColorMacroHeader_h */
