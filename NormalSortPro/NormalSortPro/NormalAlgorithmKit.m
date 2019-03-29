//
//  NormalAlgorithmKit.m
//  NormalSortPro
//
//  Created by Amy Lee on 2019/3/29.
//  Copyright © 2019 Amy Lee. All rights reserved.
//

#import "NormalAlgorithmKit.h"
#import "ListNode.h"

@implementation NormalAlgorithmKit


/****** 二分查找 *****/
/* 有序数组
 
 二分查找又称折半查找，优点是比较次数少，查找速度快，平均性能好；
 其缺点是要求待查表为有序表，且插入删除困难。
 因此，折半查找方法适用于不经常变动而查找频繁的有序列表
 
 原理：查找过程从数组的中间元素开始，如果中间元素正好是要查找的元素，则搜素过程结束；
      如果某一特定元素大于或者小于中间元素，则在数组大于或小于中间元素的那一半中查找，
      而且跟开始一样从中间元素开始比较。
      如果在某一步骤数组为空，则代表找不到。
 这种搜索算法每一次比较都使搜索范围缩小一半。
 时间复杂度：O(logn)
 
 */
//非递归模式
//假设有序列表，从小到大
+(NSInteger)BinarySearchNoRecursion:(NSArray *)array target:(NSInteger)target{
    if (array.count==0) {
        return -1;
    }
    NSInteger low = 0;
    NSInteger high = array.count-1;
    
    while (low<=high) {
        NSInteger middle = (low+high)/2;
        NSInteger num = [array[middle] integerValue];
        if (num > target) {
          
            high = middle-1;
            
        }else if(num < target){
            
            low = middle+1;
            
        }else{
            return middle;
        }
    }
    return -1;
}
//递归模式
//假设有序列表，从小到大
+(NSInteger)BinarySearchWithRecursion:(NSArray *)array target:(NSInteger)target begin:(NSInteger)begin end:(NSInteger)end{
   
    if (begin>end) {
        return -1;
    }
    NSInteger middle = begin + (end-begin)/2;
    NSInteger num = [array[middle] integerValue];
    
    if (num > target) {
       
      return [self BinarySearchWithRecursion:array target:target begin:begin end:middle-1];
           
    }else if(num < target){
        
     return [self BinarySearchWithRecursion:array target:target begin:middle+1 end:end];
    }else{
        return middle;
       }
}

//对数组进行全排列
//input: [1, 2, 3]
//output: [123, 132, 213, 231, 312, 321]
/*给定一个n个元素数组，其全排列的过程可以描述如下：
（1）任意取一个元素放在第一个位置，则有n种选择；
（2）再剩下的n-1个元素中再取一个元素放在第二个位置则有n-1种选择，此时可以看做对n-1个元素进行全排列；
（3）重复第二步，直到对最后一个元素进行全排列，即最后一个元素放在最后一个位置，全排列结束。
*/
//原文：https://blog.csdn.net/k346k346/article/details/51154786

//递归实现的优缺点：
//由于递归将问题逐级分解，因此相对比较容易理解，但是需要消耗大量的栈空间，如果函数栈空间不够，那么就运行不下去了，而且函数调用开销也比较大。

+(void)allArrangementWith:(NSMutableArray *)array withIndex:(NSInteger)index{
 
    NSInteger length = array.count;
    
    if (index == length) {
        NSLog(@"subArr:%@",array);
    }else{
        for (NSInteger i = index; i<length; i++) {
            //交换i 和 index 下标
            [array exchangeObjectAtIndex:i withObjectAtIndex:index];
            
            [self allArrangementWith:array withIndex:index+1 ];
            //将第 i 个元素换回原处
            [array exchangeObjectAtIndex:i withObjectAtIndex:index];
            
        }
    }
}























@end
