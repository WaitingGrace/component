//
//  WGBirthdayViewController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "WGBirthdayViewController.h"
#import "WGBirthdayEnvelopeView.h"
#import "WGBirthdayModel.h"
#import "WGAudioPlayerMgr.h"
#import "WGBirthdayEnvelopeMgr.h"

@interface WGBirthdayViewController ()

@property (nonatomic, strong) IBOutlet WGBirthdayEnvelopeView *envelopeView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *envelopeViewWidthConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *envelopeViewHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *closeButtonTopConstraint;

@end

@implementation WGBirthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.envelopeViewWidthConstraint.constant = 304 * self.envelopeView.uiScale;
    self.envelopeViewHeightConstraint.constant = 386 * self.envelopeView.uiScale;
    self.closeButtonTopConstraint.constant = 30;
    __weak typeof(self) weakSelf = self;
    self.envelopeView.receiveActionBlock = ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf && strongSelf.receiveActionBlock) {
            strongSelf.receiveActionBlock();
        }
    };
    self.envelopeView.birthdayModel = self.birthdayModel;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 动画开始播放音乐
    [[WGBirthdayEnvelopeMgr shareInstance] playBirthdayMusic];
    [self.envelopeView startCustomAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showInViewController:(UIViewController *)viewController {
    [viewController addChildViewController:self];
    self.view.frame = viewController.view.frame;
    [viewController.view addSubview:self.view];
    [self didMoveToParentViewController:viewController];
}

- (IBAction)dismiss:(id)sender {
    if (self.birthdayLayerCloseBlock) {
        self.birthdayLayerCloseBlock();
    }
}



@end
