//
//  WGSearchBar.m
//
//  Created by 帅棋 on 2018/6/13.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import "WGSearchBar.h"

@interface WGSearchBar () <UITextFieldDelegate>
{
    CGFloat searchIconW;
    CGFloat iconSpacing;
    CGFloat placeHolderFont;
}
// placeholder 和icon 和 间隙的整体宽度
@property (nonatomic, assign) CGFloat placeholderWidth;

@end
@implementation WGSearchBar

- (void)setBackColor:(UIColor *)backColor{
    _backColor = backColor;
    UIImage *backImage = [self GetImageWithColor:backColor andHeight:iPad?55:45];
    [self setBackgroundImage:backImage];
}
- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    UIView * searchTextField = [[[self.subviews firstObject] subviews] lastObject];
    searchTextField.layer.cornerRadius = iPad?20.f:15.f;
    searchTextField.clipsToBounds = YES;
    searchTextField.layer.borderWidth = 1.f;
    searchTextField.layer.borderColor = BASEColor.CGColor;
}
- (instancetype)init{
    if (self = [super init]) {
        searchIconW = iPad ? 25:20;
        iconSpacing = iPad ? 15:10;
        placeHolderFont = iPad ? 20:15;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    // 设置背景图片
    UIImage *backImage = [self GetImageWithColor:[UIColor clearColor] andHeight:iPad?55:45];
    [self setBackgroundImage:backImage];
    for (UIView *view in [self.subviews lastObject].subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *field = (UITextField *)view;
            // 重设field的frame
            [field setBackgroundColor:[UIColor whiteColor]];
            field.textColor = TitleColor;
            field.delegate = self;
            // 设置占位文字字体颜色
            [field setValue:MarkTitleColor forKeyPath:@"_placeholderLabel.textColor"];
            [field setValue:[UIFont systemFontOfSize:placeHolderFont] forKeyPath:@"_placeholderLabel.font"];
            
            if (@available(iOS 11.0, *)) {
                // 先默认居中placeholder
                [self setPositionAdjustment:UIOffsetMake((field.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
            }
        }
    }
}
// 开始编辑的时候重置为靠左
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    // 继续传递代理方法
    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        [self.delegate searchBarShouldBeginEditing:self];
    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetMake(0  , 0) forSearchBarIcon:UISearchBarIconSearch];
    }
}
// 结束编辑的时候设置为居中
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        [self.delegate searchBarShouldEndEditing:self];
    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
    }
}


// 计算placeholder、icon、icon和placeholder间距的总宽度
- (CGFloat)placeholderWidth {
    if (!_placeholderWidth) {
        CGSize size = [self.placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:placeHolderFont]} context:nil].size;
        _placeholderWidth = size.width + iconSpacing + searchIconW;
    }
    return _placeholderWidth;
}

- (UIImage*)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
