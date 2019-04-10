//
//  GlobalDevice.h
//  PS_WisdomWork
//
//  Created by 李明明 on 2018/2/8.
//  Copyright © 2018年 www.psiot.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#import "sys/utsname.h"
@interface GlobalDevice : NSObject

+ (NSString*)getBundlePath;
+ (NSString*)macAddress;

+(NSString*)platform;

//钥匙串中写入deviceToken
+(NSString*)UUIDDeviceToken;
@end
