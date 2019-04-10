//
//  CanMoveImage.m
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/9.
//  Copyright © 2019 psiot. All rights reserved.
//

#import "CanMoveImage.h"

@implementation CanMoveImage

-(void)setCanMove:(BOOL)canMove{
    _canMove = canMove;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"图片-开始触摸-touchesBegan");
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"图片-移动-touchesMoved");
    UITouch *touch = [touches anyObject];
    UIView *targetView = touch.view;
    //本次触点
    CGPoint currentPoint = [touch locationInView:targetView.superview];
    //上次触点
    CGPoint prePoint = [touch previousLocationInView:targetView.superview];
    //未移动的中心点
    CGPoint center = targetView.center;
    if (self.canMove) {
        //移动之后，中心点（未移动点+本次触摸点-上次触摸点）
        center.x += currentPoint.x-prePoint.x;
        center.y += currentPoint.y-prePoint.y;
        //更新位置
        targetView.center = center;
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"图片-触摸结束-touchesEnded");
}
@end
