//
//  WGWaterFallLabel.h
//  
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WGWaterFallLabel;
/**
 block回掉

 @param waterFallLabel 本身
 @param text 当前文本
 @param index 当前tag
 
 */
typedef void(^WGWaterFallLabelCallBackBlock)(WGWaterFallLabel *waterFallLabel,NSString *text ,NSInteger index);

typedef void(^WGWaterFallLabelCallBackMultipleBlock)(WGWaterFallLabel *waterFallLabe,NSArray *array);
typedef void(^WGWaterFallLabelCallHeightBlock)(CGFloat height);

/**
 流水布局view
 */
@interface WGWaterFallLabel : UIScrollView

/**
 初始化方法

 @param point 传入点坐标
 @param tags 数据源数组
 @return GHWaterFallLabel
 */
+ (instancetype)creatWaterFallLabelWithPoint: (CGPoint)point tags: (NSMutableArray *)tags;

- (void)setPoint: (CGPoint)point;
@property (nonatomic , copy) WGWaterFallLabelCallBackBlock textBlock;
@property (nonatomic , copy) WGWaterFallLabelCallBackMultipleBlock multipleBlock;
@property (nonatomic , copy) WGWaterFallLabelCallHeightBlock heightBlock;


/** 数据源数组 可以使用set方法追加标签 */
@property (nonatomic , strong) NSMutableArray *tags;
- (CGFloat)getHeightWithArray: (NSArray *)array;
/** 设置最大高度 */
@property (nonatomic , assign) CGFloat maxHeight;
/** 是否是多选 默认是NO 多选是YES */
@property (nonatomic , assign) BOOL isMultiple;


@end

NS_ASSUME_NONNULL_END
