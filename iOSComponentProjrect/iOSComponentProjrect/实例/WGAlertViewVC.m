//
//  WGAlertViewVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/6.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGAlertViewVC.h"
#import "WGUIAlertView.h"
#import "WGActionSheet.h"

@interface WGAlertViewVC ()<WGActionSheetDelegate>

@end

@implementation WGAlertViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = BackColor;
    [self setupView];
}

- (void)setupView{
    NSArray *titles = @[@"标题",
                        @"内容",
                        @"按钮",
                        @"两个按钮",
                        @"三个按钮",
                        @"标题+按钮",
                        @"内容+按钮",
                        @"标题+内容+一个按钮",
                        @"标题+内容+两个按钮",
                        @"标题+内容+三个按钮",
                        @"标题+内容+四个按钮",
                        @"添加自定义视图",
                        @"sheetView"];
    CGFloat W = self.view.frame.size.width;
    for (int i = 0; i < titles.count; ++i) {
        
        UIButton *button = [UIButton buttonWithType:0];
        button.frame = CGRectMake(10, NavHeight+20+45*i, W-20, 40);
        button.backgroundColor = [UIColor lightGrayColor];
        [button setTitle:titles[i] forState:0];
        [button setTitleColor:[UIColor blackColor] forState:0];
        [button addTarget:self action:@selector(xx_event:) forControlEvents:1<<6];
        button.tag = i;
        [self.view addSubview:button];
    }
}

