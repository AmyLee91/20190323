//
//  UITableView+WQ.m
//  Leroad
//
//  Created by Jerry on 14/12/6.
//  Copyright (c) 2014年 dlt. All rights reserved.
//

#import "UITableView+WQ.h"
#import "UtilityMacro.h"

@implementation UITableView (WQ)

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

-(void)makeAlignTop
{
    if (self.style == UITableViewStyleGrouped)
    {
        if (iOS7Later)
        {
            UIEdgeInsets insets = self.contentInset;
            insets.top = -35;
            self.contentInset = insets;
        }
    }
}

-(void)makeAlignBottom
{
    if (self.style == UITableViewStyleGrouped)
    {
        if (iOS7Later)
        {
            UIEdgeInsets insets = self.contentInset;
            insets.bottom = -35;
            self.contentInset = insets;
        }
    }
}

@end
