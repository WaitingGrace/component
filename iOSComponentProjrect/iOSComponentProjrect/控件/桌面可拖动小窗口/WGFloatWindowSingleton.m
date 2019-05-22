//
//  WGFloatWindowSingleton.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGFloatWindowSingleton.h"
#import "WGFloatWindowController.h"

@implementation WGFloatWindowSingleton

+ (instancetype)Ins {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

- (void)wg_addWindowOnTarget:(UIViewController *)target onClick:(void (^)(void))callback {
    _floatVC = [[WGFloatWindowController alloc] init];
    [target addChildViewController:_floatVC];
    [target.view addSubview:_floatVC.view];
    [_floatVC setRootView];
    _floatWindowCallBack = callback;
}

- (void)wg_setWindowSize:(float)size {
    [_floatVC setWindowSize:size];
}

- (void)wg_setHideWindow:(BOOL)hide {
    [_floatVC setHideWindow:hide];
}

- (void)wg_setBackgroundImage:(NSString *)imageName forState:(UIControlState)UIControlState {
    [_floatVC resetBackgroundImage:imageName forState:UIControlState];
}


@end
