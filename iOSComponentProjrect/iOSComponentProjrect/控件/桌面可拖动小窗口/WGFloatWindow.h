//
//  WGFloatWindow.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WGFloatWindow : NSObject

/* add the floaitng window to the target and the callback block will be excuted when click the button */
+ (void)wg_addWindowOnTarget:(nonnull id)target onClick:(nullable void(^)(void))callback;
/* you can resize the view's size, 50 by default if you don't set it */
+ (void)wg_setWindowSize:(float)size;
/* you can hide the view or show it again */
+ (void)wg_setHideWindow:(BOOL)hide;
/* you can reset the button's background image of normal and selected states */
+ (void)wg_setBackgroundImage:(nullable NSString *)imageName forState:(UIControlState)UIControlState;

@end
