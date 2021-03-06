//
//  WGBirthdayEnvelopeView.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "WGBirthdayEnvelopeView.h"
#import "WGBirthdayUserDescView.h"
#import "WGBirthdayModel.h"
#import "UIImage+Rotate.h"

@interface WGBirthdayEnvelopeView () <CAAnimationDelegate>

@property (nonatomic, strong) UIView *enelopeView;
@property (nonatomic, strong) UIImageView *lidImageView;
@property (nonatomic, strong) UIImageView *lidOpenImageView;
@property (nonatomic, strong) UIImageView *letterPaperImageView;
@property (nonatomic, strong) UIImageView *bodayBeforeImageView;
@property (nonatomic, strong) UIImageView *shreddedPaperImageView;
@property (nonatomic, strong) UIButton *clickButton;

@end

@implementation WGBirthdayEnvelopeView

CATransform3D transForm3D;

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.uiScale = 1;
    self.backgroundColor = [UIColor clearColor];
    
    UIImage *lidImage = [UIImage imageNamed:@"birthday_envelope_lid_close"];
    UIImage *lidOpenImage = [UIImage imageNamed:@"birthday_envelope_lid_open"];
    UIImage *bodayBeforeImage = [UIImage imageNamed:@"birthday_envelope_before"];
    UIImage *bodayBehindImage = [UIImage imageNamed:@"birthday_envelope_behind"];
    UIImage *letterPaperImage = [UIImage imageNamed:@"birthday_envelope_letter_paper"];
    UIImage *shreddedPaperImage = [UIImage imageNamed:@"birthday_envelope_blingbling"];
    
    CGFloat orginY = 182 *self.uiScale;
    
    // 信封主体-后面部分
    UIImageView *bodayBehindImageView = [self getImageView:bodayBehindImage];
    bodayBehindImageView.frame = CGRectMake(0, orginY, bodayBehindImage.size.width *self.uiScale, bodayBehindImage.size.height *self.uiScale);
    
    // 信封主体-前面部分
    self.bodayBeforeImageView = [self getImageView:bodayBeforeImage];
    self.bodayBeforeImageView.frame = CGRectMake(0, orginY, bodayBeforeImage.size.width *self.uiScale, bodayBeforeImage.size.height *self.uiScale);
    
    // 信封合上时的盖
    self.lidImageView = [self getImageView:lidImage];
    self.lidImageView.layer.anchorPoint = CGPointMake(0.5, 0);
    self.lidImageView.frame = CGRectMake(0, orginY, lidImage.size.width *self.uiScale, lidImage.size.height *self.uiScale);
    
    // 信封打开时的盖
    self.lidOpenImageView = [self getImageView:lidOpenImage];
    self.lidOpenImageView.frame = CGRectMake(0, orginY-lidImage.size.height *self.uiScale, lidImage.size.width *self.uiScale, lidImage.size.height *self.uiScale);
    self.lidOpenImageView.hidden = YES;
    
    // 承载信纸的view
    UIView *letterPaperContainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bodayBeforeImage.size.width *self.uiScale, letterPaperImage.size.height *self.uiScale)];
    letterPaperContainView.backgroundColor = [UIColor clearColor];
    letterPaperContainView.clipsToBounds = YES;
    
    // 信纸
    self.letterPaperImageView = [self getImageView:letterPaperImage];
    CGFloat bodayBeforeBottomHeight = 113 *self.uiScale;
    CGFloat letterPaperImageViewOrginY = letterPaperImage.size.height *self.uiScale;
    self.letterPaperImageView.frame = CGRectMake(0, letterPaperImageViewOrginY-bodayBeforeBottomHeight, letterPaperImage.size.width *self.uiScale, letterPaperImageViewOrginY);
    CGPoint center = self.letterPaperImageView.center;
    center.x = bodayBeforeImage.size.width *self.uiScale/2;
    self.letterPaperImageView.center = center;
    self.letterPaperImageView.hidden = YES;
    [letterPaperContainView addSubview:self.letterPaperImageView];
    
    // 碎纸片
    self.shreddedPaperImageView = [self getImageView:shreddedPaperImage];
    self.shreddedPaperImageView.frame = CGRectMake(0, 44 * self.uiScale, shreddedPaperImage.size.width * self.uiScale, shreddedPaperImage.size.height * self.uiScale);
    CGPoint shreddedPaperImageViewCenter = self.shreddedPaperImageView.center;
    shreddedPaperImageViewCenter.x = bodayBeforeImage.size.width *self.uiScale/2;
    self.shreddedPaperImageView.center = shreddedPaperImageViewCenter;
    self.shreddedPaperImageView.hidden = YES;
    [letterPaperContainView addSubview:self.shreddedPaperImageView];
    
    // 按钮
    self.clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * normalImage = [UIImage imageNamed:@"birthday_envelope_btn_normal"];
    UIImage * highlightImage = [UIImage imageNamed:@"birthday_envelope_btn_press"];
    self.clickButton.frame = CGRectMake((lidImage.size.width-normalImage.size.width) *self.uiScale/2, orginY + 25 *self.uiScale, normalImage.size.width *self.uiScale, normalImage.size.height *self.uiScale);
    [self.clickButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [self.clickButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [self.clickButton addTarget:self action:@selector(handleButtonClickEvent) forControlEvents:UIControlEventTouchUpInside];
    self.clickButton.alpha = 0;
    self.clickButton.titleLabel.font = [UIFont systemFontOfSize:21];
    [self.clickButton setTitleColor:UIColorFromRGB(0xff74000d) forState:UIControlStateNormal];
    [self.clickButton setTitleColor:UIColorFromRGB(0xff74000d) forState:UIControlStateHighlighted];
    self.clickButton.titleLabel.shadowOffset = CGSizeMake(0.0,1.0);
    UIColor *shadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.44];
    [self.clickButton setTitleShadowColor:shadowColor forState:UIControlStateNormal];
    [self.clickButton setTitleShadowColor:shadowColor forState:UIControlStateHighlighted];
    UIEdgeInsets edgInset = self.clickButton.titleEdgeInsets;
    edgInset.top = edgInset.top - 3;
    [self.clickButton setTitleEdgeInsets:edgInset];
    
    [self addSubview:bodayBehindImageView];
    [self addSubview:self.bodayBeforeImageView];
    [self addSubview:self.lidImageView];
    [self addSubview:self.lidOpenImageView];
    [self addSubview:letterPaperContainView];
    [self addSubview:self.clickButton];
}

