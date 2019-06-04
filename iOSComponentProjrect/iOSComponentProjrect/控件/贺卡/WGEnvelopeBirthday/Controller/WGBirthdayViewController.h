//
//  WGBirthdayViewController.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGBirthdayEnvelopeView.h"

typedef void(^YKBirthdayLayerCloseBlock)(void);

@class WGBirthdayModel;

@interface WGBirthdayViewController : UIViewController

@property (nonatomic, strong) WGBirthdayModel *birthdayModel;
@property (nonatomic, copy) YKBirthdayReceiveActionBlock receiveActionBlock;
@property (nonatomic, copy) YKBirthdayLayerCloseBlock birthdayLayerCloseBlock;

- (void)showInViewController:(UIViewController *)viewController;

@end
