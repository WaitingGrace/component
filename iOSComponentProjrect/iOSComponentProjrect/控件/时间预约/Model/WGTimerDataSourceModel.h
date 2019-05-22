//
//  WGTimerDataSourceModel.h
//  WGTimerPicker
//
//  Created by shuaiqi on 2018/11/19.
//  Copyright © 2018年 WaitingGrace. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - pickerView的数据源
@interface WGTimerDataSourceModel : NSObject

/// 日期数据源
@property (nonatomic, strong) NSMutableArray *dateArray;

/// 小时数据源
@property (nonatomic, strong) NSMutableArray *hourArray;

/// 当天的小时数据源
@property (nonatomic, strong) NSMutableArray *todayHourArray;

/// 分钟数据源
@property (nonatomic, strong) NSMutableArray *minuteArray;

/// 当天的分钟数据源
@property (nonatomic, strong) NSMutableArray *todayMinuteArray;

@end



