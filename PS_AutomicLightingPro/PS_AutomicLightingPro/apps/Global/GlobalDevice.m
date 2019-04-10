//
//  GlobalDevice.m
//  PS_WisdomWork
//
//  Created by 李明明 on 2018/2/8.
//  Copyright © 2018年 www.psiot.com.cn. All rights reserved.
//

#import "GlobalDevice.h"
#import "SSKeychain.h"
#import "OpenUDID.h"

NSString *kSSToolkitlianlianServiceName = @"psiotServiceName";
NSString *kSSToolkitlianlianAccountName = @"SSToolkitpsiotAccount";
@implementation GlobalDevice
+(NSString *)getBundlePath{
    return  [[NSBundle mainBundle] bundlePath];
}

+(NSString*)platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    //NSString *platform = [NSString stringWithCString:machine];
    NSString* platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString*)macAddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return outstring;
}



+(NSString*)UUIDDeviceToken
{
   NSString *deviceTokenStr  =  [SSKeychain passwordForService:kSSToolkitlianlianServiceName account:kSSToolkitlianlianAccountName];
    if(!deviceTokenStr||![deviceTokenStr isKindOfClass:[NSString class]]||[deviceTokenStr length]<=0)
    {
        NSString *tempopenUDID = [OpenUDID value];
        [SSKeychain setPassword:tempopenUDID forService:kSSToolkitlianlianServiceName account:kSSToolkitlianlianAccountName];
        
        deviceTokenStr = tempopenUDID;
    }
    
    return deviceTokenStr;
}
@end
