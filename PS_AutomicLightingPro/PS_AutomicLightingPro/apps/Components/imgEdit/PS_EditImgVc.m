//
//  PS_EditImgVc.m
//  PS_AutomicLightingPro
//
//  Created by Amy Lee on 2019/4/11.
//  Copyright © 2019 psiot. All rights reserved.
//

#import "PS_EditImgVc.h"
#import "CanMoveImage.h"
#import "ToolBar.h"
#import "JJOptionView.h"
#import "CanMoveImage.h"
#import "MoveItemModel.h"
#import "M_NormalKits.h"

@interface PS_EditImgVc ()
@property(nonatomic,strong)JJOptionView *currView;
@property(nonatomic,strong)UIButton *lockBtn;
@property(nonatomic,strong)UIButton *editBtn;
@property(nonatomic,strong)UIButton *deleteBtn;

@property(nonatomic,assign)BOOL canEdit;


@property(nonatomic,strong)CanMoveScrollView *m_scrollview;
@property(nonatomic,strong)CanMoveBgImageView *currBgView;

@property(nonatomic,strong)ToolBar *bottomBar;
@property(nonatomic,strong)NSArray *bottomBarItemsArr;//初始化的图标

@property(nonatomic,strong)NSMutableSet *saveItemsArr;//保存新的图标


#define CURR_SAVE_Items @"CURR_SAVE_Items"
@end

@implementation PS_EditImgVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.canEdit = NO;
    self.saveItemsArr = [[NSMutableSet alloc]initWithCapacity:1];
    
    [self setUpMainUI];
  
    
}
-(void)setUpMainUI{
    //关闭手势返回
    self.view.userInteractionEnabled = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.isShowLiftBack = YES;
   
    [self loadTopView];
    [self.currBgView setImage:[UIImage resizedImage:UIImageNamed(@"3.jpg") maxSize:CGSizeMake(600, 600)]];
    self.currBgView.size = CGSizeMake(CGImageGetWidth(self.currBgView.image.CGImage), CGImageGetHeight(self.currBgView.image.CGImage));
    self.m_scrollview.contentSize = self.currBgView.size;
 
    self.bottomBarItemsArr =@[@"iconA.png",@"iconB.png",@"iconC.png",@"iconD.png",@"iconA.png",@"iconB.png",@"iconC.png",@"iconD.png"];
  
    
    
    [self loadAllItemsView];
    
}
//子视图--图标s
-(void)loadAllItemsView{
    NSArray *arr = [self getDataFromPlistFile];
    if (arr.count>0) {
        [self loadPreItemsViewWith:arr];
    }
}
//删除所有 保存设置
-(void)deleteAll{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:CURR_SAVE_Items];
    [self.saveItemsArr removeAllObjects];
    
    [self.currBgView removeAllSubviews];
    //重新加载
    [self loadAllItemsView];
}
#pragma mark -- 编辑状态变更
-(void)changeEditStatus{
     WeakSelf(bself);
    if (self.canEdit) {
        NSLog(@"点击保存");
        [self.currBgView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            MoveItemModel *itemModel = [MoveItemModel new];
           // itemModel.obj  = obj;
            ItemFrame *frameModel = [ItemFrame new];
            frameModel.x =(double) obj.frame.origin.x ;
            frameModel.y =(double) obj.frame.origin.y ;
            frameModel.w =(double) obj.frame.size.width ;
            frameModel.h =(double) obj.frame.size.height ;
            itemModel.frame = frameModel;
            
            itemModel.className = NSStringFromClass([obj class]);
            if ([obj isKindOfClass:[CanMoveImage class]]) {
                CanMoveImage *item =(CanMoveImage*)obj;
                itemModel.imgName =item.imgName;
            
            }else{
                 itemModel.imgName = @"";
            }
           
            [bself.saveItemsArr addObject:itemModel];//保存所有子视图
            
        }];
        //保存修改后的数据-存储起来
        [self saveToPlistFile];
        
    }else{
        NSLog(@"开始编辑");
    }
   
    self.editBtn.selected = !self.editBtn.selected;
    self.canEdit = self.editBtn.selected;
    
    [self.bottomBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ToolItemBtn *btn = (ToolItemBtn *)obj;
        btn.enabled = bself.canEdit;
    }];
}
// 存储
-(void)saveToPlistFile{
   
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:1];
    
    [self.saveItemsArr.allObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MoveItemModel *model = (MoveItemModel*)obj;
        NSMutableDictionary *dit = [model mj_keyValues];
        [arr addObject:dit];
    }];
    
    [[NSUserDefaults standardUserDefaults] mj_setCustomObject:arr forKey:CURR_SAVE_Items];
}
//获取
-(NSArray*)getDataFromPlistFile{
    NSArray *arr = [[NSUserDefaults standardUserDefaults]mj_customObjectForKey:CURR_SAVE_Items];
    
    arr = [MoveItemModel mj_objectArrayWithKeyValuesArray:arr];
    NSLog(@"获取arr:%@",arr);
    return arr;
//
}
// 状态变更
-(void)setCanEdit:(BOOL)canEdit{
    _canEdit = canEdit;
    self.m_scrollview.scrollEnabled = !_canEdit;
    [self.currBgView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CanMoveImage class]]) {
            CanMoveImage *img = (CanMoveImage *)obj;
            img.canMove = canEdit;
        }
        if ([obj isKindOfClass:[MoveItemView class]]) {
            MoveItemView *item = (MoveItemView *)obj;
            item.canMove = canEdit;
        }
    }];
}

