//
//  WGUtil.h
//  WGTimerPicker
//
//  Created by shuaiqi on 2018/11/19.
//  Copyright © 2018年 WaitingGrace. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WGTimerDataSourceModel;

@interface WGTimerUtil : NSObject

/**
 获取pickerView数据源

 @param kDays 预约的天数
 @param kTimeInterval 时间间隔
 @param kBenginTimeDely 数据源的开始时间是当前时间的kBenginTimeDely分钟 并且向上取整
 @return pickerView数据源
 */
+ (WGTimerDataSourceModel *)configDataSource:(NSInteger)kDays
                                TimeInterval:(NSInteger)kTimeInterval
                              BenginTimeDely:(NSInteger)kBenginTimeDely;

@end
