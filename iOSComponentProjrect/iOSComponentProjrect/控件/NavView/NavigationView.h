//
//  NavigationView.h
//  YHWK
//
//  Created by 新益华 on 2017/5/9.
//  Copyright © 2017年 新益华. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NavigationView : UIView

@property (weak, nonatomic) IBOutlet UIButton *backItem;
@property (weak, nonatomic) IBOutlet UIButton *contentItem;
@property (weak, nonatomic) IBOutlet UIButton *detailItem;

@property (nonatomic ,strong) void (^webViewClose)(void);
@property (nonatomic ,strong) void (^backItemClick)(void);
@property (nonatomic ,strong) void (^contentItemClick)(void);
@property (nonatomic ,strong) void (^detailItemClick)(void);
@property (nonatomic ,copy) NSString * counttitle;
@property (nonatomic ,copy) NSString * contentImage;
@property (nonatomic ,copy) NSString * backImage;
@property (nonatomic ,copy) NSDictionary * backTitleInfo;
@property (nonatomic ,copy) NSString * titleText;

/**
 初始化自定义导航栏

 @return 导航栏
 */
+ (instancetype)createdNavigationView;

/**
 导航栏设置

 @param titleInfo 标题信息{ @"title":,
                           @"color":,
                           @"font": }
 @param backItemInfo 返回按钮信息{ @"image":,
                                 @"height":,
                                 @"width":}
 @param contentitemInfo 右边导航栏按钮信息{ @"image":,
                                          @"height":,
                                          @"width":}
 @param isHidden 右边导航栏按钮是否隐藏
 */
- (void)setInitNavigationviewWith:(NSDictionary *)titleInfo
                         backItem:(NSDictionary *)backItemInfo
                      contentitem:(NSDictionary *)contentitemInfo
                         isHidden:(BOOL)isHidden;

- (void)setInitNavigationviewWith:(NSDictionary *)titleInfo
                         backItem:(NSDictionary *)backItemInfo
                      contentitem:(NSDictionary *)contentitemInfo detailItem:(NSDictionary *)detailItemInfo
                         isHidden:(BOOL)isHidden;


@end
