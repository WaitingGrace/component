//
//  NSArray+GH.m
//  Field
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import "NSArray+Bounds.h"

@implementation NSArray (Bounds)

- (id)by_ObjectAtIndex:(NSUInteger)index {
    if (self.count > index) {
        return [self objectAtIndex:index];
    } else {
        return nil;
    }
}
@end
