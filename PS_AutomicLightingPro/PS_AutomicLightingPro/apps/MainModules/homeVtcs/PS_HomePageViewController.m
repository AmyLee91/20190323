//
//  PS_HomePageViewController.m
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/3.
//  Copyright © 2019 psiot. All rights reserved.
//

#import "PS_HomePageViewController.h"

@interface PS_HomePageViewController (){
    
    UIImageView *img ;
    UIButton *btn;
    UIImageView *icon ;
    
}

@end

@implementation PS_HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    img = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_width*0.1, 200, Screen_width*0.8, 700)];
    [img setImage:UIImageNamed(@"3.jpg")];
    img.userInteractionEnabled = YES;
    [self.view addSubview:img];
    
    
    
    {
        icon = [[UIImageView alloc]initWithFrame:CGRectMake(50,50 , 50, 50)];
        [img addSubview:icon];
        icon.userInteractionEnabled = YES;
        icon.backgroundColor = [UIColor redColor];
      

    }
    
}
-(void)test{
////    测试
//    NSArray *arr = @[@1,@2,@3];
//    NSMutableArray *arr2 = [[NSMutableArray alloc]initWithArray:arr];
//    id obj = [arr2 objectAtIndex:3];//arr2[4];
//    
//    NSLog(@"%@",obj);
    
//    BaseViewController *vc = [[BaseViewController alloc]init];
//    vc.view.backgroundColor = CRandomColor;
//    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
  UITouch *touch = [touches anyObject];
    
//    if (![touch.view isKindOfClass:[UIButton class]]) {
//        return;
//    }
    
    UIView *targetView = touch.view;
    //本次触点
    CGPoint currentPoint = [touch locationInView:targetView.superview];
    //上次触点
    CGPoint prePoint = [touch previousLocationInView:targetView.superview];
    //未移动的中心点
    CGPoint center = targetView.center;
    
    //移动之后，中心点（未移动点+本次触摸点-上次触摸点）
    center.x += currentPoint.x-prePoint.x;
    center.y += currentPoint.y-prePoint.y;
    //更新位置
    
    targetView.center = center;
     NSLog(@"touches Move");
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     NSLog(@"touches Begin");
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"touches END");
}


@end
