//
//  XHFloatWindowSingleton.h
//  XHFloatingWindow
//
//  Created by 帅棋 on 2018/11/26.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CallBack)(void);

@class XHFloatWindowController;
@interface XHFloatWindowSingleton : NSObject

@property (nonnull, nonatomic, strong) XHFloatWindowController *floatVC;
@property (nullable, nonatomic, copy)CallBack floatWindowCallBack;

- (void)xh_addWindowOnTarget: (nonnull id)target onClick:(nullable void(^)(void))callback;
- (void)xh_setWindowSize:(float)size;
- (void)xh_setHideWindow:(BOOL)hide;
- (void)xh_setBackgroundImage:(nullable NSString *)imageName forState:(UIControlState)UIControlState;

+ (nonnull instancetype)Ins;

@end
