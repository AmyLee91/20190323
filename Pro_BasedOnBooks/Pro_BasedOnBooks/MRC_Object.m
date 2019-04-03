//
//  MRC_Object.m
//  Pro_BasedOnBooks
//
//  Created by Amy Lee on 2019/4/1.
//  Copyright © 2019 Amy Lee. All rights reserved.
//

//不使用ARC自动内存管理机制：-fno-objc-arc

#import "MRC_Object.h"
@interface MRC_Object()

@end


@implementation MRC_Object


+ (instancetype)alloc{
   return  [super alloc];
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return  [super allocWithZone:zone];
}
+(void)RetainCountIncrease{
    
    NSObject *obj = [[self alloc]init];

    NSUInteger obj_retCount = [obj retainCount];
    NSLog(@"当前引用计数：%lu",(unsigned long)obj_retCount);
     NSLog(@"当前引用计数：%lu",(unsigned long)obj_retCount);
     NSLog(@"当前引用计数：%lu",(unsigned long)obj_retCount);

    id obj_1 =  [obj retain];
    NSLog(@"当前引用计数：%lu",(unsigned long)[obj_1 retainCount]);

    [obj release];
    NSLog(@"当前引用计数：%lu",(unsigned long)[obj retainCount]);
//
 
    
}

-(id)allObject{
    //自己生成并持有
    id obj = [[NSObject alloc]init];
    //自己持有对象
    return obj;
}

-(void)test{
    //获取非自己生成但持有的对象
    id obj1 = [self allObject];
    //自己持有
    NSLog(@"%@",obj1);
}

-(id)object{
    id obj = [[NSObject alloc]init];
    //自己持有
    
    [obj autorelease];
    //取得对象的存在，但自己不持有对象
    
    return obj;
}


@end
