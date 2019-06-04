//
//  WGBirthdayFriendsItem.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGBirthdayFriendsItem : NSObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isMore; // 是否是省略cell 默认是NO

@end
