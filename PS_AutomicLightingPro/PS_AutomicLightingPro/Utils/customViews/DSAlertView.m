//
//  DSAlertView.m
//  DrivingSchool
//
//  Created by Jerry on 14/12/25.
//  Copyright (c) 2014年 dlt. All rights reserved.
//

#import "DSAlertView.h"
#import "AdditionHeader.h"
#import "UtilityMacro.h"
#import "FontAndColorMacroHeader.h"
#import "GlobalDef.h"

@implementation DSAlertView
@synthesize _container;
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = KClearColor;
        _bg = [[UIView alloc] initWithFrame:self.bounds];
        _bg.backgroundColor = ColorWithHexRGBA(0x000000, 0.6);
        [self addSubview:_bg];
        
        _container = [[UIView alloc] initWithFrame:CGRectMake(48, (self.height-110)/2, Screen_width-48*2, 110)];
        _container.backgroundColor = ColorWithRGB(255, 255, 255);
        _container.clipsToBounds = YES;
        _container.layer.cornerRadius = 2.f;
        [self addSubview:_container];
        
        self.titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLbl.backgroundColor = KClearColor;
        self.titleLbl.textAlignment = NSTextAlignmentCenter;
        self.titleLbl.font = FFont14;
        [self.titleLbl setTintColor:ColorWithRGBA(62, 62, 62, 1)];
        [_container addSubview:self.titleLbl];
        
        self.msgLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLbl.bottom + 5, _container.width-20, 55)];
        self.msgLbl.numberOfLines = 0;
        self.msgLbl.backgroundColor = KClearColor;
        self.msgLbl.textAlignment = NSTextAlignmentCenter;
        self.msgLbl.font = FFont12;
        [self.msgLbl setTintColor:ColorWithRGBA(117, 117, 117, 1)];
        [_container addSubview:self.msgLbl];
    }
    return self;
}
-(void)configSelfWithTitle:(NSString*)title WithMessage:(NSString*)message buttons:(NSArray*)buttons
{
    self.titleLbl.text = NoNullString(title);
    if(NoNullString(title).length > 0){
        self.titleLbl.frame = CGRectMake(10, 20, _container.width-20, 20);
    }
    [self configSelfWithMessage:message buttons:buttons];
}

-(void)configSelfWithMessage:(NSString*)message buttons:(NSArray*)buttons
{
    _msgLbl.text = message;
    
    CGRect rect = [message boundingRectWithSize:CGSizeMake(_container.width-20, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_msgLbl.font} context:nil];
    _msgLbl.top = self.titleLbl.bottom == 0 ? 20 : self.titleLbl.bottom + 10;
    _msgLbl.height = rect.size.height;
    
    float height = _msgLbl.bottom + 20;
    
    //横线
    UIView *V_lineView = [[UIView alloc] initWithFrame:CGRectMake(0, height, _container.size.width, 1)];
    [V_lineView setBackgroundColor:ColorWithRGBA(226, 226, 226, 1)];
    [_container addSubview: V_lineView];
    
    CGFloat width = _container.width/[buttons count];
    for (int i=0; i<[buttons count]; i++)
    {
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(width*i, V_lineView.bottom, width, 48)];
        btn.titleLabel.font = UIFontSystem(14);
        [btn setTitle:buttons[i] forState:UIControlStateNormal];
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 2;
        btn.tag = i;
        [btn addTarget:self action:@selector(actionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            
            [btn setTitleColor:CMainFontColor forState:UIControlStateNormal];
            if (buttons.count ==1) {
                [btn setTitleColor:CMainFontColor forState:UIControlStateNormal];
            }
        }
        else
        {
            [btn setTitleColor:MainBlueColor forState:UIControlStateNormal];
        }
        [_container addSubview:btn];
        _container.height = btn.bottom;
        
        //加入分割线
        if (i>0) {
            //竖线
            UIView *H_lineView = [[UIView alloc] initWithFrame:CGRectMake(btn.origin.x, V_lineView.origin.y,1, _container.size.height-V_lineView.origin.y)];
            [H_lineView setBackgroundColor:ColorWithRGBA(235, 235 , 235, 1)];
            [_container addSubview: H_lineView];
        }
        
        _container.top = (Screen_height - _container.height) * 0.5f;
    }
}

