//
//  WGDropMenuWaterFallCell.m
//  
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import "WGDropMenuWaterFallCell.h"
#import "WGWaterFallLabel.h"

@interface WGDropMenuWaterFallCell()
@property (nonatomic , strong) WGWaterFallLabel *waterFallLabel;
@property (nonatomic , assign) CGFloat cellHeight;

@end

@implementation WGDropMenuWaterFallCell

- (void)setTags:(NSMutableArray *)tags {
    _tags = tags;
    self.waterFallLabel.tags = tags;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.waterFallLabel];
}
- (CGFloat)getCellHeight  {
    NSLog(@"self.waterFallLabel.frame.size.height%f",self.waterFallLabel.frame.size.height);
    return self.waterFallLabel.frame.size.height;
}
- (void)layoutSubviews {
    [super layoutSubviews];
        
}

- (WGWaterFallLabel *)waterFallLabel {
    if (_waterFallLabel == nil) {
        _waterFallLabel = [[WGWaterFallLabel alloc]init];
        [_waterFallLabel setPoint:CGPointMake(0, 0)];
        _waterFallLabel.backgroundColor = [UIColor redColor];
        _waterFallLabel.textBlock = ^(WGWaterFallLabel * _Nonnull waterFallLabel, NSString * _Nonnull text, NSInteger index) {
            
        };
    }
    return _waterFallLabel;
}
@end
