//
//  WGLayerBirthdayMgr.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "WGBirthdayEnvelopeMgr.h"
#import "WGBirthdayModel.h"
#import "WGBirthdayViewController.h"
#import "WGAudioPlayerMgr.h"

typedef void(^YKBirthdayControllerHiddenCompelectionBlock)(void);

static WGBirthdayEnvelopeMgr *birthdayMgr = nil;

@interface WGBirthdayEnvelopeMgr ()

@property (nonatomic, strong) WGBirthdayModel *birthdayModel;
@property (nonatomic, strong) WGBirthdayViewController *birthdayViewController;

@end

/* 生日动画idKey */
static NSString *const KYKBirthdayEventIdKey = @"KYKBirthdayEventIdKey";

@implementation WGBirthdayEnvelopeMgr

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        birthdayMgr = [[WGBirthdayEnvelopeMgr alloc] init];
    });
    return birthdayMgr;
}

- (BOOL)isShowBirthdayView {
    return YES;
}

- (void)showBirthdayViewController:(UIViewController *)viewController birthdayModel:(WGBirthdayModel *)birthdayModel {
    self.birthdayModel = birthdayModel;
    dispatch_block_t block = ^{
        [self handleShowBirthdayViewControllerEvent:viewController];
    };
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

- (void)handleShowBirthdayViewControllerEvent:(UIViewController *)viewController  {
    [self clearBirthdayViewController];
    WGBirthdayViewController *birthdayViewController = [[WGBirthdayViewController alloc] initWithNibName:@"WGBirthdayViewController" bundle:nil];
    birthdayViewController.birthdayModel = self.birthdayModel;
    __weak typeof(self) weakSelf = self;
    birthdayViewController.receiveActionBlock = ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf handleBirthdayLayerEnterWebViewEvent];
        }
    };
    birthdayViewController.birthdayLayerCloseBlock = ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf handleBirthdayLayerCloseEvent];
        }
    };
    self.birthdayViewController = birthdayViewController;
    [birthdayViewController showInViewController:viewController];
}

- (void)handleBirthdayLayerCloseEvent {
    [self hiddenBirthdayViewController:^{
        
    }];
}

- (void)handleBirthdayLayerEnterWebViewEvent {
    __weak typeof(self) weakSelf = self;
    [self hiddenBirthdayViewController:^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf.birthdayModel.birthdayJumpLinkUrl.length > 0) {
            
        }
    }];
}

- (void)hiddenBirthdayViewController:(YKBirthdayControllerHiddenCompelectionBlock)compelectionBlock {
    [UIView animateWithDuration:0.5 animations:^{
        self.birthdayViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self stopBirthdayMusic];
        [self.birthdayViewController.view removeFromSuperview];
        [self.birthdayViewController removeFromParentViewController];
        self.birthdayViewController = nil;
        if (compelectionBlock) {
            compelectionBlock();
        }
    }];
}

- (void)clearBirthdayViewController {
    if (self.birthdayViewController) {
        [self stopBirthdayMusic];
        [self.birthdayViewController.view removeFromSuperview];
        [self.birthdayViewController removeFromParentViewController];
        self.birthdayViewController = nil;
    }
}

- (void)playBirthdayMusic {
    [[WGAudioPlayerMgr sharedInstance] playMusic:ykBirthdayMusicName isLoops:YES];
}

- (void)stopBirthdayMusic {
    [[WGAudioPlayerMgr sharedInstance] stopMusic:ykBirthdayMusicName];
}

@end
