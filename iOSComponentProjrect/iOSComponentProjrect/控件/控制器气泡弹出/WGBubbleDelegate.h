//
//  WGBubbleDelegate.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WGBubbleDelegateAnimationDelegate <NSObject>

@required
- (void)bubblePresentAnimationCompleted;
- (void)bubbleDismissAnimationStart;

@end

@interface WGBubbleDelegate : NSObject<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) id<WGBubbleDelegateAnimationDelegate> delegate;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, strong) UIColor *bubbleColor;
@property (nonatomic, strong) UIView *bubble;

@end
