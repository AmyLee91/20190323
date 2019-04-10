//
//  PSFlatButton.m
//  PS_WisdomWork
//
//  Created by 李明明 on 2018/7/20.
//  Copyright © 2018年 www.psiot.com.cn. All rights reserved.
//

#import "PSFlatButton.h"
#import "Global_Header.h"

@implementation PSFlatButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    self =  [super initWithFrame:frame];
    if (self) {
       
        self.iconImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.titleLbl = [[UILabel alloc]initWithFrame:CGRectZero];
        
        [self addSubview:self.iconImg];
        [self addSubview:self.titleLbl];
        
    }
    return self;
}
-(void)setCurrLoc:(EIconLocation)currLoc{
    
    _currLoc = currLoc;
    [self loadSubviewsWith];
}
-(void)loadSubviewsWith{
    switch (self.currLoc) {
        case IconTop:
           [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
               make.height.width.mas_equalTo(icon_h);
               make.top.mas_equalTo(6);
               make.centerX.mas_equalTo(0);
            }];
            [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.height.mas_equalTo(label_h);
            }];
          
            break;
        case IconLeft:
            [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.width.mas_equalTo(icon_h);
                make.left.mas_equalTo(16);
                make.centerY.mas_equalTo(0);
            }];
            [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.left.mas_equalTo(icon_h+16);
            }];
            
            break;
        case IconRight:
            [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.width.mas_equalTo(icon_h);
                make.right.mas_equalTo(-16);
                make.centerY.mas_equalTo(0);
            }];
            [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.top.mas_equalTo(0);
                make.right.mas_equalTo(icon_h+16);
                make.left.mas_equalTo(16);
            }];
            break;
        case IconBottpm:
            [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.width.mas_equalTo(icon_h);
                make.bottom.mas_equalTo(0);
                make.centerX.mas_equalTo(0);
            }];
            [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.mas_equalTo(0);
                make.top.mas_equalTo(6);
                make.height.mas_equalTo(label_h);
            }];
            break;
        default:
            break;
    }
}
@end
