//
//  NSString+WGFrame.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/30.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface NSString (WGFrame)


/**
 获取字段高度
 
 @param font 字体大小
 @param width 容器宽度
 @return 字段高度
 */
- (float) heightWithFont: (UIFont *) font withinWidth: (float) width;

/**
 获取字段宽度
 
 @param font 字体大小
 @return 字段宽度
 */
- (float) widthWithFont: (UIFont *) font;



/**
 获取多行文字中n行的range
 
 @param string 字符串
 @param width 宽度
 @param lines 获取的行数
 @param test 测试文字（汉字、英文，为了获取单行文字高度）
 @return range
 */
+ (NSRange)getTextRangeWith:(NSString *)string Width:(CGFloat)width lines:(CGFloat)lines Test:(NSString *)test;

@end
