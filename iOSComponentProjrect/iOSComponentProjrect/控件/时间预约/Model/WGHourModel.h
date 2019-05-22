//
//  WGHourModel.h
//  WGTimerPicker
//
//  Created by shuaiqi on 2018/11/19.
//  Copyright © 2018年 WaitingGrace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGHourModel : NSObject

/// 实际小时
@property (nonatomic, copy) NSString *hourString;

/// 展示的小时
@property (nonatomic, copy) NSString *showHourString;
@end
