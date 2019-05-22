//
//  WGTimerPicker.h
//  WGTimerPicker
//
//  Created by shuaiqi on 2018/11/19.
//  Copyright © 2018年 WaitingGrace. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReturnBlock)(NSString *selectedStr);

@interface WGTimerPicker : UIView


/**
 初始化时间选择

 @param days 预约的天数
 @param timeInterval 时间间隔
 @param benginTimeDely 数据源的开始时间是当前时间的kBenginTimeDely分钟 并且向上取整
 @param block 回调block 参数即是选择的日期
 @return 时间选择器实例
 */
- (instancetype)initWithDays:(NSInteger)days timeInterval:(NSInteger)timeInterval BenginTimeDely:(NSInteger)benginTimeDely Response:(ReturnBlock)block ;

/**
 初始化时间选择
 
 @param superView 时间选择器的父View，若为空，将时间选择器加载在window上面
 @param days 预约的天数
 @param timeInterval 时间间隔
 @param benginTimeDely 数据源的开始时间是当前时间的kBenginTimeDely分钟 并且向上取整
 @param block 回调block 参数即是选择的日期
 @return 时间选择器实例
 */
- (instancetype)initWithSuperView:(UIView *)superView WithDays:(NSInteger)days timeInterval:(NSInteger)timeInterval BenginTimeDely:(NSInteger)benginTimeDely response:(ReturnBlock)block ;


/**
 pickerView 出现
 */
- (void)show ;

/**
 pickerView 消失
 */
- (void)dismiss;
@end
