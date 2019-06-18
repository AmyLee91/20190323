//
//  NSObject+Swizzle.m
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/30.
//  Copyright © 2019 psiot. All rights reserved.
//

#import "NSObject+Swizzle.h"

@implementation NSObject (Swizzle)
//方法动态替换
+(void)sy_swizzleInstanceSeletor:(SEL)origSeletor swizzleSeletor:(SEL)swizzleSelector{
    
    Method origMethod = class_getInstanceMethod(self, origSeletor);
    Method swizzleMethod = class_getInstanceMethod(self, swizzleSelector);
    
    BOOL isAdd = class_addMethod(self, origSeletor, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (!isAdd) {
        method_exchangeImplementations(origMethod, swizzleMethod);
    }else{
        class_replaceMethod(self, swizzleSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    
}
@end
