//
//  WGBaseViewController.m
//
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import "WGBaseViewController.h"

@interface WGBaseViewController ()

@end

@implementation WGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.navTitle;
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];

}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
