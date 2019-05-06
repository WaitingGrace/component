//
//  WGHeaderView.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/6.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGHeaderView.h"
#import "Config.h"

@interface WGHeaderView ()
@property (nonatomic ,strong) UIView * dateStartBaseView;//开始
@property (nonatomic ,strong) UILabel * dateStartLabel;
@property (nonatomic ,strong) UIImageView * startIconImageView;
@property (nonatomic ,strong) UIButton * startBtn;

@property (nonatomic ,strong) UIView * dateEndBaseView;//结束
@property (nonatomic ,strong) UILabel * dateEndLabel;
@property (nonatomic ,strong) UIImageView * endIconImageView;
@property (nonatomic ,strong) UIButton * endBtn;

@property (nonatomic ,strong) UILabel * conditionsLabel;
@property (nonatomic ,strong) UIImageView * conditionsImageView;
@property (nonatomic ,strong) UIButton * typeBtn;

@end
@implementation WGHeaderView

- (void)setStartDate:(NSString *)startDate{
    _startDate = startDate;
    self.dateStartLabel.text = [NSString stringWithFormat:@"%@",startDate];
}
- (void)setEndDate:(NSString *)endDate{
    _endDate = endDate;
    self.dateEndLabel.text = [NSString stringWithFormat:@"%@",endDate];
}
- (void)setType:(NSString *)type{
    _type = type;
    self.conditionsLabel.text = type;
}

#pragma mark ----
#pragma mark ----
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self addSubview:self.dateStartBaseView];
    [self addSubview:self.dateEndBaseView];
    [self addSubview:self.conditionsView];
    CGFloat viewW = ScreenWidth/3;
    [self.dateStartBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(4);
        make.width.mas_equalTo(viewW);
    }];
    [self.dateEndBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.dateStartBaseView.mas_right).offset(8);
        make.top.mas_equalTo(4);
        make.width.mas_equalTo(viewW);
    }];
    [self.conditionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-16);
        make.width.mas_equalTo(ScreenWidth/5);
        make.top.mas_equalTo(4);
    }];
    
}

#pragma mark ----
#pragma mark ---- 按钮点击方法
- (void)selectionFilter:(UIButton *)sender{
    if (self.selectionFilter) {
        self.selectionFilter(sender.tag - 100);
    }
}
#pragma mark ----
#pragma mark ---- 懒加载
- (UILabel *)dateStartLabel{
    if (_dateStartLabel == nil) {
        _dateStartLabel = [[UILabel alloc]init];
        _dateStartLabel.font = FONT(iPhone4_5?13:(iPhone6?14:15));
        _dateStartLabel.textColor = TitleColor;
        _dateStartLabel.textAlignment = NSTextAlignmentCenter;
        _dateStartLabel.text = String(@"xxxx-xx-xx");
    }
    return _dateStartLabel;
}
- (UIImageView *)startIconImageView{
    if (_startIconImageView == nil) {
        _startIconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_date_interval"]];
    }
    return _startIconImageView;
}
- (UIButton *)startBtn{
    if (_startBtn == nil) {
        _startBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _startBtn.tag = 100;
        [_startBtn setBackgroundColor:[UIColor clearColor]];
        [_startBtn addTarget:self action:@selector(selectionFilter:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _startBtn;
}
- (UIView *)dateStartBaseView{
    if (_dateStartBaseView == nil) {
        _dateStartBaseView = [[UIView alloc]init];
        _dateStartBaseView.backgroundColor = RGB(242, 243, 244);
        _dateStartBaseView.layer.cornerRadius = 4.f;
        _dateStartBaseView.clipsToBounds = YES;
        [_dateStartBaseView addSubview:self.dateStartLabel];
        [_dateStartBaseView addSubview:self.startIconImageView];
        [_dateStartBaseView addSubview:self.startBtn];
        [self.startIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        [self.dateStartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(self.startIconImageView.mas_left).offset(-8);
        }];
        [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return _dateStartBaseView;
}

- (UILabel *)dateEndLabel{
    if (_dateEndLabel == nil) {
        _dateEndLabel = [[UILabel alloc]init];
        _dateEndLabel.font = FONT(iPhone4_5?13:(iPhone6?14:15));
        _dateEndLabel.textColor = TitleColor;
        _dateEndLabel.textAlignment = NSTextAlignmentCenter;
        _dateEndLabel.text = String(@"xxxx-xx-xx");
    }
    return _dateEndLabel;
}
- (UIImageView *)endIconImageView{
    if (_endIconImageView == nil) {
        _endIconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_date_interval"]];
    }
    return _endIconImageView;
}
-(UIButton *)endBtn{
    if (_endBtn == nil) {
        _endBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_endBtn setBackgroundColor:[UIColor clearColor]];
        _endBtn.tag = 101;
        [_endBtn addTarget:self action:@selector(selectionFilter:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _endBtn;
}
- (UIView *)dateEndBaseView{
    if (_dateEndBaseView == nil) {
        _dateEndBaseView = [[UIView alloc]init];
        _dateEndBaseView.backgroundColor = RGB(242, 243, 244);
        _dateEndBaseView.layer.cornerRadius = 4.f;
        _dateEndBaseView.clipsToBounds = YES;
        [_dateEndBaseView addSubview:self.dateEndLabel];
        [_dateEndBaseView addSubview:self.endIconImageView];
        [_dateEndBaseView addSubview:self.endBtn];
        [self.endIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        [self.dateEndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(self.endIconImageView.mas_left).offset(-8);
        }];
        [self.endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return _dateEndBaseView;
}

- (UILabel *)conditionsLabel{
    if (_conditionsLabel == nil) {
        _conditionsLabel = [[UILabel alloc]init];
        _conditionsLabel.font = FONT(iPhone4_5?15:(iPhone6?16:17));
        _conditionsLabel.textColor = TitleColor;
        _conditionsLabel.textAlignment = NSTextAlignmentCenter;
        _conditionsLabel.text = String(@"长嘱");
    }
    return _conditionsLabel;
}
- (UIImageView *)conditionsImageView{
    if (_conditionsImageView == nil) {
        _conditionsImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_down_full"]];
    }
    return _conditionsImageView;
}
- (UIButton *)typeBtn{
    if (_typeBtn == nil) {
        _typeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_typeBtn setBackgroundColor:[UIColor clearColor]];
        _typeBtn.tag = 102;
        [_typeBtn addTarget:self action:@selector(selectionFilter:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _typeBtn;
}
- (UIView *)conditionsView{
    if (_conditionsView == nil) {
        _conditionsView = [[UIView alloc]init];
        _conditionsView.backgroundColor = RGB(242, 243, 244);
        [_conditionsView addSubview:self.conditionsLabel];
        [_conditionsView addSubview:self.conditionsImageView];
        [_conditionsView addSubview:self.typeBtn];
        [self.conditionsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.centerX.mas_equalTo(-10);
        }];
        [self.conditionsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-8);
            make.size.mas_equalTo(CGSizeMake(12, 12));
        }];
        [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return _conditionsView;
}


@end
