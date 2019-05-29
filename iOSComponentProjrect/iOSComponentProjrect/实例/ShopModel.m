//
//  ShopModel.m
//  CustomWaterFlow
//
//  Created by DYS on 15/12/12.
//  Copyright © 2015年 DYS. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)shopWithDict:(NSDictionary *)dict
{
    
    return [[self alloc]initWithDict:dict];
    
}

@end
