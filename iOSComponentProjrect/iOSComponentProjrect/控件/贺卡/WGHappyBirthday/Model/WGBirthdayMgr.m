//
//  WGBirthdayMgr.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "WGBirthdayMgr.h"
#import "WGAudioPlayerMgr.h"

typedef void(^YKBirthdayControllerHiddenCompelectionBlock)(void);

@interface WGBirthdayMgr ()

@property (nonatomic, strong) UIViewController *birthdayViewController;

@end

static WGBirthdayMgr *birthdayMgr = nil;

@implementation WGBirthdayMgr

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        birthdayMgr = [[WGBirthdayMgr alloc] init];
    });
    return birthdayMgr;
}

- (void)showBirthdayViewInViewController:(UIViewController *)viewController birthdayItem:(WGBirthdayItem *)birthdayItem receiveBlock:(WGBirthdayReceiveActionBlock)receiveBlock {
    __weak typeof(self) weakSelf = self;
    dispatch_block_t block = ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf showInViewController:viewController birthdayItem:birthdayItem receiveBlock:receiveBlock];
        }
    };
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

- (void)showInViewController:(UIViewController *)viewController birthdayItem:(WGBirthdayItem *)birthdayItem receiveBlock:(WGBirthdayReceiveActionBlock)receiveBlock {
    [self clearBirthdayViewController];

    WGHappyBirthdayViewController *birthdayViewController = [[WGHappyBirthdayViewController alloc] initWithNibName:@"WGHappyBirthdayViewController" bundle:nil];
    birthdayViewController.birthdayItem = birthdayItem;
    __weak typeof(self) weakSelf = self;
    birthdayViewController.receiveActionBlock = ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf hiddenBirthdayViewController:^{
                if (receiveBlock) {
                    receiveBlock();
                }
            }];
        }
    };
    self.birthdayViewController = birthdayViewController;
    [birthdayViewController showInViewController:viewController];
}

- (void)hiddenBirthdayViewController:(YKBirthdayControllerHiddenCompelectionBlock)compelectionBlock {
    [UIView animateWithDuration:0.5 animations:^{
        [WGBirthdayMgr shareInstance].birthdayViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [[WGAudioPlayerMgr sharedInstance] stopMusic:ykBirthdayMusicName];
        [self.birthdayViewController removeFromParentViewController];
        [self.birthdayViewController.view removeFromSuperview];
        self.birthdayViewController = nil;
        if (compelectionBlock) {
            compelectionBlock();
        }
    }];
}

- (void)clearBirthdayViewController {
    if (self.birthdayViewController) {
        [[WGAudioPlayerMgr sharedInstance] stopMusic:ykBirthdayMusicName];
        [self.birthdayViewController.view removeFromSuperview];
        [self.birthdayViewController removeFromParentViewController];
        self.birthdayViewController = nil;
    }
}

- (BOOL)isBirthdayViewControllerDisplaying {
    if (self.birthdayViewController) {
        return YES;
    } else {
        return NO;
    }
}

@end
