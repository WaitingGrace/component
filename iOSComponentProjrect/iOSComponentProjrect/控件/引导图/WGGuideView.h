//
//  WGGuideView.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/4/4.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WGGuideView : UIView


+ (void)showGudieView:(NSArray *)imageArray;

//跳过引导(用在退出登陆时清理数据后加上这句,防止APP在退出登陆时删除了沙盒中的gudie标志后再次进入引导页)
+ (void)skipGuide;
- (instancetype)init:(NSArray *)imageArray;

@end

NS_ASSUME_NONNULL_END
