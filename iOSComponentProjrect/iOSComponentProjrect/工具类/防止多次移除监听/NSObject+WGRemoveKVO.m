//
//  NSObject+WGRemoveKVO.m
//  MCSH
//
//  Created by 帅棋 on 2018/11/26.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "NSObject+WGRemoveKVO.h"
#import <objc/runtime.h>
@implementation NSObject (WGRemoveKVO)
+ (void)load{
    [self switchMethod];
}

// 交换后的方法
- (void)removeDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath{
    @try {
        [self removeDasen:observer forKeyPath:keyPath];
    } @catch (NSException *exception) {}
}

+ (void)switchMethod{
    SEL removeSel = @selector(removeObserver:forKeyPath:);
    SEL myRemoveSel = @selector(removeDasen:forKeyPath:);
    
    Method systemRemoveMethod = class_getClassMethod([self class],removeSel);
    Method DasenRemoveMethod = class_getClassMethod([self class], myRemoveSel);
    
    method_exchangeImplementations(systemRemoveMethod, DasenRemoveMethod);
}

@end
