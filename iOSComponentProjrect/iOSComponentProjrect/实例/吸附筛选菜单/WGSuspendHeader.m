//
//  WGSuspendHeader.m
//
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import "WGSuspendHeader.h"

@implementation WGSuspendHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)changeY:(CGFloat)y {
    self.frame = CGRectMake(0, y, self.frame.size.width, self.frame.size.height);
}
@end
