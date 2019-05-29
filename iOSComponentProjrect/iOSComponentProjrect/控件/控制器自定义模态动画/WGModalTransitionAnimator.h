//
//  WGModalTransitionAnimator.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/21.
//  Copyright © 2019 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

typedef NS_ENUM(NSUInteger, WGModalTransitonDirection) {
    WGModalTransitonDirectionBottom,
    WGModalTransitonDirectionLeft,
    WGModalTransitonDirectionRight,
};

@interface WGDetectScrollViewEndGestureRecognizer : UIPanGestureRecognizer
@property (nonatomic, weak) UIScrollView *scrollview;
@end

@interface WGModalTransitionAnimator : UIPercentDrivenInteractiveTransition <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign, getter=isDragable) BOOL dragable;
@property BOOL bounces;
@property WGModalTransitonDirection direction;
@property CGFloat behindViewScale;
@property CGFloat behindViewAlpha;
@property CGFloat transitionDuration;

- (id)initWithModalViewController:(UIViewController *)modalViewController;
- (void)setContentScrollView:(UIScrollView *)scrollView;

@end
