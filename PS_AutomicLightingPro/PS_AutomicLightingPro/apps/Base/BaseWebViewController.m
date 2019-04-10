//
//  BaseWebViewController.m
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/3.
//  Copyright © 2019 psiot. All rights reserved.
//

#import "BaseWebViewController.h"
//#import "PS_ApiHeaderInfo.h"
@interface BaseWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic,assign) double lastProgress;//上次进度条位置
@end

@implementation BaseWebViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeNone;//适用iOS10.x以及以下
    self.automaticallyAdjustsScrollViewInsets = NO;//顶部空白条去除
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.currPage = 0;
    [self addNavigationItemWithImageNames:@[@"icon_back_nav"] isLeft:YES target:self action:@selector(backBtnClicked) tags:@[@111]];
}
//所有待办的URL监听下，如果URL中包含“preview=1”，就返回上一页，否则返回首页
- (void)backBtnClicked{
    BOOL hasPreview =[self.k_webView.URL.absoluteString containsString:@"preview=1"];
    if (self.directReturn && !hasPreview) {
        [super backBtnClicked];
    }else{
        if ([self.k_webView.URL.absoluteString isEqualToString:[self.m_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] || self.currPage<=0) {
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else{
            self.currPage --;
            [self.k_webView goBack];
        }
    }
}
-(void)setM_url:(NSString *)m_url{
    if (_m_url != m_url) {
        _m_url = m_url;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[self.m_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];//url特殊字符串需要转译一下
        
        [self loadWebview:self.k_webView With:request];
        
        
    }
}

//-(void)CheckTheURLResponseCode{
//    NSLog(@"检测----@@@@");
//
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:NoNullString(self.m_url)]];
//
//    NSMutableSet *set = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
//    [set addObject:@"text/html"];//设置无效， AFHTTPSessionManager方法初始化重新设置了
//    manager.responseSerializer.acceptableContentTypes = set;
//
//    AFHTTPRequestSerializer *requestSerializer = manager.requestSerializer;
//
//    PS_ApiHeaderInfo *headerInfo = [PS_ApiHeaderInfo new];
//    NSInteger time = [[NSDate new]timeIntervalSince1970];
//    NSString *timeStr = [NSString stringWithFormat:@"%li",time];
//    headerInfo.apiTime = timeStr;
//    NSLog(@"当前时间戳-%@",timeStr);
//
//    [requestSerializer setValue:headerInfo.apiVersion forHTTPHeaderField:@"M-API-VERSION"];
//    [requestSerializer setValue:headerInfo.apiCompanyCode forHTTPHeaderField:@"M-API-COMPANYCODE"];
//    [requestSerializer setValue:headerInfo.token forHTTPHeaderField:@"M-API-TOKEN"];  // q校验接口有效性
//    [requestSerializer setValue:headerInfo.webLogid forHTTPHeaderField:@"M-API-WEBLOGID"];//登录验证
//
//    [requestSerializer setValue:headerInfo.appType forHTTPHeaderField:@"M-API-APPTYPE"];
//    [requestSerializer setValue:headerInfo.osVersion forHTTPHeaderField:@"M-API-OSVERSION"];
//    [requestSerializer setValue:headerInfo.appVersion forHTTPHeaderField:@"M-API-APPVERSION"];
//    [requestSerializer setValue:headerInfo.userSign  forHTTPHeaderField:@"M-API-USERSIGN"];
//
//    [requestSerializer setValue:headerInfo.userSign forHTTPHeaderField:@"M-API-USERSIGN"];
//    [requestSerializer setValue:headerInfo.mac forHTTPHeaderField:@"M-API-MAC"];
//    [requestSerializer setValue:headerInfo.screenSize forHTTPHeaderField:@"M-API-SCREENSIZE"];
//    [requestSerializer setValue:headerInfo.sourceCode forHTTPHeaderField:@"M-API-SOURCECODE"];
//
//    [requestSerializer setValue:headerInfo.apiTime forHTTPHeaderField:@"M-API-TIME"];
//    [requestSerializer setValue:headerInfo.parkId forHTTPHeaderField:@"M-API-PARKID"];//园区id
//    //    NSLog(@"header中当前园区：%@",headerInfo.parkId);
//
//    [requestSerializer setValue:headerInfo.projectId forHTTPHeaderField:@"M-API-PROJECTID"];
//    //    NSLog(@"header中当项目Id：%@",headerInfo.projectId);
//
//
//
//    [manager GET:@"" parameters:nil progress:nil
//         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//             NSLog(@"web返回值-%@",responseObject);
//
//             NSLog(@"返回的是json格式数据，不是html 页面-加载不成功");
//             NSInteger code = [[NoNullDict(responseObject) objectForKey:@"result"] integerValue];
//             if (code == 7777 ) {
//                 NSLog(@"异地登出");
//                 [DSAlertView showWithMessage:@"您的账号在其他设备上登录，您已强制下线，请确认账号安全！" actionButtons:@[@"知道了"] actionBlock:^(NSInteger index) {
//                     [[AppDelegate sharedAppDelegate] toLogOut];
//                 }];
//             }else if (code == 7776){
//                 //园区ID为空，请选择园区ID！
//                 NSLog(@"园区ID为空，请选择园区ID！");
//                 [[M_GlobalTools ShareInstance]toSelectParkVc];
//                 [self.k_webView reload];
//             }else if (code == 7775){
//                 //                 项目ID为空，请选择项目ID！
//                 NSLog(@"项目ID为空，请选择项目ID！");
//                 [[M_GlobalTools ShareInstance]toSelectProjectVc];
//                 [self.k_webView reload];
//             }
//             NSLog(@"%@" ,responseObject);
//         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//             NSLog(@"返回的不是json格式数据，是html 页面-加载成功");
//
//         }];
//
//}
//加载页面
-(void)loadWebview:(WKWebView *)webview With:(NSMutableURLRequest *)request {
    
    [webview loadRequest:[self AddHttpUrlHeader:request]];
    self.lastURl = request.URL;
    //    self.currPage ++;
   // [self CheckTheURLResponseCode];//检测URL有效性-是否登录状态
    NSLog(@"loadxxx");
}
-(NSMutableURLRequest *)AddHttpUrlHeader:(NSMutableURLRequest*)request
{
//    NSLog(@"添加请求头");
//    PS_ApiHeaderInfo *headerInfo = [PS_ApiHeaderInfo new];
//    NSInteger time = [[NSDate new]timeIntervalSince1970];
//    NSString *timeStr = [NSString stringWithFormat:@"%li",time];
//    headerInfo.apiTime = timeStr;
//    NSLog(@"当前时间戳-%@",timeStr);
//
//    [request setValue:headerInfo.apiVersion forHTTPHeaderField:@"M-API-VERSION"];
//    [request setValue:headerInfo.apiCompanyCode forHTTPHeaderField:@"M-API-COMPANYCODE"];
//    [request setValue:headerInfo.token forHTTPHeaderField:@"M-API-TOKEN"];  // q校验接口有效性
//    [request setValue:headerInfo.webLogid forHTTPHeaderField:@"M-API-WEBLOGID"];//登录验证
  return request;
}
-(WKWebView *)k_webView{
    if (!_k_webView) {
        _k_webView =[[WKWebView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height-Nav_height)];
        _k_webView.navigationDelegate = self;
        _k_webView.UIDelegate = self;
        _k_webView.scrollView.scrollEnabled = YES;//
        _k_webView.allowsBackForwardNavigationGestures =YES;//打开网页间的 滑动返回
        _k_webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        [_k_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_k_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        
        //设置js 交互协议配置
        
        //设置addScriptMessageHandler与name.并且设置<WKScriptMessageHandler>协议与协议方法
        //[[_k_webView configuration].userContentController addScriptMessageHandler:self name:@"To_RefreshDeviceStatus"];
        [[_k_webView configuration].userContentController addScriptMessageHandler:self name:@"connectWebViewJavascriptBridge"];
        [self.view addSubview:_k_webView];
        
    }
    return _k_webView;
}
-(UIProgressView *)progressView{
    if (!_progressView) {
        
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0,Screen_width , 2)];
        _progressView.tintColor = MainBlueColor;
        _progressView.trackTintColor = [UIColor clearColor];
        if (self.isHidenNaviBar) {
            [_progressView setFrame:CGRectMake(0, Nav_height, Screen_width, 2)];
        }
        [self.view addSubview:_progressView];
    }
    return _progressView;
}
#pragma mark --进度条
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [self updateProgress:self.k_webView.estimatedProgress];
    }else if ([keyPath isEqualToString:@"title"]){
        if (object == _k_webView) {
            self.title = _k_webView.title;
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}

#pragma mark -  更新进度条
-(void)updateProgress:(double)progress{
    self.progressView.alpha = 1;
    if(progress > _lastProgress){
        [self.progressView setProgress:self.k_webView.estimatedProgress animated:YES];
    }else{
        [self.progressView setProgress:self.k_webView.estimatedProgress];
    }
    _lastProgress = progress;
    
    if (progress >= 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressView.alpha = 0;
            [self.progressView setProgress:0];
            self->_lastProgress = 0;
        });
    }
}

