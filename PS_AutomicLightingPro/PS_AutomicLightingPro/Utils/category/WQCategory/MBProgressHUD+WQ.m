//
//  MBProgressHUD+WQ.m
//  Leroad
//
//  Created by Jerry on 14/12/6.
//  Copyright (c) 2014年 dlt. All rights reserved.
//

#import "MBProgressHUD+WQ.h"
#import "GlobalDef.h"
#import "UtilityMacro.h"
@implementation MBProgressHUD (WQ)

+(instancetype)showHUDAddedToWindowAnimated:(BOOL)animated
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD* hud = [self showHUDAddedTo:window animated:animated];
    return hud;
}

+(NSUInteger)hideAllHUDsForWindowAnimated:(BOOL)animated
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    return [self hideAllHUDsForView:window animated:animated];
}

+(instancetype)showHUDAddedTo:(UIView *)view message:(NSString*)message animated:(BOOL)animated
{
    MBProgressHUD* hud = [self showHUDAddedTo:view animated:animated];
    hud.mode = MBProgressHUDModeText;
//    hud.labelText = message;
//    hud.labelFont = UIFontSystem(14.f);
    hud.detailsLabel.text = message;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];//UIFontSystem(14.f);
    return hud;
}

+(instancetype)showHUDAddedTo:(UIView *)view message:(NSString*)message animated:(BOOL)animated hideDelay:(NSTimeInterval)delay
{
    MBProgressHUD* hud = [self showHUDAddedTo:view message:message animated:animated];
    [hud hideAnimated:animated afterDelay:delay];
    return hud;
}

+(instancetype)showHUDAddedToWindowWithMessage:(NSString*)message animated:(BOOL)animated hideDelay:(NSTimeInterval)delay
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD* hud = [self showHUDAddedTo:window message:message animated:animated hideDelay:delay];
    return hud;
}

+(instancetype)showAutoHideHUDAddedTo:(UIView *)view message:(NSString*)message animated:(BOOL)animated
{
    MBProgressHUD* hud = [self showHUDAddedTo:view message:message animated:animated];
    [hud hideAnimated:animated afterDelay:1.5];
    return hud;
}

+(instancetype)showAutoHideHUDAddedToWindowWithMessage:(NSString*)message animated:(BOOL)animated
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD* hud = [self showAutoHideHUDAddedTo:window message:message animated:animated];
    return hud;
}

+(instancetype)showLoadingHUDAddedTo:(UIView *)view message:(NSString*)message animated:(BOOL)animated
{
    MBProgressHUD* hud = [self showHUDAddedTo:view animated:animated];
     hud.contentColor =  ColorWithRGBA(52, 122, 252, 1);//蓝色loading
    
    hud.detailsLabel.text = message;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    return hud;
}

+(instancetype)showLoadingHUDAddedToWindowWithMessage:(NSString*)message animated:(BOOL)animated
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD* hud = [self showHUDAddedTo:window animated:animated];
    hud.contentColor =  ColorWithRGBA(52, 122, 252, 1);//(52，122，252)蓝色loading
    hud.detailsLabel.text = message;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
   
    return hud;
}

+(instancetype)showHUDAddedTo:(UIView *)view message:(NSString*)message animated:(BOOL)animated hideDelay:(NSTimeInterval)delay withCompleteBlock:(MBProgressHUDCompletionBlock)block
{
    MBProgressHUD* hud = [self showHUDAddedTo:view message:message animated:animated];
    [hud setCompletionBlock:block];
    [hud hideAnimated:animated afterDelay:delay];
    return hud;
}
@end
