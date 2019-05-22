//
//  WGSuspendItem.m
//
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import "WGSuspendItem.h"
@interface WGSuspendItem()
@end
@implementation WGSuspendItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    [self addSubview:self.title];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.frame = CGRectMake(10, 0, self.frame.size.width, self.frame.size.height);
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
    }
    return _title;
}
@end
