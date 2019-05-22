//
//  WGFloatWindowController.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGDraggableButton;
@interface WGFloatWindowController : UIViewController

- (void)setRootView;
- (void)setHideWindow:(BOOL)hide;
- (void)setWindowSize:(float)size; // 50 by default
- (void)resetBackgroundImage: (NSString *)imageName forState:(UIControlState)UIControlState;

@end
