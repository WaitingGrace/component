//
//  WGDropMenuTitleItem.h
//  
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WGDropMenuModel,WGDropMenuTitleItem;

@protocol WGDropMenuTitleItemDelegate <NSObject>
/**
 WGDropMenuTitleItem 代理回调方法

 @param item WGDropMenuTitleItem
 @param dropMenuModel WGDropMenuModel
 
 */
- (void)dropMenuTitleItem: (WGDropMenuTitleItem *_Nullable)item
            dropMenuModel: (WGDropMenuModel *_Nullable)dropMenuModel;

@end

NS_ASSUME_NONNULL_BEGIN

/**
 筛选菜单 菜单标题cell
 */
@interface WGDropMenuTitleItem : UICollectionViewCell
/**
 模型
 */
@property (nonatomic , strong) WGDropMenuModel *dropMenuModel;
/**
 代理
 */
@property (nonatomic , weak) id <WGDropMenuTitleItemDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
