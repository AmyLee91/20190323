//
//  MBProgressHUD+WQ.h
//  Leroad
//
//  Created by Jerry on 14/12/6.
//  Copyright (c) 2014年 dlt. All rights reserved.
//
//#import "PodsHeader.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (WQ)

/**
 *  显示加载HUD，加到keyWindow上
 */
+(instancetype)showHUDAddedToWindowAnimated:(BOOL)animated;
/**
 *  移除window上所有HUD
 */
+(NSUInteger)hideAllHUDsForWindowAnimated:(BOOL)animated;
/**
 *  显示提示信息的HUD
 */
+(instancetype)showHUDAddedTo:(UIView *)view message:(NSString*)message animated:(BOOL)animated;
/**
 *  指定时间隐藏的HUD，加到view上
 */
+(instancetype)showHUDAddedTo:(UIView *)view message:(NSString*)message animated:(BOOL)animated hideDelay:(NSTimeInterval)delay;
/**
 *  指定时间隐藏的HUD，加到keyWindow上
 */
+(instancetype)showHUDAddedToWindowWithMessage:(NSString*)message animated:(BOOL)animated hideDelay:(NSTimeInterval)delay;
/**
 *  自动隐藏的HUD，加到view上
 */
+(instancetype)showAutoHideHUDAddedTo:(UIView *)view message:(NSString*)message animated:(BOOL)animated;
/**
 *  自动隐藏的HUD，加到keyWindow上
 */
+(instancetype)showAutoHideHUDAddedToWindowWithMessage:(NSString*)message animated:(BOOL)animated;
/**
 *  显示loading HUD，指定message，加到view上
 */
+(instancetype)showLoadingHUDAddedTo:(UIView *)view message:(NSString*)message animated:(BOOL)animated;
/**
 *  显示loading HUD，指定message，加到keyWindow上
 */
+(instancetype)showLoadingHUDAddedToWindowWithMessage:(NSString*)message animated:(BOOL)animated;
/**
 *  指定时间隐藏的HUD，加到view上,含完成后block
 */
+(instancetype)showHUDAddedTo:(UIView *)view message:(NSString*)message animated:(BOOL)animated hideDelay:(NSTimeInterval)delay withCompleteBlock:(MBProgressHUDCompletionBlock)block;

@end
