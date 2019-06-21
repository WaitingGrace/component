//
//  WGDraggableContainer.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WGDraggableConfig.h"
#import "WGDraggableCardView.h"

@class WGDraggableContainer;

//  -------------------------------------------------
//  MARK: Delegate
//  -------------------------------------------------

@protocol WGDraggableContainerDelegate <NSObject>

- (void)draggableContainer:(WGDraggableContainer *)draggableContainer
        draggableDirection:(WGDraggableDirection)draggableDirection
                widthRatio:(CGFloat)widthRatio
               heightRatio:(CGFloat)heightRatio;

- (void)draggableContainer:(WGDraggableContainer *)draggableContainer
                  cardView:(WGDraggableCardView *)cardView
            didSelectIndex:(NSInteger)didSelectIndex;

- (void)draggableContainer:(WGDraggableContainer *)draggableContainer
 finishedDraggableLastCard:(BOOL)finishedDraggableLastCard;

@end

//  -------------------------------------------------
//  MARK: DataSource
//  -------------------------------------------------

@protocol WGDraggableContainerDataSource <NSObject>

@required
- (WGDraggableCardView *)draggableContainer:(WGDraggableContainer *)draggableContainer
                               viewForIndex:(NSInteger)index;

- (NSInteger)numberOfIndexs;

@end

//  -------------------------------------------------
//  MARK: CCDraggableContainer
//  -------------------------------------------------

@interface WGDraggableContainer : UIView

@property (nonatomic, strong)  id <WGDraggableContainerDelegate>delegate;
@property (nonatomic, strong)  id <WGDraggableContainerDataSource>dataSource;

@property (nonatomic) WGDraggableStyle     style;
@property (nonatomic) WGDraggableDirection direction;

- (instancetype)initWithFrame:(CGRect)frame style:(WGDraggableStyle)style;
- (void)removeFormDirection:(WGDraggableDirection)direction;
- (void)reloadData;

@end
