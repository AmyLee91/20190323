//
//  NormalAlgorithmKit.h
//  NormalSortPro
//
//  Created by Amy Lee on 2019/3/29.
//  Copyright © 2019 Amy Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NormalAlgorithmKit : NSObject

//非递归--二分查找
+(NSInteger)BinarySearchNoRecursion:(NSArray *)array target:(NSInteger)target;

//递归-二分查找
+(NSInteger)BinarySearchWithRecursion:(NSArray *)array target:(NSInteger)target begin:(NSInteger)begin end:(NSInteger)end;


//全排列
+(void)allArrangementWith:(NSMutableArray *)array withIndex:(NSInteger)index ;
@end

NS_ASSUME_NONNULL_END
