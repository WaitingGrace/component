//
//  XHFloatWindowSingleton.m
//  XHFloatingWindow
//
//  Created by 帅棋 on 2018/11/26.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "XHFloatWindowSingleton.h"
#import "XHFloatWindowController.h"

@implementation XHFloatWindowSingleton

+ (instancetype)Ins {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

- (void)xh_addWindowOnTarget:(UIViewController *)target onClick:(void (^)(void))callback {
    _floatVC = [[XHFloatWindowController alloc] init];
    [target addChildViewController:_floatVC];
    [target.view addSubview:_floatVC.view];
    [_floatVC setRootView];
    _floatWindowCallBack = callback;
}

- (void)xh_setWindowSize:(float)size {
    [_floatVC setWindowSize:size];
}

- (void)xh_setHideWindow:(BOOL)hide {
    [_floatVC setHideWindow:hide];
}

- (void)xh_setBackgroundImage:(NSString *)imageName forState:(UIControlState)UIControlState {
    [_floatVC resetBackgroundImage:imageName forState:UIControlState];
}

@end
