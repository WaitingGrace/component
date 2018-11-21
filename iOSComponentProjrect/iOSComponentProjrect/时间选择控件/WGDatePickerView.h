//
//  WGDatePickerView.h
//
//  Created by WG on 17/2/23.
//  Copyright © 2017年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+Extension.h"

typedef enum{
    DateStyleShowYearMonthDayHourMinute  = 0,
    DateStyleShowMonthDayHourMinute,
    DateStyleShowYearMonthDay,
    DateStyleShowMonthDay,
    DateStyleShowHourMinute
    
}WGDateStyle;


@interface WGDatePickerView : UIView

@property (nonatomic,strong)UIColor *doneButtonColor;//按钮颜色

@property (nonatomic, retain) NSDate *maxLimitDate;//限制最大时间（没有设置默认9999）
@property (nonatomic, retain) NSDate *minLimitDate;//限制最小时间（没有设置默认1970）
@property (nonatomic, retain) NSDate *currentDate;//当前时间 （默认 今天）

-(instancetype)initWithDateStyle:(WGDateStyle)datePickerStyle CompleteBlock:(void(^)(NSDate *))completeBlock;

-(void)show;


@end

