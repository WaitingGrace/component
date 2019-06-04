//
//  WGBirthdayModel.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGBirthdayFriendsItem.h"

typedef NS_ENUM(NSUInteger, WGBirthdayLayerType) {
    WGBirthdayLayerTypeUnknown,
    WGBirthdayLayerTypeForA,   // A类用户生日弹层逻辑
    WGBirthdayLayerTypeForB   // B类用户生日弹层逻辑
};

@interface WGBirthdayModel : NSObject

@property (nonatomic, strong) NSString *birthdayEventId;
@property (nonatomic, strong) NSString *birthdayJumpLinkUrl;
@property (nonatomic, strong) NSString *birthdayLayerName;
@property (nonatomic, strong) NSString *birthdayLayerDesc;
@property (nonatomic, assign) WGBirthdayLayerType birthdayLayerType;
@property (nonatomic, strong) NSMutableArray <WGBirthdayFriendsItem *>*friendsBirthdayInfo; // 最多三个

@end
