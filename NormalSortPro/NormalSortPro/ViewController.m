//
//  ViewController.m
//  NormalSortPro
//
//  Created by Amy Lee on 2019/3/28.
//  Copyright © 2019 Amy Lee. All rights reserved.
//

#import "ViewController.h"
#import "NormalSortKit.h"
#import "NormalAlgorithmKit.h"
#import "ListNode.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)fastSortClick:(id)sender {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@24,@35,@13,@22,@33,@78,@9,@99]];
    
    [NormalSortKit fastSort:arr low:0 high:7];
}
- (IBAction)bubbleSortClick:(id)sender {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@4,@35,@13,@2,@33,@8,@9,@99]];
    
     [NormalSortKit BubbleSort:arr];
}
- (IBAction)heapSort:(id)sender {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@14,@5,@13,@2,@3,@8,@19,@99]];
    
    [NormalSortKit HeapSort:arr with:arr.count];
}
- (IBAction)selectSortClick:(id)sender {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@14,@5,@13,@2,@3,@8,@19,@99]];
    
     [NormalSortKit selectSort:arr];
}
- (IBAction)newClick:(id)sender {

   NSInteger index = [NormalAlgorithmKit BinarySearchNoRecursion:@[@4,@15,@23,@32,@43,@68,@79,@99] target:99];
    NSLog(@"index:%li",(long)index);
}
- (IBAction)otherClick:(id)sender {

    [self listNodeChange];
}


//二分查找
-(void)someSearchFun{
       NSInteger index =  [NormalAlgorithmKit BinarySearchWithRecursion:@[@4,@15,@23,@32,@43,@68,@79,@99] target:23 begin:0 end:7];
    
        NSLog(@"22222index:%li",(long)index);
    
}
//全排列
-(void)AllArrange{
    NSMutableArray* arr = [NSMutableArray arrayWithArray:@[@1,@2,@3]];
    
    [NormalAlgorithmKit allArrangementWith:arr withIndex:0 ];
    
    NSLog(@"%@",arr);
}
//链表操作
-(void)listNodeChange{
    ListNode *a = [ListNode addNode:nil andValue:@11];
    ListNode *b = [ListNode addNode:a andValue:@2];
    ListNode *c = [ListNode addNode:b andValue:@3];
    ListNode *d = [ListNode addNode:c andValue:@4];
    ListNode *e = [ListNode addNode:d andValue:@55];
    NSLog(@"当前链表：%@",e);
    [ListNode traverseList:e resultBlock:^(NSInteger i) {
        NSLog(@"遍历：%ld",(long)i);
    }];
    NSLog(@"----------------------");
    
    ListNode *newL =[ListNode reverse:e];
//     NSLog(@"反转后的链表：%@",newL);
//    [ListNode traverseList:newL resultBlock:^(NSInteger i) {
//        NSLog(@"反转后的链表：%ld",(long)i);
//    }];
    
  ListNode *newLL = [ListNode reverseList2:newL];
    [ListNode traverseList:newLL resultBlock:^(NSInteger i) {
        NSLog(@"变更后的链表：%ld",(long)i);
    }];
    
}
@end
