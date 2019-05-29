//
//  WGMineViewController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGMineViewController.h"
#import "WGSpeechRecognitionVC.h"

@interface WGMineViewController ()

@end

@implementation WGMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    WGSpeechRecognitionVC *controller = [WGSpeechRecognitionVC new];
    controller.startPoint = point;
    controller.bubbleColor = [UIColor whiteColor];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
