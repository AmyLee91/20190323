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
@class ToolItemBtn;

@interface ToolBar : UIScrollView
//@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *items;
@property(nonatomic,assign)BOOL canEidt;

@property(nonatomic,strong)void(^toAddNewItem)(NSString *imgName);
@end


@interface ToolItemBtn : UIButton

@property(nonatomic,strong)NSString *imgName;

@end

NS_ASSUME_NONNULL_END
