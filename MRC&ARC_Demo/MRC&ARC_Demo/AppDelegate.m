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
    
    [self test1];
    
    
    return YES;
}
-(void)test{
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
    
}
/*** 058:core foundation对象来生成并持有NSMutableArray -***/
-(void)test1{
    CFMutableArrayRef cfObject = NULL;
    {
        id obj = [[NSMutableArray alloc]init];//生成并持有 对象A 的强引用，该对象引用计数为 1， 局部变量，超出作用域以后，会释放并废弃。
        cfObject = CFBridgingRetain(obj);//通过CFBridgingRetain，将对象A CFRetain，赋值给变量cfObject---此时引用计数为 2 ;需要在适当的时候手动释放，calling CFRelease
        CFShow(cfObject);//   Use CFShow() to printf the description of any CFType;
        printf("retain count : %ld\n",(long)CFGetRetainCount(cfObject));////作用域内的计数是 2
    }
    printf("retain count after the scope : %ld\n",(long)CFGetRetainCount(cfObject));//超出作用域，obj 的强引用失效。该对象的 obj 持有者已经释放，此时计数为1，
    CFRelease(cfObject); //将对象CFRelease ，引用计数为0，废弃该对象
}

/*打印结果：
 (
 )
 retain count : 2
 retain count after the scope : 1
 */
/*
 使用__bridge  转换来代替 CFBridgingRetain 或者 __bridge_retained
 */
-(void)test2{
    CFMutableArrayRef cfObject = NULL;
    {
        id obj = [[NSMutableArray alloc]init];//生成并持有 对象A 的强引用，该对象引用计数为 1， 局部变量，超出作用域以后，会释放并废弃。
        cfObject = (__bridge CFMutableArrayRef)(obj);//通过__bridge 转化不改变对象持有状态，此时引用计数为 1
        CFShow(cfObject);//   Use CFShow() to printf the description of any CFType;
        printf("retain count : %ld\n",(long)CFGetRetainCount(cfObject));////作用域内的计数是 1
    }
    //变量obj 超出作用域，其强引用失效。对象得到释放，此时计数为0，无持有者的对象被废弃
    //此后对对象的访问出错---悬垂指针******
    // printf("retain count after the scope : %ld\n",(long)CFGetRetainCount(cfObject));//这一步 Thread 1: EXC_BAD_ACCESS (code=1, address=0x2fc3fd0890c8)
    // CFRelease(cfObject); //将对象CFRelease ，引用计数为0，废弃该对象
}

/*打印结果：
 (
 )
 retain count : 1
 crash 到printf 这一步 Thread 1: EXC_BAD_ACCESS (code=1, address=0x2fc3fd0890c8)
 */

/**060 Core Foundation 的Api 生成并持有对象 **/
//用CFBridgingRelease 或__bridge_transfer 转换
-(void)test3{
    
    CFMutableArrayRef cfObject = CFArrayCreateMutable(kCFAllocatorDefault, 0, NULL);// 生成并持有对象A,引用计数为 1
    printf("retain count:%ld\n",(long)CFGetRetainCount(cfObject));
    {
        id obj = CFBridgingRelease(cfObject);//return (__bridge_transfer id)X;  CFBridgingRelease 赋值后强引用，通过CFRelease释放对象，引用计数还是 1
        //等价    id obj = (__bridge_transfer id)cfObject;
        printf("retain count after the cast:%ld\n",(long)CFGetRetainCount(cfObject));//只有变量obj 是对象A强引用,//经由CFBridgingRelease 转换后， 赋值给变量cfObject中的指针 也指向仍存在的对象，所以可以正常使用 cfObject
        
        NSLog(@"class====%@\n",obj);
    }
    /*
     变量obj 超出作用域，强引用失效，释放对象，引用计数为0 ，对象废弃
     */
    
}
/*输出结果：
 retain count:1
 retain count after the cast:1
 class====(
 )
 */

//使用 __bridge 替换 CFBridgingRelease 或__bridge_transfer进行转换
-(void)test4{
    
    {
        CFMutableArrayRef cfObject = CFArrayCreateMutable(kCFAllocatorDefault, 0, NULL);// 生成并持有对象A,引用计数为 1
        printf("retain count:%ld\n",(long)CFGetRetainCount(cfObject));
        
        id obj = (__bridge id)(cfObject);// 赋值给 附有__strong 修饰符的变量中，发生强引用，引用计数是 2
        printf("retain count after the cast:%ld\n",(long)CFGetRetainCount(cfObject));//对象没有进行CFRelease释放，所以引用计数还是 2
        NSLog(@"class====%@\n",obj);
    }
    // 变量obj 超出作用域，强引用失效，释放对象，引用计数为1 ，
    // 此时 计数是1 ，所以对象存在，可能发生内存泄漏
    
    
}
/*输出结果：
 retain count:1
 retain count after the cast:1
 class====(
 )
 */
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
