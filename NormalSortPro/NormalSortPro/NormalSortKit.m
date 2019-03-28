//
//  NormalSortKit.m
//  NormalSortPro
//
//  Created by Amy Lee on 2019/3/28.
//  Copyright © 2019 Amy Lee. All rights reserved.
//

//常见的排序算法

#import "NormalSortKit.h"

@implementation NormalSortKit

/*********快速排序**********/
/* 思路：O(nlogn)
   1）选择一个基准元素,通常可以选择中间下标的数做基准,
   2）通过一趟排序讲待排序的记录分割成独立的两部分，其中一部分记录的元素值均比基准元素值小。另一部分记录的 元素值比基准值大。
   3）此时基准元素在其排好序后的正确位置
   4）然后分别对这两部分记录用同样的方法继续进行排序，直到整个序列有序。
 */

#pragma mark - 快速排序
+ (void)fastSort:(NSMutableArray *)array low:(int)low high:(int)high
{
    if(array == nil || array.count == 0 || low >= high){
        NSLog(@"注意快速排序条件");
        return;
    }
    
    //取中值
    int middle = low + (high - low)/2;
    NSNumber *prmt = array[middle];
    int i = low;
    int j = high;
    
    //开始排序，使得left<prmt 同时right>prmt
    while (i <= j) {
        //        while ([array[i] intValue] < [prmt intValue]) {
        //该行与下一行作用相同
        
        while ([array[i] compare:prmt] == NSOrderedAscending) {
            i++;
        }
        //        while ([array[j] intValue] > [prmt intValue]) {
        //该行与下一行作用相同
        
        while ([array[j] compare:prmt] == NSOrderedDescending) {
            j--;
        }
        
        if(i <= j){
            [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            i++;
            j--;
        }
        NSLog(@"快速排序排序中:%@",array);
    }
    if (low < j) {
        [self fastSort:array low:low high:j];
    }
    if (high > i) {
        [self fastSort:array low:i high:high];
    }
}
/********** 冒泡排序 *********/
/*实现思路 O(n^2)
 　　1，每一趟比较都比较数组中两个相邻元素的大小
 　　2，如果i元素小于i-1元素，就调换两个元素的位置
 　　3，重复n-1趟的比较
 */
+(void)BubbleSort:(NSMutableArray *)array{
    
    for (int i =0; i<array.count; i++) {
        for (int j =0; j< array.count-1-i; j++) {
            if (array[j]>array[j+1]) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
   
    NSLog(@"冒泡排序：%@",array);
}

/****** 选择排序 *******/
/* O(n^2)
 在要排序的一组数中，选出最小（或者最大）的一个数与第1个位置的数交换；
 然后在剩下的数当中再找最小（或者最大）的与第2个位置的数交换，
 依次类推，直到第n-1个元素（倒数第二个数）和第n个元素（最后一个数）比较为止。
*/
+(void)selectSort:(NSMutableArray *)array{
    int k ;
    for (int i=0; i<array.count; i++) {
        k = i;
        //先找出最小的数 下标 ，然后数据互换
        for (int j=i+1; j<array.count; j++) {
            NSInteger obj_k = [array[k] integerValue];
            NSInteger  obj_j = [array[j] integerValue];

            if (obj_k>obj_j) {
                k = j;
            }
        }
        if (k!=i) {
            [array exchangeObjectAtIndex:i withObjectAtIndex:k];
            //下列交换元素无效，待研究
//            id temp = array[i];
//            array[i]= array[k];
//            array[k]=temp;
        }
    }
    NSLog(@"选择排序：%@",array);
}

/******* 堆排序 *******/
/*
 思路：堆排序是一种树形选择排序，是对直接选择排序的有效改进。
 
 
 
 */

@end
