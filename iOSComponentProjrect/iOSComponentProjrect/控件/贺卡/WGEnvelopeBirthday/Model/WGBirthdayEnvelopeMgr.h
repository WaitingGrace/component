//
//  WGLayerBirthdayMgr.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WGBirthdayModel;

@interface WGBirthdayEnvelopeMgr : NSObject

+ (instancetype)shareInstance;

/**
 显示生日特权动画
 */
- (void)showBirthdayViewController:(UIViewController *)viewController birthdayModel:(WGBirthdayModel *)birthdayModel;

/**
 清除生日弹层
 */
- (void)clearBirthdayViewController;

- (void)playBirthdayMusic;
- (void)stopBirthdayMusic;

@end
