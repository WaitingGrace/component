//
//  WGTheModalViewController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/28.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGTheModalViewController.h"
#import "Config.h"
#import "WGProjrectViewController.h"
#import "WGModalTransitionAnimator.h"

@interface WGTheModalViewController ()
@property (nonatomic, strong) WGModalTransitionAnimator *animator;
@property (nonatomic ,strong) UIButton * button1;
@property (nonatomic ,strong) UIButton * button2;
@property (nonatomic ,strong) UIButton * button3;

@end

@implementation WGTheModalViewController

- (UIButton *)button1{
    if (_button1 == nil) {
        _button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_button1 setBackgroundColor:[UIColor clearColor]];
        [_button1 setTitle:@"leftButton" forState:(UIControlStateNormal)];
        [_button1 setTitleColor:BASEColor forState:(UIControlStateNormal)];
        [_button1 addTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _button1;
}
- (UIButton *)button2{
    if (_button2 == nil) {
        _button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_button2 setBackgroundColor:[UIColor clearColor]];
        [_button2 setTitleColor:BASEColor forState:(UIControlStateNormal)];
        [_button2 setTitle:@"rightButton" forState:(UIControlStateNormal)];
        [_button2 addTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _button2;
}
- (UIButton *)button3{
    if (_button3 == nil) {
        _button3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_button3 setBackgroundColor:[UIColor clearColor]];
        [_button3 setTitleColor:BASEColor forState:(UIControlStateNormal)];
        [_button3 setTitle:@"bottomButton" forState:(UIControlStateNormal)];
        [_button3 addTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _button3;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    [self.view addSubview:self.button3];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-100);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(150, 50));
    }];
}

- (void)buttonPressed:(UIButton *)sender{
    WGProjrectViewController * modalVC = [[WGProjrectViewController alloc]init];
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    
    self.animator = [[WGModalTransitionAnimator alloc] initWithModalViewController:modalVC];
    self.animator.dragable = YES;
    self.animator.bounces = NO;
    self.animator.behindViewAlpha = 0.5f;
    self.animator.behindViewScale = 0.5f;
    self.animator.transitionDuration = 0.7f;
    NSString *title = [sender titleForState:UIControlStateNormal];
    if ([title isEqualToString:@"leftButton"]) {
        self.animator.direction = WGModalTransitonDirectionLeft;
    } else if ([title isEqualToString:@"rightButton"]) {
        self.animator.direction = WGModalTransitonDirectionRight;
    } else {
        self.animator.direction = WGModalTransitonDirectionBottom;
    }
    modalVC.transitioningDelegate = self.animator;
    [self presentViewController:modalVC animated:YES completion:nil];
}


@end
