//
//  MRC_Object.h
//  Pro_BasedOnBooks
//
//  Created by Amy Lee on 2019/4/1.
//  Copyright © 2019 Amy Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MRC_Object : NSObject

// 引用计数+1 的操作
+(void)RetainCountIncrease;


@end

NS_ASSUME_NONNULL_END
