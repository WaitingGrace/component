//
//  WGDraggableConfig.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#ifndef WGDraggableConfig_h
#define WGDraggableConfig_h

//  -------------------------------------------------
//  MARK: 拽到方向枚举
//  -------------------------------------------------
typedef NS_OPTIONS(NSInteger, WGDraggableDirection) {
    WGDraggableDirectionDefault     = 0,
    WGDraggableDirectionLeft        = 1 << 0,
    WGDraggableDirectionRight       = 1 << 1
};

typedef NS_OPTIONS(NSInteger, WGDraggableStyle) {
    WGDraggableStyleUpOverlay   = 0,
    WGDraggableStyleDownOverlay = 1
};

static const CGFloat kBoundaryRatio = 0.5f;
// static const CGFloat kSecondCardScale = 0.98f;
// static const CGFloat kTherdCardScale  = 0.96f;
static const CGFloat kFirstCardScale  = 1.08f;
static const CGFloat kSecondCardScale = 1.04f;

static const CGFloat kCardEdage = 10.0f;
static const CGFloat kContainerEdage = 30.0f;
static const CGFloat kNavigationHeight = 64.0f;
static const CGFloat kVisibleCount = 3;

#endif /* WGDraggableConfig_h */
