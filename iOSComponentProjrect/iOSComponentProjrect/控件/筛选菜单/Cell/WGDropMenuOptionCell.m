//
//  WGDropMenuOptionCell.m
//  
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import "WGDropMenuOptionCell.h"
#import "WGDropMenuModel.h"

@interface WGDropMenuOptionCell()

@property (nonatomic , strong) UILabel *title;
@property (nonatomic , strong) UIView *line;
@property (nonatomic , strong) UIImageView *imgView;

@end
@implementation WGDropMenuOptionCell

- (void)setDropMenuModel:(WGDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
    self.title.text = dropMenuModel.title;
    self.title.textColor = dropMenuModel.cellSeleted ? dropMenuModel.optionSeletedColor:dropMenuModel.optionNormalColor;
    self.imgView.hidden = !dropMenuModel.cellSeleted;
    self.title.font = dropMenuModel.optionFont > 0 ?dropMenuModel.optionFont :[UIFont systemFontOfSize:15];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    [self addSubview:self.title];
    [self addSubview:self.line];
    [self addSubview:self.imgView];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.line.frame = CGRectMake(20, self.frame.size.height - 1, self.frame.size.width - 40, 1);
    self.imgView.frame = CGRectMake(self.frame.size.width - 20 - 15, (self.frame.size.height - 15 ) * 0.5, 15, 15);
    self.title.frame = CGRectMake(20, 0, 300, self.frame.size.height);

}
- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = [UIImage imageNamed:@"check_selected"];
        _imgView.hidden = YES;
    }
    return _imgView;
}
- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor darkGrayColor];
        _line.alpha = .1;
    }
    return _line;
}
- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.font = [UIFont systemFontOfSize:13];
    }
    return _title;
}


@end
