//
//  WGAddressModel.m
//  IMHJM
//
//  Created by 帅棋 on 2018/7/9.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import "WGAddressModel.h"

@implementation WGAddressModel
+ (instancetype)addressModelWithDictionary:(NSDictionary *)info{
    return [[self alloc]initWithDictionary:info];
}
- (instancetype)initWithDictionary:(NSDictionary *)info{
    if (self = [super init]) {
        self.code = [NSString stringWithFormat:@"%@",info[kSite_Code]];
        self.ID = [NSString stringWithFormat:@"%@",info[kSite_Id]];
        self.name = info[kSite_Name];
        self.seq = info[kSite_seq];
        self.level = [NSString stringWithFormat:@"%@",info[kSite_Level]];
    }
    return self;
}

@end
