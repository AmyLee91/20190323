//
//  PSFlatButton.h
//  PS_WisdomWork
//
//  Created by 李明明 on 2018/7/20.
//  Copyright © 2018年 www.psiot.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#define icon_h  22
#define label_h 22
/*******
 
 小 图文 按钮--图标
 
 
 *********/


typedef enum{
    IconLeft = 0,//图片居左，文本居右
    IconTop ,
    IconRight,
    IconBottpm,
    
}EIconLocation;

@interface PSFlatButton : UIButton

@property(nonatomic,strong)UIImageView *iconImg;
@property(nonatomic,strong)UILabel *titleLbl;

@property(nonatomic,strong)NSString *typeStr;
@property(nonatomic,assign)EIconLocation currLoc;
@end
