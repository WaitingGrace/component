//
//  SYStarRatingView.h
//  SYStarRatingView
//
//  Created by 帅棋 on 2018/11/26.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYStarRatingView;

@protocol StarRatingViewDelegate <NSObject>

@optional
/**
 分数回调
 
 @param view 视图
 @param score 分数
 */
-(void)starRatingView:(SYStarRatingView *)view score:(float)score;

@end

@interface SYStarRatingView : UIView

/**
 *  前景图填充颜色 默认clearColor
 */
@property (nonatomic, strong) UIColor *foregroundViewColor;
/**
 *  背景图填充颜色 默认clearColor
 */
@property (nonatomic, strong) UIColor *backgroundViewColor;
/**
 *  前景图名称 默认foregroundStar
 */
@property (nonatomic, copy) NSString *foregroundImageName;
/**
 *  背景图名称 默认backgroundStar
 */
@property (nonatomic, copy) NSString *backgroundImageName;
/**
 是否是指示器（指示器不可滑动打分）
 */
@property (nonatomic)       BOOL isIndicator;
@property (nonatomic, weak) id <StarRatingViewDelegate> delegate;

/**
 *  初始化SYStarRatingView
 *
 *  @param frame  Rectangles
 *  @param number 星星个数
 *
 *  @return TQStarRatingViewObject
 */
- (instancetype)initWithFrame:(CGRect)frame numberOfStar:(NSInteger)number;

/**
 *  设置控件分数
 *
 *  @param score     分数，必须在 0 － 1 之间
 *  @param isAnimate 是否启用动画
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate;

/**
 *  设置控件分数
 *
 *  @param score      分数，必须在 0 － 1 之间
 *  @param isAnimate  是否启用动画
 *  @param completion 动画完成block
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion;

/**
 * 添加监听KVO
 */
- (void)registerForKVO;
/**
 *  移除监听KVO
 */
- (void)unregisterFromKVO;

@end


#define kNUMBER_OF_STAR  5
