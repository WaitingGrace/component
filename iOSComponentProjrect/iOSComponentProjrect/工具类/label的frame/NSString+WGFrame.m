//
//  NSString+WGFrame.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/30.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "NSString+WGFrame.h"

@implementation NSString (WGFrame)

//计算文本高度
- (float) heightWithFont: (UIFont *) font withinWidth: (float) width{
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    
    
    return ceil(textRect.size.height);
}
//计算文本宽度
- (float) widthWithFont: (UIFont *) font
{
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, font.pointSize)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    
    return textRect.size.width;
}


/**
 获取多行文字中n行的range
 
 @param string 字符串
 @param width 宽度
 @param lines 获取的行数
 @param test 测试文字（汉字、英文，为了获取单行文字高度）
 @return range
 */

+ (NSRange)getTextRangeWith:(NSString *)string Width:(CGFloat)width lines:(CGFloat)lines Test:(NSString *)test{
    UIFont * font = FONT(iPhone4_5?14:(iPhone6?15:16));
    CGFloat testH = [test heightWithFont:font withinWidth:width] * lines;
    NSMutableDictionary * attributes = [NSMutableDictionary dictionaryWithCapacity:10];
    [attributes setValue:font forKey:NSFontAttributeName];
    NSAttributedString * attributedString = [[NSAttributedString alloc] initWithString:string/*需要分页的字符串*/ attributes:attributes];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) attributedString);
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, testH)];
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), bezierPath.CGPath, NULL);
    CFRange range = CTFrameGetVisibleStringRange(frame);
    CFRelease(frame);
    CFRelease(framesetter);
    NSRange rg = NSMakeRange(range.location, range.length);
    return rg;
}

@end
