//
//  ListNode.m
//  NormalSortPro
//
//  Created by Amy Lee on 2019/3/29.
//  Copyright © 2019 Amy Lee. All rights reserved.
//

#import "ListNode.h"

//单向链表
@interface ListNode() {
    id val;
    ListNode *next;
}

@end

@implementation ListNode

/**
 添加节点

 @param p 节点指针
 @param value 节点值
 @return 头节点，其中头节点value 为0
 */
+(ListNode*)addNode:(ListNode *)p andValue:(id)value{
    if (p == nil) {
        p = [[ListNode alloc]init];
        p->val = value;
        p->next = nil;
    }else{
        p->next = [ListNode addNode:p->next andValue:value];
    }
    return p;
}

/**
 *  遍历单链表
 *
 *  @param head 头结点
 *  @param block 处理block
 */
+(void)traverseList:(ListNode *)head resultBlock:(void(^)(NSInteger i))block{
    if (head->next == nil) {
        if (block) {
            block([head->val integerValue]);
        }
        return;
    }
    if (block) {
        block([head->val integerValue]);
    }
    [ListNode traverseList:head->next resultBlock:block];
}
//


/******** 链表反转 *******/
//输入: 1->2->3->4->5->NULL
//输出: 5->4->3->2->1->NULL

/// 全链表反转
+ (ListNode *)reverse:(ListNode *)node{
    
    ListNode *currNode ,*nextNode,*preNode;
    
    if (!node) {
        return nil;
    }
    if (!node->next) {
        return node;
    }
    currNode = node;
    nextNode = currNode->next;
    currNode->next = nil;
    
    while (nextNode) {
        preNode = nextNode->next;
        nextNode->next = currNode;
        currNode = nextNode;
        nextNode = preNode;
    }
    node = currNode;
    return node;
    
}
/**
 *  单链表逆置：链表首尾节点对换
 *  @param head 头结点
 
 *  输入: 1->2->3->4->5->NULL
 *  输出: 5->2->3->4->1->NULL
 */
+ (ListNode *)reverseList:(ListNode *)head{
//    1. 原地逆置
    ListNode *p = head->next;
    //空表和一个元素的时候
    if (p == nil || p->next == nil) {
        return head;
    }
     //p,q两个相邻结点的前后关系改变，t保存下一次修改的结点
    ListNode *q = p->next;
    ListNode *t = q->next;
    
    while (q!= nil) {
        q->next = p;
        p = q;
        q = t;
        if (t != nil) {
            t = t->next;
        }
    }
    //修改逆置后的最后一个节点next 为nil，头节点指向原来最后一个节点
   
    head->next->next = nil;
    head->next = p;
  
    return head;
    

    
    
}
//https://blog.csdn.net/qq_34012510/article/details/80244570
//递归-逆置
+(ListNode *)reverseList2:(ListNode *)head{
    if (head == nil || head->next){
        return head;
    }
    ListNode *pre = [self reverseList2:head->next];
    head->next->next = head;
    head->next = nil;
    return pre;
    
}

@end
