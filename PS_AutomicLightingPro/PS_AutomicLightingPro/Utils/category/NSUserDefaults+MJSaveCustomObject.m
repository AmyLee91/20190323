//
//  NSUserDefaults+MJSaveCustomObject.m
//  CY_SmartOffice
//
//  Created by 丁浪涛 on 15/12/7.
//  Copyright © 2015年 丁浪涛. All rights reserved.
//

#import "NSUserDefaults+MJSaveCustomObject.h"

@implementation NSUserDefaults (MJSaveCustomObject)
 
-(void)mj_setCustomObject:(id)obj forKey:(NSString *)key {
    if ([obj respondsToSelector:@selector(encodeWithCoder:)] == NO) {
        NSLog(@"Error save object to NSUserDefaults. Object must respond to encodeWithCoder: message");
        return;
    }
    // 序列化
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
}

-(id)mj_customObjectForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    id obj = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return obj;
}

-(void)setObjectAndSync:(id)value forKey:(NSString *)defaultName
{
    [self setObject:value forKey:defaultName];
    [self synchronize];
}

-(void)removeObjectForKeyAndSync:(NSString *)defaultName
{
    [self removeObjectForKey:defaultName];
    [self synchronize];
}
@end
