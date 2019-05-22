//
//  UIView+WGAnimation.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/4/3.
//  Copyright © 2019 WG. All rights reserved.
//

#import "UIView+WGAnimation.h"
#import <objc/runtime.h>
#define BottomRect CGRectMake(self.frame.origin.x, [[UIScreen mainScreen] bounds].size.height, self.frame.size.width, self.frame.size.height)
@implementation UIView (WGAnimation)

#pragma mark - 底部出现动画
- (void)cf_showFromBottom {
    CGRect rect = self.frame;
    self.frame = BottomRect;
    [self executeAnimationWithFrame:rect completeBlock:nil];
}

#pragma mark - 底部消失动画
- (void)cf_dismissToBottomWithCompleteBlock:(void(^)(void))completeBlock {
    [self executeAnimationWithFrame:BottomRect completeBlock:completeBlock];
}

#pragma mark - 背景浮现动画
- (void)cf_emerge {
    self.alpha = 0.0;
    [self executeAnimationWithAlpha:0.2 completeBlock:nil];
}

#pragma mark - 背景淡去动画
- (void)cf_fake {
    [self executeAnimationWithAlpha:0.f completeBlock:nil];
}

#pragma mark - 执行动画
- (void)executeAnimationWithAlpha:(CGFloat)alpha completeBlock:(void(^)(void))completeBlock{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = alpha;
    } completion:^(BOOL finished) {
        if (finished && completeBlock) completeBlock();
    }];
}

- (void)executeAnimationWithFrame:(CGRect)rect completeBlock:(void(^)(void))completeBlock{
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = rect;
    } completion:^(BOOL finished) {
        if (finished && completeBlock) completeBlock();
    }];
}

#pragma mark - 按钮震动动画
- (void)cf_startSelectedAnimation {
    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    ani.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    ani.removedOnCompletion = YES;
    ani.fillMode = kCAFillModeForwards;
    ani.duration = 0.4;
    [self.layer addAnimation:ani forKey:@"transformAni"];
}
/*! 透明度变化，呼吸灯效果 */
- (CABasicAnimation *) AlphaLight:(float)time
{
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return animation;
}


@end
