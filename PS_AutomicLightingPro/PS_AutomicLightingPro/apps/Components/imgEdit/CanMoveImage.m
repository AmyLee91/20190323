//
//  CanMoveImage.m
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/9.
//  Copyright © 2019 psiot. All rights reserved.
//

#import "CanMoveImage.h"

@implementation CanMoveImage

@end

@implementation  CanMoveBgImageView : UIImageView

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    UITouch *touch = [touches anyObject];
    UIView *targetView = touch.view;
    UIView *superView = targetView.superview;
    
    //本次触点
    CGPoint currentPoint = [touch locationInView:targetView.superview];
    //上次触点
    CGPoint prePoint = [touch previousLocationInView:targetView.superview];
    //未移动的中心点
    CGPoint center = targetView.center;
    BOOL canMove = NO;
    if ([targetView isKindOfClass:[CanMoveImage class]]) {

        CanMoveImage* currView = (CanMoveImage*) targetView;

        canMove = currView.canMove;
        
    }
    if ([targetView isKindOfClass:[MoveItemView class]]) {

        MoveItemView* currView = (MoveItemView*) targetView;
         canMove = currView.canMove;
//        if (currView.canMove) {
//            //移动之后，中心点（未移动点+本次触摸点-上次触摸点）
//            center.x += currentPoint.x-prePoint.x;
//            center.y += currentPoint.y-prePoint.y;
//            //更新位置
//            targetView.center = center;
//        }
    }

    if (canMove) {
        //移动之后，中心点（未移动点+本次触摸点-上次触摸点）
        CGFloat new_x = center.x + currentPoint.x-prePoint.x;
        CGFloat new_y = center.y + currentPoint.y-prePoint.y;
        if (new_x > superView.width-targetView.width*0.5) {
            NSLog(@"右边 超出范围");
        }
        else if (new_x<0.5*targetView.width) {
            NSLog(@"左边 超出范围");
        }
        else if (new_y > superView.height-targetView.height*0.5 ){
            NSLog(@"下边 超出范围");
        }
        else  if(new_y<0.5*targetView.height) {
            NSLog(@"上边 超出范围");
        }
        else{
            //更新位置
            NSLog(@"更新位置");
            targetView.center = CGPointMake(new_x, new_y);
        }
    }

}

@end

@implementation MoveItemView



@end

@implementation CanMoveScrollView


@end
