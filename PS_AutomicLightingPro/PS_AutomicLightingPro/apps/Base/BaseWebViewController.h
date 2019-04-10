//
//  BaseWebViewController.h
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/3.
//  Copyright © 2019 psiot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseWebViewController : BaseViewController
@property(nonatomic,strong)NSString *baseUrl;//不拼接 token的url
@property(nonatomic,strong)NSString *m_url;

@property(nonatomic,strong)WKWebView *k_webView;
@property(nonatomic,strong)UIProgressView *progressView;//进度条

@property(nonatomic,assign) NSInteger currPage;//
@property(nonatomic,strong)NSURL *lastURl;//上一次URL

@property(nonatomic,assign)BOOL directReturn;//直接返回
@end

NS_ASSUME_NONNULL_END
