//
//  PS_EditAreaVc.m
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/22.
//  Copyright © 2019 psiot. All rights reserved.
//

#import "PS_EditAreaVc.h"

@interface PS_EditAreaVc ()

@property(nonatomic,strong)UIButton *itemBtn;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UIScrollView *imgScrollview;
@property(nonatomic,strong)UIScrollView *m_scrollview;
@end

@implementation PS_EditAreaVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch begin");
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch moved");
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch end");
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch cancelled");
}

@end
