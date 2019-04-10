//
//  DSAlertView.h
//  DrivingSchool
//
//  Created by Jerry on 14/12/25.
//  Copyright (c) 2014年 dlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSAlertView : UIView
{
    UIView* _bg;
    UIView* _container;
    NSMutableArray* _actionBtnArr;

}
@property(nonatomic,strong)    UIView* _container;
@property(nonatomic,strong) UILabel* msgLbl;
@property(nonatomic,strong) UILabel* titleLbl;

@property(nonatomic,assign) BOOL isForeUpdate;
@property(nonatomic,strong) NSString* message;
@property(nonatomic,strong) void(^actionBlock)(NSInteger index);

+(instancetype)showWithMessage:(NSString*)message actionButtons:(NSArray*)actionButtons actionBlock:(void(^)(NSInteger))actionBlock;

+(instancetype)showWithTitle:(NSString*)title withMessage:(NSString*)message andTag:(NSInteger)tag actionButtons:(NSArray*)actionButtons actionBlock:(void(^)(NSInteger))actionBlock;



+(instancetype)showWithTitle:(NSString*)title withMessage:(NSString*)message actionButtons:(NSArray*)actionButtons actionBlock:(void(^)(NSInteger))actionBlock;

//点击后 弹框不消失
+(instancetype)showWithTitle:(NSString*)title withMessage:(NSString*)message actionButtons:(NSArray*)actionButtons actionBlock:(void(^)(NSInteger))actionBlock isForceUpdate:(BOOL)isForce;


//显示富文本
+(instancetype)showWithTitle:(NSString*)title withHtmlMessage:(NSString*)htmlMessage actionButtons:(NSArray*)actionButtons actionBlock:(void(^)(NSInteger))actionBlock;
@end