-(void)actionBtnTap:(UIButton*)btn;
{
    if (_actionBlock)
        _actionBlock(btn.tag);
    if (!self.isForeUpdate) {
        [self hide];
    }

}

-(void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+(instancetype)showWithMessage:(NSString*)message actionButtons:(NSArray*)actionButtons actionBlock:(void(^)(NSInteger))actionBlock
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
//       UIWindow* window =[AppDelegate sharedAppDelegate].window;
    DSAlertView* dsAlertView = [[DSAlertView alloc] initWithFrame:window.bounds];
   
    [dsAlertView configSelfWithMessage:message buttons:actionButtons];
    [dsAlertView setActionBlock:actionBlock];
    dsAlertView.isForeUpdate = NO;
    dsAlertView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        dsAlertView.alpha = 1;
    }];
    
//    if ([window.rootViewController.presentedViewController isKindOfClass:[CYTouchViewController class]]||( [window.rootViewController.presentedViewController isKindOfClass:[WQNavigationController class]] &&
//                                                                                                          [((WQNavigationController*)window.rootViewController.presentedViewController).topViewController isKindOfClass:[GestureViewController class]]                                                                                     )) {
//        [window.rootViewController.view addSubview:dsAlertView];
//    }
//    else
//    {
        [window addSubview:dsAlertView];
//    }
    return dsAlertView;
}
+(instancetype)showWithTitle:(NSString*)title withMessage:(NSString*)message andTag:(NSInteger)tag actionButtons:(NSArray*)actionButtons actionBlock:(void(^)(NSInteger))actionBlock
{

    UIWindow* window =[UIApplication sharedApplication].keyWindow;//[AppDelegate sharedAppDelegate].window ;//
    DSAlertView* dsAlertView = [[DSAlertView alloc] initWithFrame:window.bounds];
    dsAlertView.tag = tag;
       [dsAlertView configSelfWithTitle:title WithMessage:message buttons:actionButtons];
    [dsAlertView setActionBlock:actionBlock];
    dsAlertView.isForeUpdate = NO;
    dsAlertView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        dsAlertView.alpha = 1;
    }];
 
    [window addSubview:dsAlertView];
    return dsAlertView;

}
+(instancetype)showWithTitle:(NSString*)title withMessage:(NSString*)message actionButtons:(NSArray*)actionButtons actionBlock:(void(^)(NSInteger))actionBlock{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
//       UIWindow* window =[AppDelegate sharedAppDelegate].window;
    DSAlertView* dsAlertView = [[DSAlertView alloc] initWithFrame:window.bounds];
    [dsAlertView configSelfWithTitle:title WithMessage:message buttons:actionButtons];
 
    [dsAlertView setActionBlock:actionBlock];
    dsAlertView.isForeUpdate = NO;
    dsAlertView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        dsAlertView.alpha = 1;
    }];

        [window addSubview:dsAlertView];
    return dsAlertView;
}

+(instancetype)showWithTitle:(NSString*)title withMessage:(NSString*)message actionButtons:(NSArray*)actionButtons actionBlock:(void(^)(NSInteger))actionBlock isForceUpdate:(BOOL)isForce
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
     //  UIWindow* window =[AppDelegate sharedAppDelegate].window;
    DSAlertView* dsAlertView = [[DSAlertView alloc] initWithFrame:window.bounds];
   [dsAlertView configSelfWithTitle:title WithMessage:message buttons:actionButtons];
    [dsAlertView setActionBlock:actionBlock];
    dsAlertView.isForeUpdate = isForce;
    dsAlertView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        dsAlertView.alpha = 1;
    }];
 

        [window addSubview:dsAlertView];

    return dsAlertView;
}



