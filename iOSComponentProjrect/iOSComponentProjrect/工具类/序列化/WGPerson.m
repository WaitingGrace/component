//
//  WGPerson.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2020/8/14.
//  Copyright © 2020 WG. All rights reserved.
//

#import "WGPerson.h"
#import <objc/message.h>
@implementation WGPerson
- (void)encodeObjectWithCoder:(NSCoder *)coder{
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([WGPerson class], &count);
    for (int i = 0; i < count; i++) {
        const char * value = ivar_getName(ivars[i]);
        NSString * key = [NSString stringWithUTF8String:value];
        [coder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super init]) {
        [self initWithClass:[WGPerson class] Coder:coder];
    }
    return self;
}

- (void)initWithClass:(Class)obj Coder:(NSCoder *)coder{
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([obj class], &count);
    for (int i = 0; i < count; i++) {
        const char * name = ivar_getName(ivars[i]);
        NSString * key = [NSString stringWithUTF8String:name];
        id value = [coder decodeObjectForKey:key];
        [obj setValue:value forKey:key];
    }
    free(ivars);
}

@end
