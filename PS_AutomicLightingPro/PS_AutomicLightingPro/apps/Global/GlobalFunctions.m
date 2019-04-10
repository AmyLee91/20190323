//
//  GlobalFunctions.m
//  PS_WisdomWork
//
//  Created by 李明明 on 2018/2/8.
//  Copyright © 2018年 www.psiot.com.cn. All rights reserved.
//

#import "GlobalFunctions.h"
#import "NSDate+convenience.h"
#import "UtilityMacro.h"

@implementation GlobalFunctions
+(NSString*)formatDateStringToDisplayToMinute:(NSString*)dateString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    NSDate* date = [formatter dateFromString:dateString];
    NSDateFormatter* formatter2 = [[NSDateFormatter alloc] init];
    formatter2.dateFormat = @"yyyy.MM.dd HH:mm";
    return [formatter2 stringFromDate:date];
}

+(NSString*)formatDateStringToDisplayToDay:(NSString*)dateString;
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    NSDate* date = [formatter dateFromString:dateString];
    NSDateFormatter* formatter2 = [[NSDateFormatter alloc] init];
    formatter2.dateFormat = @"yyyy.MM.dd";
    return [formatter2 stringFromDate:date];
}

// 时间戳转NSString
+(NSString*)formatSecToDisplayToDay:(NSString*)dateString WithFormat:(NSString*)format
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    long long lastactivityInterval = [dateString longLongValue];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval / 1000.0];
    
    return [formatter stringFromDate:date];
}
//字符串转时间戳
+(long long )convertSecondsWithTimeStr:(NSString *)timeStr
                            Format:(NSString*)dateFormat
{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
//    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:dateFormat];//@"yyyy-MM-dd HH:mm:ss"];
    NSDate* inputDate = [inputFormatter dateFromString:timeStr];
    NSTimeInterval timeStamp= [inputDate timeIntervalSince1970]*1000;
    
    return (long long)timeStamp;
}
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}
+(NSDate*)GetDateWith:(NSString*)dateString WithFormat:(NSString*)format
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSDate* date = [formatter dateFromString:dateString];

    return date;
}

+(NSData *) dataFromHexString:(NSString *) hexstr
{
    if (!hexstr || [hexstr length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([hexstr length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [hexstr length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [hexstr substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
    
  
//    NSMutableData *data = [[NSMutableData alloc] init];
//    NSString *inputStr = [hexstr uppercaseString];
//
//    NSString *hexChars = @"0123456789ABCDEF";
//
//    Byte b1,b2;
//    b1 = 255;
//    b2 = 255;
//    for (int i=0; i<hexstr.length; i++) {
//        NSString *subStr = [inputStr substringWithRange:NSMakeRange(i, 1)];
//        NSRange loc = [hexChars rangeOfString:subStr];
//
//        if (loc.location == NSNotFound) continue;
//
//        if (255 == b1) {
//            b1 = (Byte)loc.location;
//        }else {
//            b2 = (Byte)loc.location;
//
//            //Appending the Byte to NSData
//            Byte *bytes = malloc(sizeof(Byte) *1);
//            bytes[0] = ((b1<<4) & 0xf0) | (b2 & 0x0f);
//            [data appendBytes:bytes length:1];
//
//            b1 = b2 = 255;
//        }
//    }
//
//    return data;
}
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

+ (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr] ;
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
    
    
}
//将分钟时长转换成 几小时多少分
+(NSString*)formateHourMinWith:(NSInteger)MinLong
{
    NSInteger Hour= MinLong/60;
    NSInteger Min = MinLong-Hour*60;
    NSString * HourStr = @"";
    if (Hour>0) {
        HourStr = [NSString stringWithFormat:@"%ld%@",(long)Hour,@"小时"];
    }
    NSString *MinStr = @"";
    if (Min>0) {
        MinStr =[NSString stringWithFormat:@"%ld%@",(long)Min,@"分钟"];
    }
    
    return  [NSString stringWithFormat:@"%@%@",HourStr,MinStr];
}

// 186****9889
+(NSString *)getSecretPhone:(NSString *) phone;
{
    if(!phone || ![phone isKindOfClass:[NSString class]] || phone.length != 11){
        return @"";
    }
    NSInteger iLength = phone.length;
    NSString *strStart = [phone substringToIndex:3];
    NSString *strEnd = [phone substringFromIndex:iLength - 4];
    
    return [NSString stringWithFormat:@"%@****%@", strStart, strEnd];
}

//+(NSString*)getNoNullString:(NSString*) str
//{
//    return NoNullString(str);
//}
//+(NSNumber*)getNoNullNumber:(NSNumber*) num
//{
//    return NoNullNumber(num);
//}


+(NSString*)getAppBundleIdForTheApp
{
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    return [NSString stringWithFormat:@"%@_ios",bundleId];
}

//只显示后四位
+(NSString *)toCiphertextWithStr:(NSString *)str{
    if(!str || ![str isKindOfClass:[NSString class]] ){
        return @"";
    }

    if (str.length>4) {
     NSInteger iLength = str.length;
     NSString *strEnd = [str substringFromIndex:iLength - 4];//后四位
        NSMutableString *resultStr = [NSMutableString stringWithString:@""];
        for (int i =0; i< iLength-4; i++) {
            [resultStr appendString:@"*"];
        }
        [resultStr appendString:strEnd];

        return resultStr;
    }
     return str;

}
+(NSString*)FormatTheDate:(NSDate*)TheDate withFormat:(NSString*)formatStr
{
    
    NSDate *nowDate = [NSDate date];
    NSInteger ee =    [NSDate daysWithinEraFromDate:[nowDate gregorianDate]
                                             toDate:[TheDate gregorianDate]];
    NSString * dayStr = [GlobalFunctions formatSecToDisplayToDay:[NSString stringWithFormat:@"%lld",(long long)[TheDate timeIntervalSince1970]*1000] WithFormat:formatStr];
    NSString* apptDay = @"";
    if (ee ==0) {
        //同一天
        apptDay = [NSString stringWithFormat:@"%@ (%@)",NoNullString(dayStr),@"今天"];
    }
    else if (ee==1)
    {
        //明天
        apptDay= [NSString stringWithFormat:@"%@ (%@)",NoNullString(dayStr),@"明天"];
    }
    else if (ee ==2)
    {
        //后天
        apptDay = [NSString stringWithFormat:@"%@ %@",NoNullString(dayStr),@"(后天)"];
    }
    else
    {
        apptDay= NoNullString(dayStr);
    }
    
    return apptDay;
}
//当前时间的几天、几个月、几年后的时间
+(NSDate*)offsetData:(NSDate *)date year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    NSCalendar *calender2 = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [calender2 setFirstWeekday:2];// 国外是从周日 开始算的 我们是周一 所以 写了2
    
//    NSDateComponents *components2 = nil;
//    
//    components2 = [calender2 components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc]init];
    
    [adcomps setYear:year];
    
    [adcomps setMonth:month];
    
    [adcomps setDay:day];
    
    NSDate *newdate = [calender2 dateByAddingComponents:adcomps toDate:date options:0];
    
    return newdate;
}
@end
