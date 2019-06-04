//
//  WGHappyBirthdayViewController.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGBirthdayView.h"
#import "WGBirthdayItem.h"

@interface WGHappyBirthdayViewController : UIViewController

@property (nonatomic, copy) WGBirthdayReceiveActionBlock receiveActionBlock;

@property (nonatomic, strong) WGBirthdayItem *birthdayItem;

- (void)showInViewController:(UIViewController *)viewController;

@end
