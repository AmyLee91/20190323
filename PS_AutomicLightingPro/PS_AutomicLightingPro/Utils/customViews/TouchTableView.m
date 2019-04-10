//
//  TouchTableView.m
//  MyApp
//
//  Created by Apple on 15/2/1.
//  Copyright (c) 2015年 dlt. All rights reserved.
//

#import "TouchTableView.h"

@implementation TouchTableView
@synthesize touchDelegate = _touchDelegate;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableViewDelegate)] &&
        [_touchDelegate respondsToSelector:@selector(tableView:touchesBegan:withEvent:)])
    {
        [_touchDelegate tableView:self touchesBegan:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableViewDelegate)] &&
        [_touchDelegate respondsToSelector:@selector(tableView:touchesCancelled:withEvent:)])
    {
        [_touchDelegate tableView:self touchesCancelled:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableViewDelegate)] &&
        [_touchDelegate respondsToSelector:@selector(tableView:touchesEnded:withEvent:)])
    {
        [_touchDelegate tableView:self touchesEnded:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableViewDelegate)] &&
        [_touchDelegate respondsToSelector:@selector(tableView:touchesMoved:withEvent:)])
    {
        [_touchDelegate tableView:self touchesMoved:touches withEvent:event];
    }
}

@end
