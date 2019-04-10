//
//  MainTabbarController.m
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/3.
//  Copyright © 2019 psiot. All rights reserved.
//

#import "MainTabbarController.h"
#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "Global_header.h"
#import "PS_TabBar.h"
#import "UITabBar+CustomBadge.h"
#import "PS_HomePageViewController.h"
@interface MainTabbarController ()<UITabBarControllerDelegate>{

    
    
    NSMutableArray *Vcs;
    NSMutableArray *items;
}
@property(nonatomic,strong)UIPanGestureRecognizer *panGestureRecognizer;
@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    [self initAll];
    // tabbar 菜单 手势滑动
//    [self.view addGestureRecognizer:self.panGestureRecognizer];
    
    
}
#pragma mark ---- 初始化Tabbar -----
-(void)setUpTabBar{
    //设置背景色 分割线
    [self setValue:[PS_TabBar new] forKey:@"tabBar"];//替换类型
    [self.tabBar setBackgroundColor:KWhiteColor];
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage imageWithColor:CLineColor size:CGSizeMake(Screen_width, 1)]];
    //设置badge
    [self.tabBar setTabIconWidth:29];
    [self.tabBar setBadgeTop:9];
    
}
#pragma mark ---- 初始化 ------
-(void)initAll{
    [self setUpTabBar];
    
    Vcs = [[NSMutableArray alloc]initWithCapacity:1];
    items = [[NSMutableArray alloc]initWithCapacity:1];
    NSArray *arr = @[@{@"title":@"Home",@"image":@"icon_tabbar_homepage"},
                     @{@"title":@"New",@"image":@"icon_tabbar_device"},
                     @{@"title":@"Mine",@"image":@"icon_tabbar_mine"}];
    for (int i =0; i<arr.count; i++) {
        NSDictionary *dit = arr[i];
        if (i == 0) {
            PS_HomePageViewController * vc =[[PS_HomePageViewController alloc]init];
            vc.view.backgroundColor = KWhiteColor;
            [self setUpChildViewController:vc tabTitle:dit[@"title"] navTitle:dit[@"title"] imageName:dit[@"image"]];
                                    
        }else{
       
        BaseViewController *vc =[[BaseViewController alloc]init];
        vc.view.backgroundColor = KWhiteColor;
            [self setUpChildViewController:vc tabTitle:dit[@"title"] navTitle:dit[@"title"] imageName:dit[@"image"]];
            
        }
    }
    
    self.viewControllers = Vcs;
    self.tabBar.barTintColor = KWhiteColor;
    
}
-(void)setUpChildViewController:(BaseViewController*)controller tabTitle:(NSString *)tabTitle navTitle:(NSString *)navTitle imageName:(NSString *)imageName{
    
    controller.title = NoNullString(navTitle);
    controller.tabBarItem.title = NoNullString(tabTitle);
    controller.tabBarItem.image = [UIImageNamed(NoNullString(imageName)) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSString *selectedImg = [NSString stringWithFormat:@"%@_selected",imageName];
    controller.tabBarItem.selectedImage = [UIImageNamed(selectedImg) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabbar字体样式：选中、未选中颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:CFontColor1,NSFontAttributeName:FFont10} forState:UIControlStateNormal];
     [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MainBlueColor,NSFontAttributeName:FFont10} forState:UIControlStateSelected];
    
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:controller];
     [Vcs addObject:nav];
    
}
#pragma mark -- 手势滑动底部 tabbar 菜单
-(UIPanGestureRecognizer *)panGestureRecognizer{
    if (!_panGestureRecognizer) {
        _panGestureRecognizer =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizerAction:)];
        
    }
    return _panGestureRecognizer;
}
//手势-方法
-(void)panGestureRecognizerAction:(UIPanGestureRecognizer *)pan{
    //如果没有动画控制器，则不执行动画，动画控制器用来显示切换动画
    if(self.transitionCoordinator){
        return;
    }
    //开始执行动画
    if (pan.state == UIGestureRecognizerStateBegan ||pan.state == UIGestureRecognizerStateChanged) {
        [self beginInteractiveTransitionIfPossible:pan];
    }
    
}
//开始动画
-(void)beginInteractiveTransitionIfPossible:(UIPanGestureRecognizer *)pan{
    //通过滑动的方法判断应该向那边跳转
    CGPoint translation = [pan translationInView:self.view];
    
    if (translation.x>0 && self.selectedIndex>0 && pan.state == UIGestureRecognizerStateBegan) {
        self.selectedIndex--;
    }else if(translation.x<0 && self.selectedIndex+1 < self.viewControllers.count && pan.state == UIGestureRecognizerStateBegan){
        
        self.selectedIndex ++;
    }else{
        if (!CGPointEqualToPoint(translation, CGPointZero)) {
            pan.enabled = NO;
            pan.enabled = YES;
        }
    }
 
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
     NSLog(@"tabBarController:shouldSelectViewController");
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"tabBarController:didSelectViewController");
}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    NSLog(@"tabBarController:willBeginCustomizingViewControllers");
}
- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed {
    NSLog(@"tabBarController:willEndCustomizingViewControllers:%i",changed);
}
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed {
    NSLog(@"tabBarController:didEndCustomizingViewControllers:%i",changed);
}


- (UIInterfaceOrientationMask)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController {
    
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController *)tabBarController {
    return  UIInterfaceOrientationPortrait;
}
/**
 设置小红点
 **/
-(void)setRedDotWithIndex:(NSInteger)index withValue:(NSInteger)msgNum isShow:(BOOL)isShow{
    if (isShow) {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNumber value:msgNum atIndex:index];
    }else{
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNone value:msgNum atIndex:index];
    }
}


@end
