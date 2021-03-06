//
//  NSString+Size.m
//  Field
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
 
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    
}
@end
