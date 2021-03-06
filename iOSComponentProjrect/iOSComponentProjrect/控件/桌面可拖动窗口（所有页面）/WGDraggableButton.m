//
//  WGDraggableButton.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGDraggableButton.h"

#define wg_ScreenH [UIScreen mainScreen].bounds.size.height
#define wg_ScreenW [UIScreen mainScreen].bounds.size.width

@interface WGDraggableButton()

@property (nonatomic, assign)CGPoint touchStartPosition;

@end

@implementation WGDraggableButton

typedef NS_ENUM(NSInteger ,WG_FloatWindowDirection) {
    wg_FloatWindowLEFT,
    wg_FloatWindowRIGHT,
    wg_FloatWindowTOP,
    wg_FloatWindowBOTTOM
};

typedef NS_ENUM(NSInteger, WG_ScreenChangeOrientation) {
    wg_Change2Origin,
    wg_Change2Upside,
    wg_Change2Left,
    wg_Change2Right
};

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.touchStartPosition = [touch locationInView:_rootView];
    self.touchStartPosition = [self ConvertDir:_touchStartPosition];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint curPoint = [touch locationInView:_rootView];
    curPoint = [self ConvertDir:curPoint];
    self.superview.center = curPoint;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint curPoint = [touch locationInView:_rootView];
    curPoint = [self ConvertDir:curPoint];
    // if the start touch point is too close to the end point, take it as the click event and notify the click delegate
    if (pow((_touchStartPosition.x - curPoint.x),2) + pow((_touchStartPosition.y - curPoint.y),2) < 1) {
        [self.buttonDelegate dragButtonClicked:self];
        return;
    }

    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat W = wg_ScreenW;
    CGFloat H = wg_ScreenH;
    // (1,2->3,4 | 3,4->1,2)
    NSInteger judge = orientation + _initOrientation;
    if (orientation != _initOrientation && judge != 3 && judge != 7) {
        W = wg_ScreenW;
        H = wg_ScreenW;
    }
    // distances to the four screen edges
    CGFloat left = curPoint.x;
    CGFloat right = W - curPoint.x;
    CGFloat top = curPoint.y;
    CGFloat bottom = H - curPoint.y;
    // find the direction to go
    WG_FloatWindowDirection minDir = wg_FloatWindowLEFT;
    CGFloat minDistance = left;
    if (right < minDistance) {
        minDistance = right;
        minDir = wg_FloatWindowRIGHT;
    }
    if (top < minDistance) {
        minDistance = top;
        minDir = wg_FloatWindowTOP;
    }
    if (bottom < minDistance) {
        minDir = wg_FloatWindowBOTTOM;
    }
    
    switch (minDir) {
        case wg_FloatWindowLEFT: {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(self.superview.frame.size.width/2, self.superview.center.y);
            }];
            break;
        }
        case wg_FloatWindowRIGHT: {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(W - self.superview.frame.size.width/2, self.superview.center.y);
            }];
            break;
        }
        case wg_FloatWindowTOP: {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(self.superview.center.x, self.superview.frame.size.height/2);
            }];
            break;
        }
        case wg_FloatWindowBOTTOM: {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(self.superview.center.x, H - self.superview.frame.size.height/2);
            }];
            break;
        }
        default:
            break;
    }
}

- (void)buttonRotate {
    WG_ScreenChangeOrientation change2orien = [self screenChange];
    switch (change2orien) {
        case wg_Change2Origin:
            self.transform = _originTransform;
            break;
        case wg_Change2Left:
            self.transform = _originTransform;
            self.transform = CGAffineTransformMakeRotation(-M_PI_2);
            break;
        case wg_Change2Right:
            self.transform = _originTransform;
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case wg_Change2Upside:
            self.transform = _originTransform;
            self.transform = CGAffineTransformMakeRotation(M_PI);
            break;
        default:
            break;
    }
}

/**
 *  convert to the origin coordinate
 *
 *  UIInterfaceOrientationPortrait           = 1
 *  UIInterfaceOrientationPortraitUpsideDown = 2
 *  UIInterfaceOrientationLandscapeRight     = 3
 *  UIInterfaceOrientationLandscapeLeft      = 4
 */
- (CGPoint)ConvertDir:(CGPoint)p {
    WG_ScreenChangeOrientation change2orien = [self screenChange];
    // covert
    switch (change2orien) {
        case wg_Change2Left:
            return [self LandscapeLeft:p];
            break;
        case wg_Change2Right:
            return [self LandscapeRight:p];
            break;
        case wg_Change2Upside:
            return [self UpsideDown:p];
            break;
        default:
            return p;
            break;
    }
}

- (WG_ScreenChangeOrientation)screenChange {
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    // 1. xh_Change2Origin(1->1 | 2->2 | 3->3 | 4->4)
    if (_initOrientation == orientation) return wg_Change2Origin;
    // 2. xh_Change2Upside(1->2 | 2->1 | 4->3 | 3->4)
    NSInteger isUpside = orientation + _initOrientation;
    if (isUpside == 3 || isUpside == 7) return wg_Change2Upside;
    // 3. xh_Change2Left(1->4 | 4->2 | 2->3 | 3->1)
    // 4. xh_Change2Right(1->3 | 3->2 | 2->4 | 4->1)
    WG_ScreenChangeOrientation change2orien;
    switch (_initOrientation) {
        case UIInterfaceOrientationPortrait:
            if (orientation == UIInterfaceOrientationLandscapeLeft)
                change2orien = wg_Change2Left;
            else
                change2orien = wg_Change2Right;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            if (orientation == UIInterfaceOrientationLandscapeRight)
                change2orien = wg_Change2Left;
            else
                change2orien = wg_Change2Right;
            break;
        case UIInterfaceOrientationLandscapeRight:
            if (orientation == UIInterfaceOrientationPortrait)
                change2orien = wg_Change2Left;
            else
                change2orien = wg_Change2Right;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            if (orientation == UIInterfaceOrientationPortraitUpsideDown)
                change2orien = wg_Change2Left;
            else
                change2orien = wg_Change2Right;
            break;
            
        default:
            change2orien = wg_Change2Left;
            break;
    }
    return change2orien;
}

- (CGPoint)UpsideDown:(CGPoint)p {
    return CGPointMake(wg_ScreenW - p.x, wg_ScreenH - p.y);
}

- (CGPoint)LandscapeLeft:(CGPoint)p {
    return CGPointMake(p.y, wg_ScreenW - p.x);
}

- (CGPoint)LandscapeRight:(CGPoint)p {
    return CGPointMake(wg_ScreenH - p.y, p.x);
}

@end
