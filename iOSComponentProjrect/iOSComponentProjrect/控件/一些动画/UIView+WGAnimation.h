//
//  UIView+WGAnimation.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/4/3.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WGAnimation)

/**
 *  从底部升起出现
 */
- (void)cf_showFromBottom;

/**
 *  消失降到底部
 */
- (void)cf_dismissToBottomWithCompleteBlock:(void(^)(void))completeBlock;

/**
 *  从透明到不透明
 */
- (void)cf_emerge;

/**
 *  从不透明到透明
 */
- (void)cf_fake;

/**
 *  按钮震动动画
 */
- (void)cf_startSelectedAnimation;

/*! 呼吸灯
 * [view.layer addAnimation:[view AlphaLight:2.5] forKey:@"aAlpha"];
 * [view.layer removeAnimationForKey:@"aAlpha"];
 */
- (CABasicAnimation *) AlphaLight:(float)time;


@end

NS_ASSUME_NONNULL_END
