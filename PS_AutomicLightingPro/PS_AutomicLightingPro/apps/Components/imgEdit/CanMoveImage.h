//
//  CanMoveImage.h
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/9.
//  Copyright © 2019 psiot. All rights reserved.
//

/*****可移动的图片*****/

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN
@class MoveItemView;
@class CanMoveBgImageView;
@class CanMoveScrollView;
@interface CanMoveImage : UIImageView
@property(nonatomic,assign)BOOL canMove;
@property(nonatomic,strong)NSString *imgName;
@end
@interface CanMoveBgImageView : UIImageView

@end

@interface MoveItemView : UIView
@property(nonatomic,assign)BOOL canMove;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UIButton *deleteBtn;

@end

@interface CanMoveScrollView : UIScrollView

@end
NS_ASSUME_NONNULL_END
