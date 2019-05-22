//
//  XHFloatWindow.h
//  XHFloatingWindow
//
//  Created by 帅棋 on 2018/11/26.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WGFloatWindow : NSObject

/* add the floaitng window to the target and the callback block will be excuted when click the button */
+ (void)xh_addWindowOnTarget:(nonnull id)target onClick:(nullable void(^)(void))callback;
/* you can resize the view's size, 50 by default if you don't set it */
+ (void)xh_setWindowSize:(float)size;
/* you can hide the view or show it again */
+ (void)xh_setHideWindow:(BOOL)hide;
/* you can reset the button's background image of normal and selected states */
+ (void)xh_setBackgroundImage:(nullable NSString *)imageName forState:(UIControlState)UIControlState;

@end
