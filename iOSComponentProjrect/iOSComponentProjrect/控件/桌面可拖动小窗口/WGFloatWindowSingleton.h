//
//  WGFloatWindowSingleton.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CallBack)(void);

@class WGFloatWindowController;
@interface WGFloatWindowSingleton : NSObject

@property (nonnull, nonatomic, strong) WGFloatWindowController *floatVC;
@property (nullable, nonatomic, copy)CallBack floatWindowCallBack;

- (void)wg_addWindowOnTarget: (nonnull id)target onClick:(nullable void(^)(void))callback;
- (void)wg_setWindowSize:(float)size;
- (void)wg_setHideWindow:(BOOL)hide;
- (void)wg_setBackgroundImage:(nullable NSString *)imageName forState:(UIControlState)UIControlState;

+ (nonnull instancetype)Ins;

@end
