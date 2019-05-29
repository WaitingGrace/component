//
//  WGFloatTipsVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/22.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGFloatTipsVC.h"
#import "WGFloatTips.h"

@interface WGFloatTipsVC ()

@end

@implementation WGFloatTipsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    [self demo];
}

- (void)demo
{
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor = [UIColor blackColor];
    btn1.frame = CGRectMake(30, 200, 30, 30);
    btn1.layer.cornerRadius = 15;
    btn1.tag  = 1;
    [btn1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [UIColor blackColor];
    btn2.frame = CGRectMake(self.view.frame.size.width - 60, 200, 30, 30);
    btn2.layer.cornerRadius = 15;
    btn2.tag  = 2;
    [btn2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn2];
    
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.backgroundColor = [UIColor blackColor];
    btn3.frame = CGRectMake(self.view.frame.size.width*0.5 - 15, self.view.frame.size.height*0.5 - 30, 30, 30);
    btn3.layer.cornerRadius = 15;
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn3];
    
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.backgroundColor = [UIColor blackColor];
    btn4.frame = CGRectMake(30, self.view.frame.size.height - 60, 30, 30);
    btn4.layer.cornerRadius = 15;
    btn4.tag  = 4;
    [btn4 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn4];
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn6.backgroundColor = [UIColor blackColor];
    btn6.frame = CGRectMake(self.view.frame.size.width - 100,self.view.frame.size.height - 60, 30, 30);
    btn6.layer.cornerRadius = 15;
    btn6.tag  = 6;
    [btn6 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn6];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.backgroundColor = [UIColor blackColor];
    btn5.frame = CGRectMake(self.view.frame.size.width - 60,self.view.frame.size.height - 60, 30, 30);
    btn5.layer.cornerRadius = 15;
    btn5.tag  = 5;
    [btn5 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn5];
}

- (void)buttonClicked:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
        {
            [WGFloatTips addTipsForView:btn content:@"我就是这么傲娇"];
        }
            break;
        case 2:
        {
            [WGFloatTips addTipsForView:btn content:@"我曾把完整的镜子打碎，夜晚的枕头都是眼泪"];
        }
            break;
        case 3:
        {
            [WGFloatTips addTipsForView:btn content:@"我曾想让过去重来，再给我一次机会"];
        }
            break;
        case 4:
        {
            [WGFloatTips addTipsForView:btn content:@"他们都不要脸"];
        }
            break;
        case 5:
        {
            [WGFloatTips addTipsForView:btn content:@"我的老家就住在这个屯，我是这个屯里土生土长的人,我的老家就住在这个屯，我是这个屯里土生土长的人" afterDelay:2];
        }
            break;
        case 6:
        {
            [WGFloatTips addTipsForView:btn content:@"你的酒馆对我打了样，子弹在我心口上了膛，请告诉我今后怎么扛" afterDelay:3];
        }
            break;
            
        default:
            break;
    }
}


@end
