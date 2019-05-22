//
//  WGWaterFallCell.m
//  
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import "WGWaterFallCell.h"
#import "WGWaterFallLabel.h"
#import "UIView+Extension.h"

@interface WGWaterFallCell()
@property (nonatomic , strong) WGWaterFallLabel *waterFallLabel;
@property (nonatomic , strong) NSMutableArray *dataArray ;

@end
@implementation WGWaterFallCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        if (self.dataArray == nil) {
            self.dataArray = [NSMutableArray array];
            self.dataArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊",@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊",@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊",@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊",@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊",@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊",@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊",@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊",@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊",@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊",@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊",@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊",@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊",@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊",@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊",@"1",@"2",@"3",@"4",@"呵呵啊",@"呵呵啊呵呵啊呵呵啊呵呵啊"]];
        }
    }
    return self;
}
- (CGFloat)getCellHeight {
    CGFloat height = [self.waterFallLabel getHeightWithArray:self.dataArray];
    return height;
}
- (void)setupUI {
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.waterFallLabel];
}


- (WGWaterFallLabel *)waterFallLabel {
    if (_waterFallLabel == nil) {
        _waterFallLabel = [[WGWaterFallLabel alloc]init];
        [_waterFallLabel setPoint:CGPointMake(0, 0)];
        _waterFallLabel.tags =self.dataArray;
        _waterFallLabel.isMultiple = YES;
        _waterFallLabel.heightBlock = ^(CGFloat height) {

        };
        _waterFallLabel.textBlock = ^(WGWaterFallLabel * _Nonnull waterFallLabel, NSString * _Nonnull text, NSInteger index) {

        };

    }
    return _waterFallLabel;
}
@end
