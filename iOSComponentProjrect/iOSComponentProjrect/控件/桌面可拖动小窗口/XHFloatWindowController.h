//
//  XHFloatWindowController.h
//  XHFloatingWindow
//
//  Created by 帅棋 on 2018/11/26.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XHDraggableButton;
@interface XHFloatWindowController : UIViewController

- (void)setRootView;
- (void)setHideWindow:(BOOL)hide;
- (void)setWindowSize:(float)size; // 50 by default
- (void)resetBackgroundImage: (NSString *)imageName forState:(UIControlState)UIControlState;

@end
