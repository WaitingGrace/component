//
//  WGPopMenuItem.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGPopMenuItem : UIButton

@property (nonatomic, copy) NSMutableDictionary *attrDic;

/**
 *  播放选择动画
 */
- (void)playSelectAnimation;

/**
 *  播放取消选择动画
 */
- (void)playCancelAnimation;
@end
