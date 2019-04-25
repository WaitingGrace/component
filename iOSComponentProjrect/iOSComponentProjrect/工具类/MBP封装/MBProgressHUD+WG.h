//
//  MBProgressHUD+WG.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/27.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (WG)

+ (void)showInfo:(NSString *)Info;
+ (void)showInfo:(NSString *)Info toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;


+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;


+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;


@end
