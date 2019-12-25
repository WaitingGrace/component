//
//  WGCollectionViewCell.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/11/7.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGCollectionViewCell.h"

@implementation WGCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor purpleColor];
        self.contentView.layer.cornerRadius = 15;
        
        _lbOperation = [UILabel new];
        _lbOperation.textColor = [UIColor whiteColor];
        _lbOperation.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lbOperation];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _lbOperation.frame = CGRectMake(0, 0, 80, 30);
}
@end
