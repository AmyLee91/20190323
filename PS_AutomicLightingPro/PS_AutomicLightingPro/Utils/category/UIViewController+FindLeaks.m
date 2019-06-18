//
//  UIViewController+FindLeaks.m
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/30.
//  Copyright © 2019 psiot. All rights reserved.
//

#import "UIViewController+FindLeaks.h"


static const NSString *noCheckLeaksKey = @"noCheckLeaksKey";

@implementation UIViewController (FindLeaks)

#pragma mark - Binding Property
- (BOOL)noCheckLeaks {
    return [objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(noCheckLeaksKey)) boolValue];
}

- (void)setNoCheckLeaks:(BOOL)noCheckLeaks {
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(noCheckLeaksKey), [NSNumber numberWithBool:noCheckLeaks], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

#pragma mark - Check
+ (void)load {
    
#if DEBUG
    [self sy_swizzleInstanceSeletor:@selector(viewDidDisappear:) swizzleSeletor:@selector(fl_viewDidDisappear:)];
#endif
}

- (void)fl_viewDidDisappear:(BOOL)animated {
    [self fl_viewDidDisappear:animated];
    if (!self.noCheckLeaks) {
        [self fl_checkDeallocationAfterDelay:2];
    }
}

- (void)fl_checkDeallocationAfterDelay:(NSTimeInterval)delay {
    UIViewController *root = [self fl_rootParentViewController];
    if (self.isMovingFromParentViewController || root.isBeingDismissed) {
        NSString *type = NSStringFromClass([self class]);
        NSString *disappearanceSource = self.isMovingFromParentViewController ? @"removed from its parent" : @"dismissed";
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *assert = [NSString stringWithFormat:@"%@ not deallocated after being %@",
                                type, disappearanceSource];
            NSAssert(weakSelf == nil,assert);
        });
    }
}

- (UIViewController *)fl_rootParentViewController {
    UIViewController *root = self;
    while (root.parentViewController) {
        root = root.parentViewController;
    }
    return root;
}
@end


