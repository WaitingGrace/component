//
//  WGSort.h
//  Algorithm
//
//  Created by 帅棋 on 2019/5/21.
//  Copyright © 2019 WG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGSort : NSObject

/**
 快速排序
 
 @param mArray 被排序的数组
 @param left 第一个元素
 @param right 最后一个元素
 */
- (void)quickSort:(NSMutableArray *)mArray leftIndex:(int )left rightIndex:(int )right;

/**
 冒泡排序
 */
- (void)bubbleSort:(NSMutableArray *)mArray;

/**
 选择排序
 */
- (void)selectSort:(NSMutableArray *)mArray;

/**
 直接插入排序
 */
- (void)insertSort:(NSMutableArray *)mArray;

/**
 二分插入排序
 */
-(void)binaryInsertSort:(NSMutableArray *)mArray;

/**
 希尔排序
 */
-(void)shellSort:(NSMutableArray *)mArray;

/*
 堆排序
 */
- (void)heapSort:(NSMutableArray *)mArray isAsc:(BOOL)isAsc;
 
@end
