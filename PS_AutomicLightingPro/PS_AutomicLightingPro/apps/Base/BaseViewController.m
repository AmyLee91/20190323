//
//  BaseViewController.m
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/3.
//  Copyright © 2019 psiot. All rights reserved.
//

#import "BaseViewController.h"

#import "ViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController
- (UIStatusBarStyle)preferredStatusBarStyle{
    return _StatusBarStyle;
}
//动态更新状态栏颜色
-(void)setStatusBarStyle:(UIStatusBarStyle)StatusBarStyle{
    _StatusBarStyle=StatusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KWhiteColor;
   
    //是否显示返回按钮
    self.isShowLiftBack = NO;
    //是否显示导航栏
    self.isHidenNaviBar = NO;
    //默认导航栏样式：黑字
    self.StatusBarStyle = UIStatusBarStyleDefault;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
        [self.view addSubview:btn];
        btn.backgroundColor = [UIColor orangeColor];
        [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}
-(void)test{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = CRandomColor;
    [self.navigationController pushViewController:vc animated:YES];
    
}
/**
 *  是否显示返回按钮
 */
- (void) setIsShowLiftBack:(BOOL)isShowLiftBack
{
    _isShowLiftBack = isShowLiftBack;

    if (isShowLiftBack ) {
        [self addNavigationItemWithImageNames:@[@"icon_back_nav"] isLeft:YES target:self action:@selector(backBtnClicked) tags:@[@(112233)]];
    } else {
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem * NULLBar=[[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = NULLBar;
    }
}
- (void)backBtnClicked
{
    
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark ————— 导航栏 添加图片按钮 —————
/**
 导航栏添加图标按钮
 
 @param imageNames 图标数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags
{
    NSMutableArray * items = [[NSMutableArray alloc] init];
    NSInteger i = 0;
    for (NSString * imageName in imageNames) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 40, 30);
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        if (isLeft) {
            //{top, left, bottom, right}
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        }else{
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        }
        
        btn.tag = [tags[i++] integerValue];
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
        
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

#pragma mark ————— 导航栏 添加文字按钮 —————
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags
{
    
    NSMutableArray * items = [[NSMutableArray alloc] init];
    
    //调整按钮位置
    //    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    //将宽度设为负值
    //    spaceItem.width= -5;
    //    [items addObject:spaceItem];
    
    NSMutableArray * buttonArray = [NSMutableArray array];
    NSInteger i = 0;
    for (NSString * title in titles) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 40, 30);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = UIFontSystem(14);
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:MainBlueColor forState:UIControlStateNormal];
        btn.tag = [tags[i++] integerValue];
        [btn sizeToFit];
        
        //        //设置偏移
        //        if (isLeft) {
        //            //{top, left, bottom, right}
        //            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, -10)];
        //        }else{
        //            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        //        }
        
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
        [buttonArray addObject:btn];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}
#pragma mark -  屏幕旋转
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //当前支持的旋转类型
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    // 是否支持旋转
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    // 默认进去类型
    return   UIInterfaceOrientationPortrait;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //    NSLog(@"click view");
}
/**
 *  懒加载UITableView
 *
 *  @return UITableView
 */
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width , UIScreen.mainScreen.bounds.size.height) style:UITableViewStyleGrouped];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        
        //头部刷新
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
        
        //底部刷新
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        _tableView.backgroundColor=[UIColor whiteColor];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark -- 无数据
-(void)ShowEmptyViewWith:(UIView *)obj{
    if ([obj viewWithTag:101010]) {
        UIView *subview = [obj viewWithTag:101010];
        [subview removeAllSubviews];
        [subview removeFromSuperview];
    }
    _emptyView = [[UIView alloc]init];
    UIImageView *img = [[UIImageView alloc]initWithImage:UIImageNamed(@"nothing")];
    UILabel *label = [[UILabel alloc]init];
    label.font = UIFontSystem(14);
    label.textColor = CFontColor1;
    label.textAlignment =NSTextAlignmentCenter;
    label.text = LOCALIZATION(@"暂时没有内容哦");///@"暂时没有内容哦" ;
    _emptyView.tag = 101010;
    [_emptyView addSubview:img];
    [_emptyView addSubview:label];
    
    [_emptyView setFrame:CGRectMake(0, 0,obj.frame.size.width, obj.frame.size.height)];
    [obj addSubview:_emptyView];
    
    
    [img setFrame:CGRectMake((Screen_width-179)/2, (_emptyView.height-110)/2-Nav_height-24-16, 179, 110)];
    [label setFrame:CGRectMake(KNormalSpace,img.bottom+16, Screen_width-KNormalSpace*2, 24)];
    
    
    
    _emptyView.userInteractionEnabled = NO;
    img.userInteractionEnabled = NO;
    
    
}
-(void)removeEmptyView{
    if (_emptyView) {
        [_emptyView removeAllSubviews];
        [_emptyView removeFromSuperview];
        _emptyView = nil;
    }
}

-(void)dealloc{
    
    //移除 通知观察者
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
