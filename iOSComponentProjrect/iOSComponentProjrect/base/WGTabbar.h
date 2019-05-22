//
//  WGTabbar.h
//
//  Created by 帅棋 on 2018/11/23.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGTabbar;

@protocol WGTabBarDelegate <NSObject>
@optional
- (void)tabBarPlusBtnClick:(WGTabbar *_Nullable)tabBar;
@end

NS_ASSUME_NONNULL_BEGIN

@interface WGTabbar : UITabBar

/** tabbar的代理 */
@property (nonatomic, weak) id<WGTabBarDelegate> myDelegate;

@end

NS_ASSUME_NONNULL_END
