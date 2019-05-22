//
//  HYViewController.h
//
//  Created by 帅棋 on 2018/11/22.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, WGHidenControlOptions) {

    WGHidenControlOptionLeft = 0x01,
    WGHidenControlOptionTitle = 0x01 << 1,
    WGHidenControlOptionRight = 0x01 << 2,
    
};

@interface WGHiddenViewController : UIViewController

- (void)setKeyScrollView:(UIScrollView * )keyScrollView scrolOffsetY:(CGFloat)scrolOffsetY options:(WGHidenControlOptions)options;

@end
