//
//  ViewController.m
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/3.
//  Copyright © 2019 psiot. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
   
    [self test4];
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

@end
