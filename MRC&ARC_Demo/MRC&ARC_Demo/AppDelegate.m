//
//  AppDelegate.m
//  MRC&ARC_Demo
//
//  Created by Amy Lee on 2019/3/26.
//  Copyright © 2019 Amy Lee. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreText/CTFont.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //测试MRC
    //给 AppDelegate.m 加上 -fno-objc-arc 的编译参数
    //通过log查看引用计数
//    NSObject *obje = [[NSObject alloc]init];
//    NSLog(@"Reference count:%lu",(unsigned long)[obje retainCount]);
//    NSObject *other_obj = [obje retain];//// 使用retain引用计数+1，此时引用计数为2
//     NSLog(@"Reference count:%lu",(unsigned long)[obje retainCount]);
//    [other_obj release];//// 使用release引用计数-1，此时引用计数为1
//     NSLog(@"Reference count:%lu",(unsigned long)[obje retainCount]);
//    [obje release];//到这里，obje的内存已经被释放了
    
    
    //Core Foundation 对象的内存管理
    //1.创建一个CFStringFRef 对象
    CFStringRef str = CFStringCreateWithCString(kCFAllocatorDefault, @"hello world", kCFStringEncodingUTF8);
    // 2.创建一个CTFontRef对象
    CTFontRef fontRef = CTFontCreateWithName(((CFStringRef)@"ArialMT"), 12, NULL);
    
    //引用计数 +1
    CFRetain(fontRef);
     NSLog(@"Reference count:%lu",(unsigned long)[fontRef retainCount]);
     //引用计数 -1
    CFRelease(fontRef);
      NSLog(@"Reference count:%lu",(unsigned long)[str retainCount]);
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
