//
//  UITableViewCell+WQ.m
//  Leroad
//
//  Created by Jerry on 14/12/6.
//  Copyright (c) 2014年 dlt. All rights reserved.
//

#import "UITableViewCell+WQ.h"

@implementation UITableViewCell (WQ)

-(void)makeSeparateLineAlignLeft
{
    if ([self respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