- (void)xx_event:(UIButton *)button
{
    NSInteger tag = button.tag;
    if (0 == tag) {
        WGUIAlertConfig *config = [[WGUIAlertConfig alloc] init];
        config.title.text       = @"这是一个很长的提示";
        WGUIAlertView *alert = [[WGUIAlertView alloc] initWithConfig:config];
        [self.view addSubview:alert];
        
    }else if (1 == tag) {
        WGUIAlertConfig *config = [[WGUIAlertConfig alloc] init];
        config.content.text     = @"这里是内容";
        WGUIAlertView *alert = [[WGUIAlertView alloc] initWithConfig:config];
        [self.view addSubview:alert];
    }else if (2 == tag) {
        WGUIAlertConfig *config = [[WGUIAlertConfig alloc] init];
        WGUIAlertButtonConfig *btnconfig1 = [WGUIAlertButtonConfig configWithTitle:@"确定" color:nil font:nil image:nil handle:^{
            NSLog(@"click1");
        }];
        config.buttons = @[btnconfig1];
        WGUIAlertView *alert = [[WGUIAlertView alloc] initWithConfig:config];
        [self.view addSubview:alert];
    }else if (3 == tag) {
        WGUIAlertConfig *config = [[WGUIAlertConfig alloc] init];
        
        WGUIAlertButtonConfig *btnconfig1 = [WGUIAlertButtonConfig configWithTitle:@"取消" color:nil font:nil image:nil handle:^{
            NSLog(@"click1");
        }];
        
        WGUIAlertButtonConfig *btnconfig2 = [WGUIAlertButtonConfig configWithTitle:@"确定" color:nil font:nil image:nil handle:^{
            NSLog(@"click2");
        }];
        
        config.buttons = @[btnconfig1,btnconfig2];
        WGUIAlertView *alert = [[WGUIAlertView alloc] initWithConfig:config];
        [self.view addSubview:alert];
    }else if (4 == tag) {
        WGUIAlertConfig *config = [[WGUIAlertConfig alloc] init];
        
        WGUIAlertButtonConfig *btnconfig1 = [WGUIAlertButtonConfig configWithTitle:@"取消" color:nil font:nil image:nil handle:^{
            NSLog(@"click1");
        }];
        
        WGUIAlertButtonConfig *btnconfig2 = [WGUIAlertButtonConfig configWithTitle:@"确定" color:nil font:nil image:nil handle:^{
            NSLog(@"click2");
        }];
        
        WGUIAlertButtonConfig *btnconfig3 = [WGUIAlertButtonConfig configWithTitle:@"看看" color:nil font:nil image:nil handle:^{
            NSLog(@"click3");
        }];
        
        config.buttons = @[btnconfig1,btnconfig2,btnconfig3];
        WGUIAlertView *alert = [[WGUIAlertView alloc] initWithConfig:config];
        [self.view addSubview:alert];
    }else if (5 == tag) {
        WGUIAlertConfig *config = [[WGUIAlertConfig alloc] init];
        config.title.text       = @"这是一个提示";
        
        WGUIAlertButtonConfig *btnconfig1 = [WGUIAlertButtonConfig configWithTitle:@"确定" color:nil font:nil image:nil handle:^{
            NSLog(@"click2");
        }];
        
        config.buttons = @[btnconfig1];
        WGUIAlertView *alert = [[WGUIAlertView alloc] initWithConfig:config];
        [self.view addSubview:alert];
    }else if (6 == tag){
        WGUIAlertConfig *config = [[WGUIAlertConfig alloc] init];
        config.content.text          = @"您的余额不足，需充值之";
        
        WGUIAlertButtonConfig *btnconfig1 = [WGUIAlertButtonConfig configWithTitle:@"确定" color:nil font:nil image:nil handle:^{
            NSLog(@"click2");
        }];
        
        config.buttons = @[btnconfig1];
        WGUIAlertView *alert = [[WGUIAlertView alloc] initWithConfig:config];
        [self.view addSubview:alert];
    }else if (7 == tag){
        WGUIAlertConfig *config = [[WGUIAlertConfig alloc] init];
        config.title.text            = @"这是一个提示";
        config.content.text          = @"您的余额不足，需充值之后才能继续观看";
        config.content.font      = [UIFont systemFontOfSize:15];
        
        WGUIAlertButtonConfig *btnconfig1 = [WGUIAlertButtonConfig configWithTitle:@"确定" color:nil font:nil image:nil handle:^{
            NSLog(@"click1");
        }];
        
        config.buttons = @[btnconfig1];
        WGUIAlertView *alert = [[WGUIAlertView alloc] initWithConfig:config];
        [self.view addSubview:alert];
    }else if (8 == tag){
        WGUIAlertConfig *config = [[WGUIAlertConfig alloc] init];
        config.title.text            = @"这是一个提示";
        config.content.text          = @"您的余额不足，需充值之后才能继续观看";
        config.content.font      = [UIFont systemFontOfSize:15];
        
        WGUIAlertButtonConfig *btnconfig1 = [WGUIAlertButtonConfig configWithTitle:@"取消" color:nil font:nil image:nil handle:^{
            NSLog(@"click1");
        }];
        
        WGUIAlertButtonConfig *btnconfig2 = [WGUIAlertButtonConfig configWithTitle:@"确定" color:nil font:nil image:nil handle:^{
            NSLog(@"click2");
        }];
        
        config.buttons = @[btnconfig1,btnconfig2];
        WGUIAlertView *alert = [[WGUIAlertView alloc] initWithConfig:config];
        [self.view addSubview:alert];
    }else if (9 == tag){
        WGUIAlertConfig *config = [[WGUIAlertConfig alloc] init];
        config.title.text            = @"这是一个提示";
        config.content.text          = @"您的余额不足，需充值之后才能继续观看";
        config.content.font      = [UIFont systemFontOfSize:15];
        
        WGUIAlertButtonConfig *btnconfig1 = [WGUIAlertButtonConfig configWithTitle:@"取消" color:nil font:nil image:nil handle:^{
            NSLog(@"click1");
        }];
        
        WGUIAlertButtonConfig *btnconfig2 = [WGUIAlertButtonConfig configWithTitle:@"确定" color:nil font:nil image:nil handle:^{
            NSLog(@"click2");
        }];
        
        WGUIAlertButtonConfig *btnconfig3 = [WGUIAlertButtonConfig configWithTitle:@"看看" color:nil font:nil image:nil handle:^{
            NSLog(@"click3");
        }];
        
        config.buttons = @[btnconfig1,btnconfig2,btnconfig3];
        WGUIAlertView *alert = [[WGUIAlertView alloc] initWithConfig:config];
        [self.view addSubview:alert];
    }else if (10 == tag){
        WGUIAlertConfig *config = [[WGUIAlertConfig alloc] init];
        config.title.text            = @"这是一个提示";
        config.content.text          = @"您的余额不足，需充值之后才能继续观看";
        
        WGUIAlertButtonConfig *btnconfig1 = [WGUIAlertButtonConfig configWithTitle:@"取消" color:nil font:nil image:nil handle:^{
            NSLog(@"click1");
        }];
        
        WGUIAlertButtonConfig *btnconfig2 = [WGUIAlertButtonConfig configWithTitle:@"确定" color:nil font:nil image:nil handle:^{
            NSLog(@"click2");
        }];
        
        WGUIAlertButtonConfig *btnconfig3 = [WGUIAlertButtonConfig configWithTitle:@"看看" color:nil font:nil image:nil handle:^{
            NSLog(@"click3");
        }];
        
        WGUIAlertButtonConfig *btnconfig4 = [WGUIAlertButtonConfig configWithTitle:@"等等" color:nil font:nil image:nil handle:^{
            NSLog(@"click4");
        }];
        
        config.buttons = @[btnconfig1,btnconfig2,btnconfig3,btnconfig4];
        WGUIAlertView *alert = [[WGUIAlertView alloc] initWithConfig:config];
        [self.view addSubview:alert];
    }else if (tag == 11){
        WGUIAlertConfig *config = [[WGUIAlertConfig alloc] init];
        config.title.text       = @"添加自定义视图";
        config.title.bottomPadding = 100; // set bottomPadding to keep enough height
        config.dismissWhenTapOut   = NO;
        
        // when you want a fully custom view, you should use 'contentViewHeight'
        /*
         
         WGUIAlertConfig *config = [[WGUIAlertConfig alloc] init];
         config.contentViewHeight = 200;
         
         */
        
        WGUIAlertView *alertView = [[WGUIAlertView alloc] initWithConfig:config];
        
        [alertView addCustomView:^(WGUIAlertView *alertView, CGRect contentViewRect, CGRect titleLabelRect, CGRect contentLabelRect) {
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(10, CGRectGetMaxY(titleLabelRect)+10, contentViewRect.size.width-20, 20);
            label.text = @"这是一个自定义的标签";
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            
            [alertView.contentView addSubview:label];
            
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(10, CGRectGetMaxY(label.frame)+10, contentViewRect.size.width-20, 40);
            button.backgroundColor = [UIColor lightGrayColor];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            [button setTitle:@"button" forState:0];
            [button addTarget:self action:@selector(buttonEvent:) forControlEvents:1<<6];
            [alertView.contentView addSubview:button];
            
        }];
        
        [self.view addSubview:alertView];
    }else if (tag == 12){
        WGActionSheet *actionSheet = [[WGActionSheet alloc] initWithDelegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"title" otherButtonTitles: nil];
        [actionSheet addButtonWithTitle:@"Hi!" actionBlock:^{  }];
        [actionSheet addButtonWithTitle:@"Bye"];
        [actionSheet addButtonWithTitle:@"Jyeno2_"];
        [actionSheet addButtonWithTitle:@"Tara"];
        [actionSheet addButtonWithTitle:@"YY"];
        
        [actionSheet show];
    }
}

- (void)buttonEvent:(UIButton *)button
{
    UIView *view = button.superview;
    while (view) {
        if ([view isKindOfClass: [WGUIAlertView class]]) {
            [view removeFromSuperview];
            break;
        }
        view = view.superview;
    }
}

- (void)actionSheetCancel:(WGActionSheet *)actionSheet {
    
}

- (void)actionSheet:(WGActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    
}

- (void)actionSheet:(WGActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
}

- (void)actionSheet:(WGActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}

- (void)willPresentActionSheet:(WGActionSheet *)actionSheet {
    
}

- (void)didPresentActionSheet:(WGActionSheet *)actionSheet {
    
}
@end
