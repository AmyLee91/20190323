//
//  BaseNavigationController.m
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/3.
//  Copyright © 2019 psiot. All rights reserved.
//

#import "BaseNavigationController.h"
#import "Global_header.h"
#import "BaseViewController.h"
@interface BaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

//App 生命周期中，只会执行一次
+(void)initialize{
    
    //导航栏文字、背景色
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:[UIColor whiteColor]];
    [navBar setTintColor:[UIColor whiteColor]];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:CNavBgFontColor,NSFontAttributeName:FFont17}];
    
    [navBar setBackgroundImage:[UIImage imageWithColor:KWhiteColor size:CGSizeMake(Screen_width, Nav_height)] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage imageWithColor:CLineColor size:CGSizeMake(Screen_width,1)]];
    //去掉阴影
   // [navBar setShadowImage:[UIImage new]];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    //默认开启系统右划返回
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    NSLog(@"当前控制器vcs：%lu",(unsigned long)self.viewControllers.count);
    
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
       
        //系统OS12.1 UINavigationController + UITabBarController（ UITabBar 磨砂），在popViewControllerAnimated 会遇到tabbar布局错乱的问题：
//        [UITabBar appearance].translucent = NO;
        
        //设置返回键
        if( [viewController isKindOfClass:[BaseViewController class]]){
            [(BaseViewController*)viewController setIsShowLiftBack:YES];
        }
    }
    
    [super pushViewController:viewController animated:animated];
    
    // 修改tabBra的frame--偏移问题
//    CGRect frame = self.tabBarController.tabBar.frame;
//    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
//    self.tabBarController.tabBar.frame = frame;
    
}
#pragma mark --UINavigationControllerDelegate

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([viewController isKindOfClass:[BaseViewController class]]) {
        BaseViewController * vc = (BaseViewController *)viewController;
        if (vc.isHidenNaviBar) {
            vc.view.top = 0;
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        }else{
            vc.view.top = Nav_height;
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}

@end
