//
//  NSUserDefaults+MJSaveCustomObject.h
//  CY_SmartOffice
//
//  Created by 丁浪涛 on 15/12/7.
//  Copyright © 2015年 丁浪涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (MJSaveCustomObject)
//序列化 存储的数据
-(void) mj_setCustomObject:(id)obj forKey:(NSString*)key;


/** Load to NSUserDefaults
 */
-(id) mj_customObjectForKey:(NSString*)key;

//存储、删除 实时同步
-(void)setObjectAndSync:(id)value forKey:(NSString *)defaultName;
-(void)removeObjectForKeyAndSync:(NSString *)defaultName;

@end
