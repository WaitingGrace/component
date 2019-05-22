//
//  NSString+Size.h
//  Field
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
