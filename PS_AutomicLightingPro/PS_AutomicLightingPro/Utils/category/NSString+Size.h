//
//  NSString+Size.h
//  CY_SmartOffice
//
//  Created by 丁浪涛 on 15/11/5.
//  Copyright © 2015年 丁浪涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Size)

 
// 计算label高度 不限制最大高度
-(CGFloat)heightWithFont:(UIFont*)font width:(CGFloat)width;

//计算label高度 限制最大高度
-(CGFloat)heightWithFont:(UIFont*)font width:(CGFloat)width InMaxHigh:(CGFloat)maxHigh;


//计算label宽度 不限制最大宽度
-(CGFloat)WidthWithFont:(UIFont*)font withHigh:(CGFloat)MaxHigh;

//计算label宽度 限制最大宽度
-(CGFloat)WidthWithFont:(UIFont *)font withHigh:(CGFloat)MaxHigh InMaxWidth:(CGFloat)MaxWidth;

//算出sizetofite 宽度
//算出sizetofite 宽度
-(CGFloat)autoWidthWIthFont:(UIFont*)font withTetx:(NSString*)text withMax:(CGFloat)MaxWidth;

@end
