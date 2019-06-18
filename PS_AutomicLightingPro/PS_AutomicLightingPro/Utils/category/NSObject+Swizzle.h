//
//  NSObject+Swizzle.h
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/30.
//  Copyright © 2019 psiot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzle)
//方法动态替换
+(void)sy_swizzleInstanceSeletor:(SEL)origSeletor swizzleSeletor:(SEL)swizzleSelector;
@end

NS_ASSUME_NONNULL_END
