//
//  WGDraggableCardView.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGDraggableCardView.h"

@implementation WGDraggableCardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self defaultStyle];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self defaultStyle];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self defaultStyle];
}

- (void)defaultStyle {
    
    self.userInteractionEnabled = YES;
    
    // [self.subviews makeObjectsPerformSelector:@selector(setBackgroundColor:) withObject:[UIColor whiteColor]];
    
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:10.0f];
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    CGFloat scaleBackgroud = 245.0f / 255.0f;
    self.backgroundColor = [UIColor colorWithRed:scaleBackgroud green:scaleBackgroud blue:scaleBackgroud alpha:1];
    
    CGFloat scaleBorder = 176.0f / 255.0f;
    [self.layer setBorderWidth:.45];
    [self.layer setBorderColor:[UIColor colorWithRed:scaleBorder green:scaleBorder blue:scaleBorder alpha:1].CGColor];
}

- (void)wg_layoutSubviews {}

@end
