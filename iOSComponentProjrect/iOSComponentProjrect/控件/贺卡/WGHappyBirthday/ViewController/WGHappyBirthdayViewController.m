//
//  WGHappyBirthdayViewController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "WGHappyBirthdayViewController.h"

@interface WGHappyBirthdayViewController ()

@property (nonatomic, strong) IBOutlet WGBirthdayView *birthdayView;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *birthdayViewHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *birthdayViewWidthConstraint;

@end

@implementation WGHappyBirthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.birthdayViewHeightConstraint.constant = self.birthdayView.height;
    self.birthdayViewWidthConstraint.constant = self.birthdayView.width;
    [self handleBirthdayViewEvent];
}

- (void)handleBirthdayViewEvent {
    
    [self.birthdayView animationForBirthdayLid];
    
    self.birthdayView.birthdayTitle = self.birthdayItem.birthdayTitle;
    self.birthdayView.birthdaySubTitle = self.birthdayItem.birthdaySubTitle;
    self.birthdayView.birthdayDescritpion = self.birthdayItem.birthdayDescriptionTitle;
    __weak typeof(self) weakSelf = self;
    self.birthdayView.receiveActionBlock = ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf && strongSelf.receiveActionBlock) {
            strongSelf.receiveActionBlock();
        }
    };
}

- (void)showInViewController:(UIViewController *)viewController {
    [viewController addChildViewController:self];
    self.view.frame = viewController.view.frame;
    [viewController.view addSubview:self.view];
    [self didMoveToParentViewController:viewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.birthdayView.isCloseAnimation = YES;
    [self.birthdayView removeFromSuperview];
    self.birthdayView = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
