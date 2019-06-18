//
//  UIViewController+FindLeaks.h
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/30.
//  Copyright © 2019 psiot. All rights reserved.
//

//内存泄露检测
#import <UIKit/UIKit.h>
#import "NSObject+Swizzle.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (FindLeaks)
// 默认NO
@property(nonatomic)BOOL noCheckLeaks;
@end




NS_ASSUME_NONNULL_END
