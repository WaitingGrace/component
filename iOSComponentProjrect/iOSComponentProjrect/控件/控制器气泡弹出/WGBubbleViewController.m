//
//  WGBubbleViewController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "WGBubbleViewController.h"
#import "WGBubbleDelegate.h"

@interface WGBubbleViewController ()<WGBubbleDelegateAnimationDelegate>

@end

@implementation WGBubbleViewController {
    WGBubbleDelegate *_bubbleDelegate;
}

- (instancetype)init {
    self = [super init];
    _bubbleDelegate = [WGBubbleDelegate new];
    _bubbleDelegate.delegate = self;
    self.transitioningDelegate = _bubbleDelegate;
    self.modalPresentationStyle = UIModalPresentationCustom;
    return self;
}

- (void)setBubbleColor:(UIColor *)bubbleColor {
    _bubbleDelegate.bubbleColor = bubbleColor;
}

- (void)setStartPoint:(CGPoint)startPoint {
    _bubbleDelegate.startPoint = startPoint;
}

- (void)setBubbleDuration:(CGFloat)bubbleDuration {
    _bubbleDelegate.duration = bubbleDuration;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.alpha = 0.0;
    }];
}

- (void)bubblePresentAnimationCompleted {
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.alpha = 1.0;
    }];
}

- (void)bubbleDismissAnimationStart {
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.alpha = 0.0;
    }];
}

- (void)dealloc {
    
}

@end
