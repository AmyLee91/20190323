//
//  ListNode.h
//  NormalSortPro
//
//  Created by Amy Lee on 2019/3/29.
//  Copyright © 2019 Amy Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


//链表节点

@interface ListNode : NSObject
/**
 添加节点
 
 @param p 节点指针
 @param value 节点值
 @return 头节点，其中头节点value 为0
 */
+(ListNode*)addNode:(ListNode *)p andValue:(id)value;

/**
 *  遍历单链表
 *
 *  @param head 头结点
 *  @param block 处理block
 */
+(void)traverseList:(ListNode *)head resultBlock:(void(^)(NSInteger i))block;


/******** 链表反转 *******/
//输入: 1->2->3->4->5->NULL
//输出: 5->4->3->2->1->NULL

/// 全链表反转
+ (ListNode *)reverse:(ListNode *)node;

/**
 *  单链表逆置
 *
 *  @param head 头结点
 */
+ (ListNode *)reverseList:(ListNode *)head;


//递归-逆置
+(ListNode *)reverseList2:(ListNode *)head;
@end


NS_ASSUME_NONNULL_END
