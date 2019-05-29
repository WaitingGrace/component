//
//  WGOperationSuccessHUD.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGOperationSuccessHUD : UIView<CAAnimationDelegate>

-(void)start;

-(void)hide;

+(WGOperationSuccessHUD*)showIn:(UIView*)view;

+(WGOperationSuccessHUD*)hideIn:(UIView*)view;

@end
