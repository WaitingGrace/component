//
//  WGDraggableCardView.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WGDraggableConfig.h"

@interface WGDraggableCardView : UIView

@property (nonatomic) CGAffineTransform originalTransform;

- (void)wg_layoutSubviews;

@end
