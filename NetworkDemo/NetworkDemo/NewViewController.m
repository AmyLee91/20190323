//
//  NewViewController.m
//  NetworkDemo
//
//  Created by Amy Lee on 2019/6/18.
//  Copyright © 2019 Amy Lee. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController (){
//    UIImage *img1;
//    UIImage *img2;
}
@property(nonatomic,strong) UIImage *img1;
@property(nonatomic,strong) UIImage *img2;

@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UIImageView *imgView1;
@property(nonatomic,strong)UIImageView *imgView2;
@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //-[UIImageView initWithFrame:] must be used from main thread only
    self.view.backgroundColor = [UIColor orangeColor];
    self.imgView1.backgroundColor = [UIColor greenColor];
    self.imgView2.backgroundColor = [UIColor redColor];
    self.imgView.backgroundColor = [UIColor whiteColor];
    
    //多个URL异步加载多张图片合成一张图
//    使用 dispatch_group_async 追加 block 到 global queue 中，
//    这些block 全部执行完毕，就会执行 main dispatch queue 中的结束处理的 block
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_t group = dispatch_group_create();
    
    __weak typeof(self) bself = self;
    //下载图片1，放进线程组里
    dispatch_group_async(group, queue, ^{
        NSString *urlStr =@"http://images.psiot.com.cn/light/a3955907d7e4593bbe97a85b97455f34.jpg";
        NSURL *url = [NSURL URLWithString:urlStr];
        NSData *imgData1 = [NSData dataWithContentsOfURL:url];
        bself.img1 = [UIImage imageWithData:imgData1];
        //UI 相关要放到主线程执行,数据可以其他现场异步获取
        //-[UIImageView setImage:] must be used from main thread only
       //  ********      bself.imgView1.image = bself.img1;
    });
    //下载图片2，放进线程组里
    dispatch_group_async(group, queue, ^{
        NSURL *url = [NSURL URLWithString:@"http://images.psiot.com.cn/light/db468f6e89297c034567e5c61fed7310.jpg"];
        NSData *imgData2 = [NSData dataWithContentsOfURL:url];
        bself.img2 = [UIImage imageWithData:imgData2];
    });
    
    //合成
    dispatch_group_notify(group, queue, ^{
        NSLog(@"合成---%@",[NSThread currentThread]);
        UIGraphicsBeginImageContext(CGSizeMake(300, 300));
        [bself.img1 drawInRect:CGRectMake(0, 0, 150, 300)];
       // bself.img1 = nil;
        [bself.img2 drawInRect:CGRectMake(150, 0, 150, 300)];
     //   bself.img2 = nil;
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"合成 UI---%@",[NSThread currentThread]);
            //UI 相关要放到主线程执行,数据可以其他现场异步获取
            //-[UIImageView setImage:] must be used from main thread only
             bself.imgView2.image = bself.img2;//
             bself.imgView1.image = bself.img1;
            bself.imgView.image = img;
        });
    });
   
}
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 88,300, 300)];
        [self.view addSubview:_imgView];
    }
    return _imgView;
}
-(UIImageView *)imgView1{
    if (!_imgView1) {
        _imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 400,150, 300)];
        [self.view addSubview:_imgView1];
    }
    return _imgView1;
}
-(UIImageView *)imgView2{
    if (!_imgView2) {
        _imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(150, 400,150, 300)];
        [self.view addSubview:_imgView2];
    }
    return _imgView2;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
