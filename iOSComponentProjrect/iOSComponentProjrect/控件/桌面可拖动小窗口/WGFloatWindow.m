//
//  WGFloatWindow.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGFloatWindow.h"
#import "WGFloatWindowSingleton.h"

@interface WGFloatWindow ()

@end

@implementation WGFloatWindow

+ (void)wg_addWindowOnTarget:(id)target onClick:(void (^)(void))callback {
    [[WGFloatWindowSingleton Ins] wg_addWindowOnTarget:target onClick:callback];
}

+ (void)wg_setWindowSize:(float)size {
    [[WGFloatWindowSingleton Ins] wg_setWindowSize:size];
}

+ (void)wg_setHideWindow:(BOOL)hide {
    [[WGFloatWindowSingleton Ins] wg_setHideWindow:hide];
}

+ (void)wg_setBackgroundImage:(NSString *)imageName forState:(UIControlState)UIControlState {
    [[WGFloatWindowSingleton Ins] wg_setBackgroundImage:imageName forState:UIControlState];
}

@end
