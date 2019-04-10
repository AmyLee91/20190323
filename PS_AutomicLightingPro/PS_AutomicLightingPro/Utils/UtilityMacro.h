//
//  UtilityMacro.h
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/3.
//  Copyright © 2019 psiot. All rights reserved.
//

#ifndef UtilityMacro_h
#define UtilityMacro_h
#import "FontAndColorMacroHeader.h"

#define LOCALIZATION(text)  [NSString stringWithFormat:@"%@",NSLocalizedString(text, @"")]

//屏幕
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width
#define Tabbar_height  ([[UIScreen mainScreen] bounds].size.height > 811 ? 83:49)//tabbar高度  iphonex 是49+44
#define StatusBar_height ([[UIScreen mainScreen] bounds].size.height > 811 ? 44 :20)
#define Nav_height  (44+StatusBar_height)

#define NormalView_height  (Screen_height-Nav_height)
#define TabView_height   (NormalView_height - Tabbar_height)

//默认间距
#define KNormalSpace 16.0f

#define KNormalCellHeight 56.f

//系统
#define kAppDelegate [AppDelegate sharedAppDelegate]
#define KCurrNav [[AppDelegate sharedAppDelegate].getCurrentUIVC.navigationController
#define iOSVersionStr [[UIDevice currentDevice] systemVersion]
#define iOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define iOS7Later (iOSVersion >= 7.0)
#define iOS8Later (iOSVersion >= 8.0)
#define iOS9Later (iOSVersion >= 9.0)
#define iOS10Later (iOSVersion >= 10.0)
#define iOS11Later (iOSVersion >= 11.0)

#define isIPhone4 ([[UIScreen mainScreen] bounds].size.height == 480)
#define isIPhone5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define isIPhone6 ([[UIScreen mainScreen] bounds].size.height == 667)
#define isIPhone6P ([[UIScreen mainScreen] bounds].size.height == 736)
#define isBigIPhone ([[UIScreen mainScreen] bounds].size.height > 480)

#define isIPhoneX ([[UIScreen mainScreen] bounds].size.height == 812)

//app
#define myAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define myAppBundleIdentifier [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleIdentifierKey]

//适配
#define kScreenWidthRatio  (Screen_width / 375.0)
#define AdaptedSizeValue(x)  (ceilf((x) * kScreenWidthRatio))

//字体
#define kULSystemFont                @"FZLTXHK--GBK1-0"
#define kULSystemBoldFont                 @"FZLTZHK--GBK1-0"

#define kRectAdper(R)                (R / 375 * [UIScreen mainScreen].bounds.size.width)
#define kFontSizeAdper(R)            (R / 2 * [UIScreen mainScreen].scale)
#define UIFontSystem(R)             [UIFont fontWithName:kULSystemFont size: R]
#define UIFontBoldSystem(R)     [UIFont boldSystemFontOfSize: R]

//图片
#define UIImageNamed(x) [UIImage imageNamed:x]
#define UIImageViewNamed(x) [[UIImageView alloc] initWithImage:UIImageNamed(x)]
//字符串
//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]
#define NSStringFormatString(x) [NSString stringWithFormat:@"%@", x]
#define NSStringInt(x) [NSString stringWithFormat:@"%d", x]
#define NSStringInteger(x) [NSString stringWithFormat:@"%ld", x]
#define NSStringLongLong(x) [NSString stringWithFormat:@"%lld", x]
#define NSStringFloat(x) [NSString stringWithFormat:@"%f", x]
#define NSStringDouble(x) [NSString stringWithFormat:@"%lf", x]
#define NSStringFloatTwo(x) [NSString stringWithFormat:@"%.02f", x]
#define NSStringFloatOne(x) [NSString stringWithFormat:@"%.01f", x]

//非空

#define NoNullString(x) ((x && [x isKindOfClass:[NSString class]]) ? x : @"")
#define NoNullNumber(x) ((x && [x isKindOfClass:[NSNumber class]]) ? x : @(0))

#define NoNulllArr(x)  ((x && [x isKindOfClass:[NSArray class]]) ? x :@[])
#define NoNullDict(x) ((x && [x isKindOfClass:[NSDictionary class]]) ? x :@{})

//强弱引用
#define BlockSelf(x) __block typeof(self) x = self
#define WeakSelf(x) __weak typeof(self) x = self
#define StandardUserDefaults [NSUserDefaults standardUserDefaults]
#define DefaultNotificationCenter [NSNotificationCenter defaultCenter]
#define DefaultFileManager [NSFileManager defaultManager]

//数值
#define NSNumberZero [NSNumber numberWithInt:0]
#define NSNumberInt(x) [NSNumber numberWithInt:x]
#define NSNumberBool(x) [NSNumber numberWithBool:x]
#define NSNumberFloat(x) [NSNumber numberWithFloat:x]
#define NSNumberDouble(x) [NSNumber numberWithDouble:x]
#define NSNumberInteger(x) [NSNumber numberWithInteger:x]

//圆角、边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]


///IOS 版本判断
#define IOSAVAILABLEVERSION(version) ([[UIDevice currentDevice] availableVersion:version] < 0)
// 当前系统版本
#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]
//当前语言
#define CurrentLanguage ([NSLocale preferredLanguages] objectAtIndex:0])

//log
#if DEBUG
#define MyLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);};
#else
#define MyLog(fmt, ...){}
#endif


#endif /* UtilityMacro_h */
