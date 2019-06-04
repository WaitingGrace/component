//
//  WGBirthdayMgr.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGHappyBirthdayViewController.h"
#import <UIKit/UIKit.h>
#import "WGBirthdayItem.h"

@interface WGBirthdayMgr : NSObject

+ (instancetype)shareInstance;

- (void)showBirthdayViewInViewController:(UIViewController *)viewController birthdayItem:(WGBirthdayItem *)birthdayItem receiveBlock:(WGBirthdayReceiveActionBlock)receiveBlock;

- (void)clearBirthdayViewController;

- (BOOL)isBirthdayViewControllerDisplaying;

@end
