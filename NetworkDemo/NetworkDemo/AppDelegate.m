//
//  AppDelegate.m
//  NetworkDemo
//
//  Created by Amy Lee on 2019/3/27.
//  Copyright © 2019 Amy Lee. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //    [self get1];
    //    [self get2];
//        [self post];
    return YES;
}
//发送GET请求
//
//　　使用NSURLSession发送GET请求的方法和NSURLConnection类似，整个过程如下：
//
//　　　　1）确定请求路径（一般由公司的后台开发人员以接口文档的方式提供），GET请求参数直接跟在URL后面
//
//　　　　2）创建请求对象（默认包含了请求头和请求方法【GET】），此步骤可以省略
//
//　　　　3）创建会话对象（NSURLSession）
//
//　　　　4）根据会话对象创建请求任务（NSURLSessionDataTask）
//
//　　　　5）执行Task
//
//　　　　6）当得到服务器返回的响应后，解析数据（XML|JSON|HTTP）


//NSURLSession GET 请求
-(void)get1
{
    //对请求路径的说明
    //http://127.0.0.1:8000/login?username=abc&pwd=123456
    //协议头+主机地址+接口名称+？+参数1&参数2&参数3
    //协议头(http://)+主机地址(127.0.0.1:8000)+接口名称(login)+？+参数1(username=abc)&参数2(pwd=123456)
    //GET请求，直接把请求参数跟在URL的后面以？隔开，多个参数之间以&符号拼接
    
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8000/login?username=abc&pwd=123456"];
    
    //2.创建请求对象
    //请求对象内部默认已经包含了请求头和请求方法（GET）
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            //6.解析服务器返回的数据
            //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            NSLog(@"%@",dict);
        }
    }];
    
    //5.执行任务
    [dataTask resume];
}

-(void)get2
{
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8000/login?username=abc&pwd=123456"];
    
    //2.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //3.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求路径
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     注意：
     1）该方法内部会自动将请求路径包装成一个请求对象，该请求对象默认包含了请求头信息和请求方法（GET）
     2）如果要发送的是POST请求，则不能使用该方法
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //5.解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        
    }];
    
    //4.执行任务
    [dataTask resume];
}
//发送POST请求
//
//　　使用NSURLSession发送POST请求的方法和NSURLConnection类似，整个过程如下：
//
//　　　　1）确定请求路径（一般由公司的后台开发人员以接口文档的方式提供）
//
//　　　　2）创建可变的请求对象（因为需要修改），此步骤不可以省略
//
//　　　　3）修改请求方法为POST
//
//　　　　4）设置请求体，把参数转换为二进制数据并设置请求体
//
//　　　　5）创建会话对象（NSURLSession）
//
//　　　　6）根据会话对象创建请求任务（NSURLSessionDataTask）
//
//　　　　7）执行Task
//
//　　　　8）当得到服务器返回的响应后，解析数据（XML|JSON|HTTP）
-(void)post
{
    //对请求路径的说明
    //http://127.0.0.1:8000/login
    //协议头+主机地址+接口名称
    //协议头(http://)+主机地址(127.0.0.1:8000)+接口名称(login)
    //POST请求需要修改请求方法为POST，并把参数转换为二进制数据设置为请求体
    
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8000/login"];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
    request.HTTPBody = [@"username=abc&pwd=123456" dataUsingEncoding:NSUTF8StringEncoding];
    
    //6.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //8.解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        
    }];
    
    //7.执行任务
    [dataTask resume];
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
