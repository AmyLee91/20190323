//
//  ViewController.m
//  NormalSortPro
//
//  Created by Amy Lee on 2019/3/28.
//  Copyright © 2019 Amy Lee. All rights reserved.
//

#import "ViewController.h"
#import "NormalSortKit.h"
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

}
- (IBAction)otherClick:(id)sender {
}

@end
