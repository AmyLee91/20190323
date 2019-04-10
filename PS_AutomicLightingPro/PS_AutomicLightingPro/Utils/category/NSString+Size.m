//
//  NSString+Size.m
//  CY_SmartOffice
//
//  Created by 丁浪涛 on 15/11/5.
//  Copyright © 2015年 丁浪涛. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

-(CGFloat)heightWithFont:(UIFont*)font width:(CGFloat)width
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttribute:NSFontAttributeName
                    value:font
                    range:NSMakeRange(0, self.length)];
    
    CGFloat height;
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                        options:options
                                        context:nil];     //57x- 测试
    height = ceilf(rect.size.height);
    return height+2;  // 加两个像素,防止emoji被切掉.
}


-(CGFloat)heightWithFont:(UIFont*)font width:(CGFloat)width InMaxHigh:(CGFloat)maxHigh
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttribute:NSFontAttributeName
                    value:font
                    range:NSMakeRange(0, self.length)];
    
    CGFloat height;
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(width, maxHigh)
                                        options:options
                                        context:nil];
    height = ceilf(rect.size.height);
    return height+2;  // 加两个像素,防止emoji被切掉.
    
}



//计算label宽度 不限制最大宽度
-(CGFloat)WidthWithFont:(UIFont*)font withHigh:(CGFloat)MaxHigh
{
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttribute:NSFontAttributeName
                    value:font
                    range:NSMakeRange(0, self.length)];
    
    CGFloat width;
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, MaxHigh+1)
                                        options:options
                                        context:nil];
    width = ceilf(rect.size.width);
    return width+2;  // 加两个像素,防止emoji被切掉.
    
}

//计算label宽度 限制最大宽度
-(CGFloat)WidthWithFont:(UIFont *)font withHigh:(CGFloat)MaxHigh InMaxWidth:(CGFloat)MaxWidth
{
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttribute:NSFontAttributeName
                    value:font
                    range:NSMakeRange(0, self.length)];
    
    CGFloat width;
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(MaxWidth, MaxHigh+1)
                                        options:options
                                        context:nil];
    width = ceilf(rect.size.width);
    return width+2;  // 加两个像素,防止emoji被切掉.
    
}

//算出sizetofite 宽度
-(CGFloat)autoWidthWIthFont:(UIFont*)font withTetx:(NSString*)text withMax:(CGFloat)MaxWidth
{
    UILabel *Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 16)];
    [Label setFont:font ];
    [Label setText:text];
    [Label sizeToFit];
    NSLog(@"%f",Label.frame.size.width);
    
    return Label.frame.size.width<=MaxWidth?Label.frame.size.width:MaxWidth-20;
}

@end
