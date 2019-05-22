//
//  WGDropMenuFilterSingleInputItem.m
//
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import "WGDropMenuFilterSingleInputItem.h"
#import "WGDropMenuModel.h"

@interface WGDropMenuFilterSingleInputItem()
@property (nonatomic , strong)UITextField *textField;

@end
@implementation WGDropMenuFilterSingleInputItem

- (void)setDropMenuModel:(WGDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
    self.textField.text = dropMenuModel.singleInput;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        [self configuration];
    }
    return self;
}
- (void)configuration {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.textField];
}

- (void)textChange: (NSNotification *)noti {
    self.dropMenuModel.singleInput = self.textField.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuFilterSingleInputItem:dropMenuModel:)]) {
        [self.delegate dropMenuFilterSingleInputItem:self dropMenuModel:self.dropMenuModel];
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupUI {
    [self addSubview:self.textField];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = (self.frame.size.width - 2 * 10 - 10) / 2;
    self.textField.frame = CGRectMake(0, 0, width, self.frame.size.height);
    
}
- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc]init];
        _textField.layer.cornerRadius = 10;
        _textField.layer.masksToBounds = YES;
        _textField.layer.borderWidth = 0.5;
        _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.font = [UIFont systemFontOfSize:13];
        _textField.textColor = [UIColor darkGrayColor];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.tintColor = [UIColor orangeColor];
        _textField.placeholder = @"请输入";
    }
    return _textField;
}

@end