- (void)setBirthdayModel:(WGBirthdayModel *)birthdayModel {
    _birthdayModel = birthdayModel;
    NSString *buttonTitle = self.birthdayModel.birthdayLayerType == WGBirthdayLayerTypeForA ? @"开启惊喜" : @"快去送祝福";
    [self.clickButton setTitle:buttonTitle forState:UIControlStateNormal];
    WGBirthdayUserDescView *descView = [[WGBirthdayUserDescView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.letterPaperImageView.frame) *self.uiScale, CGRectGetHeight(self.letterPaperImageView.frame) *self.uiScale) birthdayModel:self.birthdayModel];
    [self.letterPaperImageView addSubview:descView];
}

- (void)handleButtonClickEvent {
    if (self.receiveActionBlock) {
        self.receiveActionBlock();
    }
}

- (UIImageView *)getImageView:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.userInteractionEnabled = YES;
    return imageView;
}

- (CABasicAnimation *)getAnimtaion:(NSString *)keyPath {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.duration = 0.5;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

- (void)startCustomAnimation {
    [self startLidFirtAnimation];
}

- (void)startLidFirtAnimation {
    transForm3D = CATransform3DIdentity;
    transForm3D.m34 = 1.0/500;
    transForm3D = CATransform3DRotate(transForm3D, M_PI/2, 1, 0, 0);
    CABasicAnimation *animation = [self getAnimtaion:@"transform"];
    animation.toValue  = [NSValue valueWithCATransform3D:transForm3D];
    [animation setValue:@(WGBirthdayAnimationTypeLidAnimationFirst) forKey:KYKBirthdayAnimationType];
    [self.lidImageView.layer addAnimation:animation forKey:nil];
}

- (void)startLidSecondAnimation {
    self.lidImageView.image = [[UIImage imageNamed:@"birthday_envelope_lid_open"] flipVertical];
    CABasicAnimation *animation = [self getAnimtaion:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:transForm3D];
    transForm3D = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    animation.toValue  = [NSValue valueWithCATransform3D:transForm3D];
    [animation setValue:@(WGBirthdayAnimationTypeLidAnimationSecond) forKey: KYKBirthdayAnimationType];
    [self.lidImageView.layer addAnimation:animation forKey:nil];
}

// 碎纸片和信纸一起出来
- (void)startLetterPaperAnimation {
    
    CGPoint letterPaperOrginPoint = self.letterPaperImageView.center;
    CABasicAnimation *moveAnimation = [self getAnimtaion:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:letterPaperOrginPoint];
    moveAnimation.toValue = [NSValue valueWithCGPoint:self.letterPaperImageView.superview.center];
    moveAnimation.duration = 1;
    [moveAnimation setValue:@(WGBirthdayAnimationTypeLetterPaperAnimation) forKey:KYKBirthdayAnimationType];
    [self.letterPaperImageView.layer addAnimation:moveAnimation forKey:nil];
    
    CGPoint shreddedPaperEndCenterPoint = self.shreddedPaperImageView.center;
    CGPoint shreddedPaperOrginPoint = self.shreddedPaperImageView.center;
    shreddedPaperOrginPoint.y = letterPaperOrginPoint.y - 44 *self.uiScale;
    self.shreddedPaperImageView.center = shreddedPaperOrginPoint;
    CABasicAnimation *shreddedPaperMoveAnimation = [self getAnimtaion:@"position"];
    shreddedPaperMoveAnimation.delegate = nil;
    shreddedPaperMoveAnimation.fromValue = [NSValue valueWithCGPoint:shreddedPaperOrginPoint];
    shreddedPaperMoveAnimation.toValue = [NSValue valueWithCGPoint:shreddedPaperEndCenterPoint];
    shreddedPaperMoveAnimation.duration = 1;
    [self.shreddedPaperImageView.layer addAnimation:shreddedPaperMoveAnimation forKey:nil];
}

- (void)showButtonAnimation {
    CABasicAnimation *opacityAnimation = [self getAnimtaion:@"opacity"];
    opacityAnimation.fromValue = 0;
    opacityAnimation.toValue = @1;
    [opacityAnimation setValue:@(WGBirthdayAnimationTypeShowButton) forKey:KYKBirthdayAnimationType];
    [self.clickButton.layer addAnimation:opacityAnimation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSInteger value = [[anim valueForKey:KYKBirthdayAnimationType] integerValue];
    switch (value) {
        case WGBirthdayAnimationTypeLidAnimationFirst:
            [self startLidSecondAnimation];
            break;
        case WGBirthdayAnimationTypeLidAnimationSecond:
            self.lidImageView.hidden = YES;
            self.lidOpenImageView.hidden = NO;
            [self bringSubviewToFront:self.bodayBeforeImageView];
            [self bringSubviewToFront:self.clickButton];
            self.letterPaperImageView.hidden = NO;
            self.shreddedPaperImageView.hidden = NO;
            [self startLetterPaperAnimation];
            break;
        case WGBirthdayAnimationTypeLetterPaperAnimation:
            [self showButtonAnimation];
            break;
        case WGBirthdayAnimationTypeShowButton:
            self.clickButton.alpha = 1;
            break;
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
