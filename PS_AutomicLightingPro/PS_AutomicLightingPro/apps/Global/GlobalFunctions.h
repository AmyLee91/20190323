//
//  GlobalFunctions.h
//  PS_WisdomWork
//
//  Created by 李明明 on 2018/2/8.
//  Copyright © 2018年 www.psiot.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//C/C++
void MyNSLog(NSString* log, ...);

@interface GlobalFunctions : NSObject

+(NSString*)formatDateStringToDisplayToMinute:(NSString*)dateString;
+(NSString*)formatDateStringToDisplayToDay:(NSString*)dateString;

// 时间戳转NSString
+(NSString*)formatSecToDisplayToDay:(NSString*)dateString WithFormat:(NSString*)format;
//字符串转时间戳
+(long long )convertSecondsWithTimeStr:(NSString *)timeStr
                                Format:(NSString*)dateFormat;
//四舍五入
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV;

//格式化的时间 转NSData
+(NSDate*)GetDateWith:(NSString*)dateString WithFormat:(NSString*)format;

//将时间格式化成今天明天
+(NSString*)FormatTheDate:(NSDate*)TheDate withFormat:(NSString*)formatStr;

//将分钟时长转换成 几小时多少分
+(NSString*)formateHourMinWith:(NSInteger)MinLong;
//Hex字符串转NSData
+(NSData *) dataFromHexString:(NSString *) hexstr;
+ (NSString *)hexStringFromString:(NSString *)string;
+ (NSString *)stringFromHexString:(NSString *)hexString;

// 186****9889
+(NSString *)getSecretPhone:(NSString *) phone;
//只显示后四位
+(NSString *)toCiphertextWithStr:(NSString *)str;
//+(NSString*)getNoNullString:(NSString*) str;
//+(NSNumber*)getNoNullNumber:(NSNumber*) num;

//获取我们应用的Bundle_id
+(NSString*)getAppBundleIdForTheApp;

//当前时间的几天、几个月、几年后的时间
+(NSDate*)offsetData:(NSDate *)date year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end
