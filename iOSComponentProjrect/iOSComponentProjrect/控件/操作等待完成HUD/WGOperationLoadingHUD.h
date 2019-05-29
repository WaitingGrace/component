//
//  WGOperationLoadingHUD.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGOperationLoadingHUD : UIView

-(void)start;

-(void)hide;

+(WGOperationLoadingHUD*)showIn:(UIView*)view;

+(WGOperationLoadingHUD*)hideIn:(UIView*)view;

@end
