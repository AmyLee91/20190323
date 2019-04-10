//
//  MainTabbarController.h
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/3.
//  Copyright © 2019 psiot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global_header.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainTabbarController : UITabBarController
/**
 设置小红点
 
 @param index tabbar下标
 @param isShow 是显示还是隐藏
 */
-(void)setRedDotWithIndex:(NSInteger)index withValue:(NSInteger)msgNum isShow:(BOOL)isShow;
@end

NS_ASSUME_NONNULL_END
