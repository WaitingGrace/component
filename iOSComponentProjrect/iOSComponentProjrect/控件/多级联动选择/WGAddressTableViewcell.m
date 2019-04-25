//
//  WGAddressTableViewcell.m
//  IMHJM
//
//  Created by 帅棋 on 2018/7/9.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import "WGAddressTableViewcell.h"
#import "Config.h"
#import "WGAddressModel.h"

static  CGFloat  const  WGFontH = 22; //地址字体高度限制
@interface WGAddressTableViewcell ()
@property (strong, nonatomic) UILabel       *addressNameLabel;    // 地址名称
@property (strong, nonatomic) UIImageView   *selectFlagImageView; // 选中标志
@end
@implementation WGAddressTableViewcell

- (UILabel *)addressNameLabel {
    if (!_addressNameLabel) {
        _addressNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, WGFontH)];
        _addressNameLabel.font = FONT(iPhonePlus_X?16:(iPhone6?15:14));
        _addressNameLabel.textColor = [UIColor blackColor];
    }
    return _addressNameLabel;
}

- (UIImageView *)selectFlagImageView {
    if (!_selectFlagImageView) {
        _selectFlagImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_check"]];
        _selectFlagImageView.frame = CGRectMake(CGRectGetMaxX(self.addressNameLabel.frame) + 5, 14.5, 15, 15);
        _selectFlagImageView.hidden = YES;
    }
    return _selectFlagImageView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.addressNameLabel];
        [self addSubview:self.selectFlagImageView];
    }
    return self;
}

- (void)setModel:(WGAddressModel *)model{
    _model = model;
    _addressNameLabel.text = model.name;
    CGFloat fontW = [model.name widthWithFont:FONT(iPhonePlus_X?16:(iPhone6?15:14))];
    _addressNameLabel.frame = CGRectMake(20, 10, fontW, WGFontH);
    _addressNameLabel.textColor = model.isSelected ? RGB(255, 85, 0) : [UIColor blackColor];
    _selectFlagImageView.hidden = !model.isSelected;
    _selectFlagImageView.frame = CGRectMake(CGRectGetMaxX(_addressNameLabel.frame) + 5, 14.5, 15, 15);
}




- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
