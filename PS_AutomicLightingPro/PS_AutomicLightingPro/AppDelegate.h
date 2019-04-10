//
//  AppDelegate.h
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/3.
//  Copyright © 2019 psiot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MainTabbarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)MainTabbarController *mainTabbar;

//@property (readonly, strong) NSPersistentContainer *persistentContainer;

//- (void)saveContext;


@end

