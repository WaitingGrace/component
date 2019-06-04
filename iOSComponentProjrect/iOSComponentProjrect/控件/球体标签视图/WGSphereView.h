//
//  WGSphereView.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/29.
//  Copyright © 2019 WG. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface WGSphereView : UIView

@property(nonatomic,assign) BOOL isTimerStart;

- (void)setItems:(NSArray *)items;

- (void)timerStart;

- (void)timerStop;


@end
