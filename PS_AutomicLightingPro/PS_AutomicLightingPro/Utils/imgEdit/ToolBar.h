//
//  ToolBar.h
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/9.
//  Copyright © 2019 psiot. All rights reserved.
//

/***  底部工具栏  ***/

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToolBar : BaseView

@property(nonatomic,strong)NSMutableSet *items;
@property(nonatomic,assign)BOOL canEidt;

@end

NS_ASSUME_NONNULL_END
