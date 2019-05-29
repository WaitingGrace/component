//
//  WGPopMenuItem.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGPopMenuItem.h"

NSString *const kPopMenuItemTitle             = @"ItemTitle";
NSString *const kPopMenuItemAttributeTitle    = @"ItemAttributeTitle";
NSString *const kPopMenuItemIconImageName     = @"ItemIconImageName";

@interface WGPopMenuItem ()<CAAnimationDelegate>
@end
@implementation WGPopMenuItem
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //1.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //2.文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        //3.图片的内容模式
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addTarget:self action:@selector(scaleToSmall)
       forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
        [self addTarget:self action:@selector(scaleToDefault)
       forControlEvents:UIControlEventTouchDragExit];
    }
    return self;
}

- (void)scaleToSmall {
    CABasicAnimation *theAnimation;
    theAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.delegate = self;
    theAnimation.duration = 0.1;
    theAnimation.repeatCount = 0;
    theAnimation.removedOnCompletion = FALSE;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.autoreverses = NO;
    theAnimation.fromValue = [NSNumber numberWithFloat:1];
    theAnimation.toValue = [NSNumber numberWithFloat:1.1f];
    [self.imageView.layer addAnimation:theAnimation forKey:theAnimation.keyPath];
}

- (void)scaleToDefault {
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.delegate = self;
    theAnimation.duration = 0.1;
    theAnimation.repeatCount = 0;
    theAnimation.removedOnCompletion = FALSE;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.autoreverses = NO;
    theAnimation.fromValue = [NSNumber numberWithFloat:1.1f];
    theAnimation.toValue = [NSNumber numberWithFloat:1];
    [self.imageView.layer addAnimation:theAnimation forKey:theAnimation.keyPath];
}

- (void)playSelectAnimation {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.delegate = self;
    scaleAnimation.duration = 0.2;
    scaleAnimation.repeatCount = 0;
    scaleAnimation.removedOnCompletion = FALSE;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.autoreverses = NO;
    scaleAnimation.fromValue = @1;
    scaleAnimation.toValue = @1.3;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.delegate = self;
    opacityAnimation.duration = 0.2;
    opacityAnimation.repeatCount = 0;
    opacityAnimation.removedOnCompletion = FALSE;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.autoreverses = NO;
    opacityAnimation.fromValue = @1;
    opacityAnimation.toValue = @0;
    
    [self.layer addAnimation:scaleAnimation forKey:scaleAnimation.keyPath];
    [self.layer addAnimation:opacityAnimation forKey:opacityAnimation.keyPath];
}

- (void)playCancelAnimation {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.delegate = self;
    scaleAnimation.duration = 0.2;
    scaleAnimation.repeatCount = 0;
    scaleAnimation.removedOnCompletion = FALSE;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.autoreverses = NO;
    scaleAnimation.fromValue = @1;
    scaleAnimation.toValue = @0.3;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.delegate = self;
    opacityAnimation.duration = 0.2;
    opacityAnimation.repeatCount = 0;
    opacityAnimation.removedOnCompletion = FALSE;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.autoreverses = NO;
    opacityAnimation.fromValue = @1;
    opacityAnimation.toValue = @0;
    
    [self.layer addAnimation:scaleAnimation forKey:scaleAnimation.keyPath];
    [self.layer addAnimation:opacityAnimation forKey:opacityAnimation.keyPath];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageWidth = contentRect.size.width/2;
    CGFloat imageX = CGRectGetWidth(contentRect)/2 - imageWidth/2;
    CGFloat imageHeight = imageWidth;
    CGFloat imageY = CGRectGetHeight(self.bounds) - (imageHeight + 30);
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 0;
    CGFloat titleHeight = 20;
    CGFloat titleY = contentRect.size.height - titleHeight;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX,titleY, titleWidth, titleHeight);
}

- (void)setAttrDic:(NSMutableDictionary *)attrDic {
    _attrDic = [attrDic copy];
    NSString *imageName = [attrDic objectForKey:kPopMenuItemIconImageName];
    UIImage *image = [UIImage imageNamed:imageName];
    [self setImage:image forState:UIControlStateNormal];
    NSString *title = [attrDic objectForKey:kPopMenuItemTitle];
    if (title) {
        [self setTitle:title forState:UIControlStateNormal];
    }
    NSAttributedString * attrTitle = [attrDic objectForKey:kPopMenuItemAttributeTitle];
    if (attrTitle) {
        [self setAttributedTitle:attrTitle forState:(UIControlStateNormal)];
    }
}


@end
