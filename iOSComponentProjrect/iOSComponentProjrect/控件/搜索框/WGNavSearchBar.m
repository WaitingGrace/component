//
//  WGNavSearchBar.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/3/27.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGNavSearchBar.h"
#import <objc/runtime.h>

@interface WGNavSearchBar ()
@property (nonatomic, strong) UIImageView *leftView;

@end
@implementation WGNavSearchBar

-(void)setTextString:(NSString *)textString{
    _textString = textString;
    self.placeholder = textString;
}

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text textFieldLeftView:(UIImageView *)leftView showCancelButton:(BOOL)showCancelButton tintColor:(UIColor *)tintColor textColor:(UIColor *)textColor font:(UIFont *)font backgroundColor:(UIColor *)backColor{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.tintColor = tintColor; //光标颜色
        self.barTintColor = [UIColor whiteColor];
        self.placeholder = placeholder;
        self.text = text;
        self.showsCancelButton = showCancelButton;
        self.leftView = leftView; // 用来代替左边的放大镜
        if ([[UIDevice currentDevice] systemVersion].doubleValue >= 11.0) {
            [[self.heightAnchor constraintEqualToConstant:44.0] setActive:YES];
        } else {
            [self setLeftPlaceholder];
        }
        [self setLayoutSearchFieldFont:font textColor:textColor backgroundColor:backColor];
    }
    return self;
}

- (void)setLeftPlaceholder {
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        BOOL centeredPlaceholder = NO;
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&centeredPlaceholder atIndex:2];
        [invocation invoke];
    }
}

- (void)setLayoutSearchFieldFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backColor{
    UITextField *searchField = [self valueForKey:@"searchField"];
    searchField.backgroundColor = backColor;
    searchField.textColor = textColor;
    searchField.font = font;
    searchField.leftView = self.leftView;
    if (@available(iOS 11.0, *)) {
        // 查看视图层级，在iOS 11之前searchbar的x是12
        searchField.frame = CGRectMake(12, 8, ScreenWidth*0.8, 28);
        
    } else {
        searchField.frame = CGRectMake(0, 8, ScreenWidth*0.8, 28);
    }
    searchField.borderStyle = UITextBorderStyleNone;
    searchField.layer.cornerRadius = 5;
    searchField.layer.masksToBounds = YES;
    [searchField setValue:textColor forKeyPath:@"placeholderLabel.textColor"];
    [self setValue:searchField forKey:@"searchField"];
    self.searchTextPositionAdjustment = (UIOffset){10, 0}; // 光标偏移量
}

@end
