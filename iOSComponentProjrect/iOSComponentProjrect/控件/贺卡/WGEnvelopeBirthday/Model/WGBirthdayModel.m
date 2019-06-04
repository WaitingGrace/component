//
//  WGBirthdayModel.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "WGBirthdayModel.h"

@implementation WGBirthdayModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.friendsBirthdayInfo = [NSMutableArray array];
    }
    return self;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"friendsBirthdayInfo" : [WGBirthdayFriendsItem class]};
}

@end
