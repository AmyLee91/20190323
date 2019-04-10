//
//  UIView+Constraint.h
//  MyApp
//
//  Created by vicky on 15/5/19.
//  Copyright (c) 2015年 dlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Constraint)

/**
 *  删除所有约束
 */
-(void)removeAllConstraints;
/**
 *  删除外部约束
 */
-(void)removeExternalConstraints;
/**
 *  删除内部约束
 */
-(void)removeInternalConstraints;

@end
