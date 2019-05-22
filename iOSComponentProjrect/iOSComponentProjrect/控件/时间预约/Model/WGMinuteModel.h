//
//  WGMinuteModel.h
//  WGTimerPicker
//
//  Created by shuaiqi on 2018/11/19.
//  Copyright © 2018年 WaitingGrace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGMinuteModel : NSObject

/// 实际分钟
@property (nonatomic, copy) NSString *minuteString;

/// 展示的分钟
@property (nonatomic, copy) NSString *showMinuteString;
@end
