//
//  NormalSortKit.h
//  NormalSortPro
//
//  Created by Amy Lee on 2019/3/28.
//  Copyright © 2019 Amy Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NormalSortKit : NSObject

//快排
+ (void)fastSort:(NSMutableArray *)array low:(int)low high:(int)high;
//冒泡排序
+(void)BubbleSort:(NSMutableArray *)array;
//选择排序
+(void)selectSort:(NSMutableArray *)array;
@end

NS_ASSUME_NONNULL_END
