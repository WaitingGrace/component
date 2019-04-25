//
//  XHDraggableButton.h
//  XHFloatingWindow
//
//  Created by 帅棋 on 2018/11/26.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * to avoid event collision between button click and pan,here touch event is adopted 
 * to deal with both click and pan event
 */
@protocol UIDragButtonDelegate <NSObject>

- (void)dragButtonClicked:(UIButton *)sender;

@end

@interface XHDraggableButton : UIButton

@property (nonatomic, strong)UIView *rootView;
@property (nonatomic, weak)id<UIDragButtonDelegate>buttonDelegate;
@property (nonatomic, assign)UIInterfaceOrientation initOrientation;
@property (nonatomic, assign)CGAffineTransform originTransform;

- (void)buttonRotate;

@end
