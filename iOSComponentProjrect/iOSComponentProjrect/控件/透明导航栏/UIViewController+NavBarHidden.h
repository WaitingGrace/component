//
//  UIViewController+scrollerHidden.h
//
//  Created by 帅棋 on 2018/11/22.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSUInteger, HYHidenControlOptions) {
    
    HYHidenControlOptionLeft = 0x01,
    HYHidenControlOptionTitle = 0x01 << 1,
    HYHidenControlOptionRight = 0x01 << 2,
    
};

@interface UIViewController (NavBarHidden)
/**
 *  @param keyScrollView 需要监听的view
 *  @param scrolOffsetY  ScrollView的Y轴偏移量大于scrolOffsetY的距离后,导航条的alpha为1
 *  @param options       设置导航条上的标签是否需要跟随滚动变化透明度,默认不会跟随滚动变化透明度
 */
- (void)setKeyScrollView:(UIScrollView * )keyScrollView scrolOffsetY:(CGFloat)scrolOffsetY options:(HYHidenControlOptions)options;
/**
 *
 *  @param navBarBackgroundImage 导航条的背景图片
 */
- (void)setNavBarBackgroundImage:(UIImage *)navBarBackgroundImage;
/** 清除默认导航条的背景设置 */
- (void)setInViewWillAppear;
- (void)setInViewWillDisappear;
@end
