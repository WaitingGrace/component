//
//  UILabel+GHome.h
//  Field
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (GHome)
@property (nonatomic , assign) CGFloat width;
@property (nonatomic , strong) NSTextAttachment *attach;

/**
 计算文本的高度

 @param text 传入的内容
 @param font 内容字号
 @param maxWidth 最大宽度
 */
- (CGFloat)adaptWithText: (NSString *)text
                 font: (UIFont *)font
             maxWidth: (CGFloat)maxWidth;

- (void)adaptWithText:(NSString *)text
                frame:(CGRect)frame
                 font:(UIFont *)font;


/**
 计算文本的宽度
 
 @param text 传入的内容
 @param font 内容字号
 @param imageName 显示图片
 @param maxWidth 最大宽度
 
 */
- (void)creatRichTextWithText: (NSString *)text
                        frame: (CGRect)frame
                         font: (UIFont *)font
                    imageName: (NSString *)imageName
                     maxWidth: (CGFloat)maxWidth;

@end

NS_ASSUME_NONNULL_END