//加载上次保存数据
-(void)loadPreItemsViewWith:(NSArray *)arr{
    [self.currBgView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CanMoveImage class]] || [obj isKindOfClass:[MoveItemView class]]) {
            [obj removeFromSuperview];
        }
    }];
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[MoveItemModel class]]) {
            MoveItemModel *model =(MoveItemModel *) obj;
            
            if ([model.className isEqualToString:@"CanMoveImage"]) {
                //图像
                CanMoveImage *imgView = [[CanMoveImage alloc]initWithFrame:CGRectMake(model.frame.x, model.frame.y, model.frame.w, model.frame.h)];//(CanMoveImage*)model.obj;
                imgView.imgName = model.imgName;
                [imgView setImage:[UIImageNamed(model.imgName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                imgView.userInteractionEnabled = YES;
                imgView.layer.borderColor = CMainRedColor.CGColor;
                imgView.layer.borderWidth = 1;
                [self.currBgView addSubview:imgView];
            }else{
                Class cls = NSClassFromString(model.className);
                
                UIView *subView = [[cls alloc]initWithFrame:CGRectMake(model.frame.x, model.frame.y, model.frame.w, model.frame.h)];
                subView.userInteractionEnabled = YES;
                subView.layer.borderColor = CMainRedColor.CGColor;
                subView.layer.borderWidth = 1;
                subView.backgroundColor = [UIColor yellowColor];//测试
                [self.currBgView addSubview:subView];
            }
            
        }
    }];

}
-(void)setBottomBarItemsArr:(NSArray *)bottomBarItemsArr{
    _bottomBarItemsArr = bottomBarItemsArr;
    [self.bottomBar setItems:[NSMutableArray arrayWithArray:_bottomBarItemsArr]];
    WeakSelf(bself);
    [self.bottomBar setToAddNewItem:^(NSString * _Nonnull imgName) {
        CGPoint imgCenter = bself.currBgView.center;
        CGPoint offset = bself.m_scrollview.contentOffset;
        CanMoveImage * img = [[CanMoveImage alloc]initWithFrame:CGRectMake(MIN(imgCenter.x, Screen_width*0.5)+offset.x, MIN(imgCenter.y, 300)+offset.y, 40, 40)];
            img.userInteractionEnabled = YES;
            img.imgName = imgName;
            img.image = UIImageNamed(imgName);
            img.layer.borderColor = CMainRedColor.CGColor;
            img.layer.borderWidth = 1;
            [bself.currBgView addSubview:img];
    }];
    
}
#pragma mark == touchs

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
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
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     NSLog(@"移动");
    UITouch *touch = [touches anyObject];
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     NSLog(@"取消");
    UITouch *touch = [touches anyObject];
}
#pragma mark -- 初始化视图
-(void)loadTopView{
    _editBtn = [[UIButton alloc]initWithFrame:CGRectMake(Screen_width-100, 0, 50, 40)];
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_editBtn setTitle:@"保存" forState:UIControlStateSelected];
    [_editBtn setBackgroundColor:MainBlueColor];
    [self.view addSubview:_editBtn];
    [_editBtn addTarget:self action:@selector(changeEditStatus) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * deletAllBtn = [[UIButton alloc]initWithFrame:CGRectMake(Screen_width-200, 0, 50, 40)];
    [deletAllBtn setTitle:@"清除" forState:UIControlStateNormal];
    [deletAllBtn setBackgroundColor:CMainRedColor];
    [self.view addSubview:deletAllBtn];
    [deletAllBtn addTarget:self action:@selector(deleteAll) forControlEvents:UIControlEventTouchUpInside];
    
}
-(CanMoveScrollView *)m_scrollview{
    if (!_m_scrollview) {
        _m_scrollview = [[CanMoveScrollView alloc]initWithFrame:CGRectMake(0,self.editBtn.bottom+20 ,Screen_width, TabView_height-150)];
        _m_scrollview.scrollEnabled = YES;
        _m_scrollview.backgroundColor = CViewBgColor;
        [self.view addSubview:_m_scrollview];
    }
    return _m_scrollview;
}
-(UIImageView *)currBgView{
    if (!_currBgView) {
        _currBgView = [[CanMoveBgImageView alloc]initWithFrame:CGRectMake(20, 20, Screen_width-40, Screen_width)];
        _currBgView.userInteractionEnabled = YES;
        [self.m_scrollview addSubview:_currBgView];
    }
    return _currBgView;
}

-(ToolBar*)bottomBar{
    if (!_bottomBar) {
        _bottomBar = [[ToolBar alloc]initWithFrame:CGRectMake(0,TabView_height-80,Screen_width, 80)];
        [self.view addSubview:_bottomBar];
    }
    return _bottomBar;
}

@end
