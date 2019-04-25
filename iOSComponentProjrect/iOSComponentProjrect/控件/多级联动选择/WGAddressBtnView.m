//
//  WGAddressBtnView.m
//  IMHJM
//
//  Created by 帅棋 on 2018/7/10.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import "WGAddressBtnView.h"
#import "Config.h"

static  CGFloat  const  WGBarItemMargin = 20;
@interface WGAddressBtnView ()
@property (nonatomic,strong) NSMutableArray * btnArray;
@end
@implementation WGAddressBtnView
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (NSInteger i = 0; i <= self.btnArray.count - 1 ; i++) {
        UIView * view = self.btnArray[i];
        if (i == 0) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(WGBarItemMargin);
                make.centerY.mas_equalTo(0);
            }];
        }
        if (i > 0) {
            UIView * preView = self.btnArray[i - 1];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(preView.mas_right).offset(WGBarItemMargin);
                make.centerY.mas_equalTo(0);
            }];
        }
    }
}

- (NSMutableArray *)btnArray {
    
    NSMutableArray * mArray  = [NSMutableArray array];
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [mArray addObject:view];
        }
    }
    _btnArray = mArray;
    return _btnArray;
}

@end
