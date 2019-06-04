//
//  WGBirthdayView.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WGBirthdayAnimationType) {
    WGBirthdayAnimationTypeUnknown,
    WGBirthdayAnimationTypeLidGroup,
    WGBirthdayAnimationTypeHappyBirthdayShow,
    WGBirthdayAnimationTypeHappyBirthdayHidden,
};

typedef void(^WGBirthdayReceiveActionBlock)(void);

@interface WGBirthdayView : UIView

/**
 动画界面整体高度
 */
@property (nonatomic, assign, readonly) CGFloat height;
/**
 动画界面整体宽度
 */
@property (nonatomic, assign, readonly) CGFloat width;

@property (nonatomic, strong) NSString *birthdayTitle;
@property (nonatomic, strong) NSString *birthdaySubTitle;
@property (nonatomic, strong) NSString *birthdayDescritpion;

@property (nonatomic, copy) WGBirthdayReceiveActionBlock receiveActionBlock;

/** 
 controller销毁时设为yes 处理动画代理强引用造成的循环引用问题 
 */
@property (nonatomic, assign) BOOL isCloseAnimation;

/**
 盒子打开动画
 */
- (void)animationForBirthdayLid;

@end
