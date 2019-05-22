//
//  WGDateModel.h
//  WGTimerPicker
//
//  Created by shuaiqi on 2018/11/19.
//  Copyright © 2018年 WaitingGrace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGDateModel : NSObject

/// 实际日期
@property (nonatomic, copy) NSString *dateString;

/// 展示的日期
@property (nonatomic, copy) NSString *showDateString;

@end

