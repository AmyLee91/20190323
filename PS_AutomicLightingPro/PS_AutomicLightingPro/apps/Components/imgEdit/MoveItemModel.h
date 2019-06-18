//
//  MoveItemModel.h
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/12.
//  Copyright © 2019 psiot. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ItemFrame;
@interface MoveItemModel : NSObject
//@property(nonatomic,strong)UIView *obj;
@property(nonatomic,strong)NSString *imgName;
@property(nonatomic,strong)ItemFrame *frame;
@property(nonatomic,strong)NSString *className;

@end

@interface ItemFrame : NSObject

@property(nonatomic,assign)double x;
@property(nonatomic,assign)double y;
@property(nonatomic,assign)double w;
@property(nonatomic,assign)double h;


@end

NS_ASSUME_NONNULL_END
