//
//  BaseNavigationController.m
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/3.
//  Copyright © 2019 psiot. All rights reserved.
//

#import "BaseNavigationController.h"
#import "Global_header.h"

@interface BaseNavigationController ()

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
