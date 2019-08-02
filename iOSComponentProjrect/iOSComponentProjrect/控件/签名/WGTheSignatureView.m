//
//  WGTheSignatureView.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGTheSignatureView.h"
#import "WGSignView.h"
#import "Config.h"

@interface WGTheSignatureView ()
@property (nonatomic ,strong) UIView * baseView;
@property (nonatomic ,strong) WGSignView *signView;
@property (nonatomic ,strong) UIButton * cancleBtn;//取消按钮
@property (nonatomic ,strong) UIButton * sureBtn;//确定按钮
@property (nonatomic ,strong) UIButton * clearBtn;//清除按钮

@end
@implementation WGTheSignatureView

- (UIButton *)clearBtn{
    if (_clearBtn == nil) {
        _clearBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_clearBtn setTitle:@"清 除" forState:(UIControlStateNormal)];
        [_clearBtn setTitleColor:BASEColor forState:(UIControlStateNormal)];
        [_clearBtn addTarget:self action:@selector(clearBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _clearBtn;
}
- (UIButton *)sureBtn{
    if (_sureBtn == nil) {
        _sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_sureBtn setTitle:@"确 定" forState:(UIControlStateNormal)];
        [_sureBtn setTitleColor:BASEColor forState:(UIControlStateNormal)];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _sureBtn;
}
- (UIButton *)cancleBtn{
    if (_cancleBtn == nil) {
        _cancleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_cancleBtn setImage:[UIImage imageNamed:@"photo_delete"] forState:(UIControlStateNormal)];
        [_cancleBtn setBackgroundColor:[UIColor clearColor]];
        [_cancleBtn addTarget:self action:@selector(cancleSignView) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _cancleBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self setInitView];
    }
    return self;
}

- (void)setInitView{
    UIView * writeView = [[UIView alloc]init];
    writeView.backgroundColor = [UIColor whiteColor];

    if (iPad) {
        writeView.frame = CGRectMake(10, ScreenHeight/4, ScreenWidth-20, ScreenHeight/2);
    }else{
        writeView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }
    [self addSubview:writeView];
    UILabel * titleLael = [[UILabel alloc]init];
    titleLael.textColor = TitleColor;
    titleLael.text = @"签名板";
    titleLael.font = FONT(iPhone4_5?17:(iPad?22:19));
    [writeView addSubview:titleLael];
    [titleLael mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(30);
    }];
    [writeView addSubview:self.cancleBtn];
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.right.mas_equalTo(iPad?-30:-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [writeView addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(iPad?-30:-10);
        make.right.mas_equalTo(iPad?-30:-10);
    }];
    [writeView addSubview:self.clearBtn];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.sureBtn.mas_top).offset(iPad?-30:-20);
        make.right.mas_equalTo(self.sureBtn);
    }];
    writeView.layer.cornerRadius = 10.f;
    writeView.clipsToBounds = YES;
    writeView.layer.borderWidth = 1.5;
    writeView.layer.borderColor = [TitleColor CGColor];
    if (iPad) {
        self.signView = [[WGSignView alloc] initWithFrame:writeView.bounds];
        [writeView addSubview:self.signView];
        [writeView bringSubviewToFront:self.sureBtn];
        [writeView bringSubviewToFront:self.clearBtn];
        [writeView bringSubviewToFront:self.cancleBtn];
        [writeView bringSubviewToFront:titleLael];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            writeView.transform = CGAffineTransformMakeRotation(M_PI/2);
            writeView.bounds = CGRectMake(20, 10, ScreenHeight-30, ScreenWidth-20);
        } completion:^(BOOL finished) {
            
            self.signView = [[WGSignView alloc] initWithFrame:writeView.bounds];
            [writeView addSubview:self.signView];
            [writeView bringSubviewToFront:self.sureBtn];
            [writeView bringSubviewToFront:self.clearBtn];
            [writeView bringSubviewToFront:self.cancleBtn];
            [writeView bringSubviewToFront:titleLael];
        }];
    }
}

- (void)cancleSignView{
    [self removeFromSuperview];
}
- (void)sureBtnClick{
    [self removeFromSuperview];
    UIImage * image = [self.signView getSignatureImage];
    if (self.signatureBlock) {
        self.signatureBlock(image);
    }
}
- (void)clearBtnClick{
    [self.signView clearSignature];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
