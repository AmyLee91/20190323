//
//  UIColor+Kits.h
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/3.
//  Copyright © 2019 psiot. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Kits)


#pragma mark - convienience
+(UIColor *)random;
+(UIColor *)colorfromR:(int)aRed g:(int)aGreen b:(int)aBlue;
+(UIColor *)colorfromR:(int)aRed g:(int)aGreen b:(int)aBlue a:(CGFloat)anAlpha;
+(UIColor *)colorWithString:(NSString *)colorString;
+(UIColor *)colorWithHex:(UInt32)col withAlpha:(NSString*)alphaStr;

// 默认alpha位1
+ (UIColor *)colorWithHexString:(NSString *)color;
//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