#pragma mark --navigation delegate

//11. 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSURLRequest *request = navigationAction.request;
    if ([request.URL.scheme isEqualToString:@"tel"]) {
        //打电话
        NSString *callPhone = request.URL.absoluteString;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        
    }
    
    
    
    NSLog(@"11111--在发送请求之前，决定是否跳转");
    //给跳转请求加请求头--
    //     NSMutableURLRequest *mutableReq = [navigationAction.request mutableCopy];
    //     NSDictionary *reqHeader = navigationAction.request.allHTTPHeaderFields;
    //     PS_ApiHeaderInfo *headerInfo = [PS_ApiHeaderInfo new];
    //     NSLog(@"嘻嘻嘻嘻嘻%@",reqHeader);
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
   
}
//22 页面开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"222222: 页面开始加载");
}

//33. 在收到服务器的响应头后，根据response信息，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"3333:收到服务器的响应头后,决定是否跳转");
    //    NSLog(@"响应：%@",navigationResponse);
    decisionHandler(WKNavigationResponsePolicyAllow);
}
//44.开始获取到网页内容时返回，需要注入JS，在这里添加 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"4444:开始获取到网页内容时返回");
    self.currPage++;
}
// 55.页面加载完成之后调用 */
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"5555：页面加载完成之后调用");
    [self updateProgress:webView.estimatedProgress];
}

//  其他 - 处理服务器重定向Redirect */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"xxxxx");
}
//WKScriptMessageHandler协议方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"xxxx-%@",message);
    NSLog(@"接收内容-%@",message.body);
    NSDictionary *dit = (NSDictionary *)message.body;
    if ([message.name isEqualToString:@"connectWebViewJavascriptBridge"]) {
        //js 事件
        if ([[dit objectForKey:@"type"] isEqualToString:@"flush"] && [[dit objectForKey:@"code"] isEqualToString:@"workflow"]) {
            //
            NSLog(@"待办箱列表刷新");
            
           // [[NSNotificationCenter defaultCenter]postNotificationName:@"ToRefresh_workFlowListData" object:nil];
        }
    }
    NSLog(@"666");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc {
    
     self.k_webView.navigationDelegate = nil;
    [self.k_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.k_webView removeObserver:self forKeyPath:@"title"];
}


@end
