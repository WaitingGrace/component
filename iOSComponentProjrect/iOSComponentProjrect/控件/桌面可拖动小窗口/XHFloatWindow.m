//
//  XHFloatWindow.m
//  XHFloatingWindow
//
//  Created by 帅棋 on 2018/11/26.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "XHFloatWindow.h"
#import "XHFloatWindowSingleton.h"

@interface XHFloatWindow ()

@end

@implementation XHFloatWindow

+ (void)xh_addWindowOnTarget:(id)target onClick:(void (^)(void))callback {
    [[XHFloatWindowSingleton Ins] xh_addWindowOnTarget:target onClick:callback];
}

+ (void)xh_setWindowSize:(float)size {
    [[XHFloatWindowSingleton Ins] xh_setWindowSize:size];
}

+ (void)xh_setHideWindow:(BOOL)hide {
    [[XHFloatWindowSingleton Ins] xh_setHideWindow:hide];
}

+ (void)xh_setBackgroundImage:(NSString *)imageName forState:(UIControlState)UIControlState {
    [[XHFloatWindowSingleton Ins] xh_setBackgroundImage:imageName forState:UIControlState];
}

@end
