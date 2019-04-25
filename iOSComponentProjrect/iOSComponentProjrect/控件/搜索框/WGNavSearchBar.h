//
//  WGNavSearchBar.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/3/27.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WGNavSearchBar : UISearchBar
@property (nonatomic ,copy) NSString * textString;

/**
 初始化方法
 
 @param frame frame
 @param placeholder placeholder
 @param text 当前内容
 @param leftView textField的leftView
 @param showCancelButton 是否显示取消按钮
 @param tintColor 光标颜色
 @param textColor 文字颜色
 @param font 字体大小
 @param backColor 背景颜色
 */
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text textFieldLeftView:(UIImageView *)leftView showCancelButton:(BOOL)showCancelButton tintColor:(UIColor *)tintColor textColor:(UIColor *)textColor font:(UIFont *)font backgroundColor:(UIColor *)backColor;

/// 让searchBar的内容居左显示
- (void)setLeftPlaceholder;

@end

NS_ASSUME_NONNULL_END