#pragma mark --显示富文本
+(instancetype)showWithTitle:(NSString*)title withHtmlMessage:(NSString*)htmlMessage actionButtons:(NSArray*)actionButtons actionBlock:(void(^)(NSInteger))actionBlock{

    UIWindow* window =[UIApplication sharedApplication].keyWindow;
    DSAlertView* dsAlertView = [[DSAlertView alloc] initWithFrame:window.bounds];
    [dsAlertView configSelfWithTitle:title withHtmlMessage:htmlMessage buttons:actionButtons];
    
    [dsAlertView setActionBlock:actionBlock];
    dsAlertView.isForeUpdate = NO;
    dsAlertView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        dsAlertView.alpha = 1;
    }];
   
    [window addSubview:dsAlertView];
  
    return dsAlertView;
}
-(void)configSelfWithTitle:(NSString*)title withHtmlMessage:(NSString*)htmlMessage buttons:(NSArray*)buttons
{
    self.titleLbl.text = NoNullString(title);
    if(NoNullString(title).length > 0){
        self.titleLbl.frame = CGRectMake(10, 20, _container.width-20, 20);
    }
    [self configSelfwithHtmlMessage:htmlMessage buttons:buttons];
}

-(void)configSelfwithHtmlMessage:(NSString*)htmlMessage buttons:(NSArray*)buttons
{
  
//    2.富文本label的高度自适应
    NSMutableAttributedString *str=  [[NSMutableAttributedString alloc] initWithData:[htmlMessage dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [str addAttribute:NSFontAttributeName value:_msgLbl.font range:NSMakeRange(0, str.length)];//(字体font是自定义的 要求和要显示的label设置的font一定要相同)
    
    _msgLbl.attributedText = str;
    
    CGRect rect = [self.msgLbl.attributedText boundingRectWithSize:CGSizeMake(_container.width-20, 2000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
   
    _msgLbl.attributedText = str;

    _msgLbl.top = self.titleLbl.bottom == 0 ? 20 : self.titleLbl.bottom + 10;
    _msgLbl.height = rect.size.height;
    
    float height = _msgLbl.bottom + 20;
    
    //横线
    UIView *V_lineView = [[UIView alloc] initWithFrame:CGRectMake(0, height, _container.size.width, 1)];
    [V_lineView setBackgroundColor:ColorWithRGBA(226, 226, 226, 1)];
    [_container addSubview: V_lineView];
    
    CGFloat width = _container.width/[buttons count];
    for (int i=0; i<[buttons count]; i++)
    {
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(width*i, V_lineView.bottom, width, 48)];
        btn.titleLabel.font = UIFontSystem(14);
        [btn setTitle:buttons[i] forState:UIControlStateNormal];
        [btn setClipsToBounds:YES];
        [btn.layer setCornerRadius:2];
        btn.tag = i;
        [btn addTarget:self action:@selector(actionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            
            [btn setTitleColor:CMainFontColor forState:UIControlStateNormal];
            if (buttons.count ==1) {
                [btn setTitleColor:CMainFontColor forState:UIControlStateNormal];
            }
        }
        else
        {
            [btn setTitleColor:MainBlueColor forState:UIControlStateNormal];
        }
        [_container addSubview:btn];
        _container.height = btn.bottom;
        
        //加入分割线
        if (i>0) {
            //竖线
            UIView *H_lineView = [[UIView alloc] initWithFrame:CGRectMake(btn.origin.x, V_lineView.origin.y,1, _container.size.height-V_lineView.origin.y)];
            [H_lineView setBackgroundColor:ColorWithRGBA(235, 235 , 235, 1)];
            [_container addSubview: H_lineView];
        }
        
        _container.top = (Screen_height - _container.height) * 0.5f;
    }
}
@end
