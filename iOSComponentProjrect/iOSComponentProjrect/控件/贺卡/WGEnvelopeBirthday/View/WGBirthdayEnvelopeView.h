//
//  WGBirthdayEnvelopeView.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGBirthdayModel;

typedef void(^YKBirthdayReceiveActionBlock)(void);

typedef NS_ENUM(NSUInteger, WGBirthdayAnimationType) {
    WGBirthdayAnimationTypeUnknown,
    WGBirthdayAnimationTypeLidAnimationFirst,
    WGBirthdayAnimationTypeLidAnimationSecond,
    WGBirthdayAnimationTypeLetterPaperAnimation,
    WGBirthdayAnimationTypeShowButton
};

static NSString *const KYKBirthdayAnimationType = @"KYKBirthdayAnimationType";

@interface WGBirthdayEnvelopeView : UIView

@property (nonatomic, assign) CGFloat uiScale;
@property (nonatomic, strong) WGBirthdayModel *birthdayModel;
@property (nonatomic, copy) YKBirthdayReceiveActionBlock receiveActionBlock;

- (void)startCustomAnimation;

@end
