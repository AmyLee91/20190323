//
//  NSArray+safe.m
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/4.
//  Copyright © 2019 psiot. All rights reserved.
//

#import "NSArray+safe.h"
#import <objc/runtime.h>

@implementation NSArray (safe)

/******
 Runtime 之 iOS黑魔法 - Method Swizzling 方法动态替换
 类簇：其实是一种抽象工厂的设计模式
 
 类                      “真身”
 NSArray                __NSArrayI
 NSMutableArray         __NSArrayM
 NSDictionary           __NSDictionaryI
 NSMutableDictionary    __NSDictionaryM
 
 ******/

+(void)load{
    [super load];
   
    //替换不可变数组方法 objectAtIndex：
  
    Method oldObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtSafeIndex:));
   method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
    
    
//    // 下标方法 arr[i] 替换
//    //    1.NSArray 的下标方法 替换 arr【i】
    Method old_objectAtIndexedSubscript = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:));
    Method new_objectAtIndexedSubscript = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript_swizzling:));
    method_exchangeImplementations(old_objectAtIndexedSubscript, new_objectAtIndexedSubscript);
    
    
    //替换可变数组方法 objectAtIndex：
    Method oldMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
    Method newMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(mutableObjectAtSafeIndex:));
    method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);
    
//    //可变数组下标法替换
    Method old_MutableObjectAtIndexedSubscript = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndexedSubscript:));
    Method new_MutableOAtIndexedSubscript = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(mutableObjectAtIndexedSubscript_swizzling:));
    method_exchangeImplementations(old_MutableObjectAtIndexedSubscript, new_MutableOAtIndexedSubscript);
    
}
- (id)objectAtSafeIndex:(NSUInteger)index
{
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self objectAtSafeIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
        
    }else {
        return [self objectAtSafeIndex:index];
    }
}
-(id)objectAtIndexedSubscript_swizzling:(NSInteger)idx{
    if (idx > self.count - 1 || !self.count) {
        @try {
            return [self objectAtIndexedSubscript_swizzling:idx];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
        
    }else {
        return [self objectAtIndexedSubscript_swizzling:idx];
    }
    
}
- (id)mutableObjectAtSafeIndex:(NSUInteger)index
{
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self mutableObjectAtSafeIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
        
    }else {
        return [self mutableObjectAtSafeIndex:index];
    }
}
-(id)mutableObjectAtIndexedSubscript_swizzling:(NSInteger)idx{
    if (idx > self.count - 1 || !self.count) {
        @try {
            return [self mutableObjectAtIndexedSubscript_swizzling:idx];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
        
    }else {
        return [self mutableObjectAtIndexedSubscript_swizzling:idx];
    }
    
}
@end
