//
//  UIView+Constraint.m
//  MyApp
//
//  Created by vicky on 15/5/19.
//  Copyright (c) 2015年 dlt. All rights reserved.
//

#import "UIView+Constraint.h"
#import "ConstraintPack.h"
@implementation UIView (Constraint)

-(void)removeAllConstraints
{
    RemoveConstraints(self.constraintReferences);
}

-(void)removeExternalConstraints
{
    RemoveConstraints(self.externalConstraintReferences);
}

-(void)removeInternalConstraints
{
    RemoveConstraints(self.internalConstraintReferences);
}

@end
