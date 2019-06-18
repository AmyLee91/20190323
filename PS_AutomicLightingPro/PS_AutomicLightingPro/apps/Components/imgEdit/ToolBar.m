//
//  ToolBar.m
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/9.
//  Copyright © 2019 psiot. All rights reserved.
//

#import "ToolBar.h"

@implementation ToolBar
-(void)setItems:(NSMutableArray *)items{
    _items = items;
    self.backgroundColor = KWhiteColor;
    if (self.subviews.count>0) {
        [self removeAllSubviews];
    }
    for (int i = 0; i<items.count; i++) {

        CGFloat x = i*(60+20)+20;
        CGFloat y = 10;
        CGRect itemFrame = CGRectMake(x,y, 60, 60);
        ToolItemBtn *btn = [[ToolItemBtn alloc]initWithFrame:itemFrame];
        btn.enabled = NO;
        btn.imgName = items[i];
        btn.multipleTouchEnabled = YES;
        [btn addTarget:self action:@selector(toAddNewOne:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:UIImageNamed(items[i]) forState:UIControlStateNormal];
        [self addSubview:btn];
        
        if (i == items.count-1) {
            self.contentSize = CGSizeMake(btn.right+20, self.height);
        }
    }
}
-(void)toAddNewOne:(id)sender{
    ToolItemBtn *btn = (ToolItemBtn *)sender;
    if (self.toAddNewItem) {
        self.toAddNewItem(btn.imgName);
    }
}

//-(UIScrollView *)scrollView{
//    if (!_scrollView) {
//
//        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.frame.origin.x,self.frame.origin.y ,Screen_width, MAX(self.height,80))];
//        _scrollView.backgroundColor = CMainRedColor;
//        _scrollView.scrollEnabled = YES;
//        _scrollView.multipleTouchEnabled = YES;
//        _scrollView.userInteractionEnabled = YES;
//        [self.superview addSubview:_scrollView];
//    }
//    return _scrollView;
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   // UITouch *touch = [touches anyObject];
    NSLog(@"开始");
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"结束");
    UITouch *touch = [touches anyObject];
    UIView *targetView = touch.view;
    UIView *superView = targetView.superview;
    
    //本次触点
    CGPoint currentPoint = [touch locationInView:targetView.superview];
    //上次触点
    CGPoint prePoint = [touch previousLocationInView:targetView.superview];
    //未移动的中心点
    CGPoint center = targetView.center;
    if ([targetView isKindOfClass:[ ToolItemBtn class]]) {
        
     //   ToolItemBtn* currView = (ToolItemBtn*) targetView;
//        canMove = currView.canMove;
        //        if (currView.canMove) {
        //            //移动之后，中心点（未移动点+本次触摸点-上次触摸点）
        //            center.x += currentPoint.x-prePoint.x;
        //            center.y += currentPoint.y-prePoint.y;
        //            //更新位置
        //            targetView.center = center;
        //        }
    }
    
//    if (canMove) {
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
//    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"移动");
    UITouch *touch = [touches anyObject];
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"取消");
    UITouch *touch = [touches anyObject];
}
@end


@implementation ToolItemBtn

@end
