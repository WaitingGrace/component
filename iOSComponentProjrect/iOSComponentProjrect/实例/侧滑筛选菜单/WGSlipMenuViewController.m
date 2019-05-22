//
//  WGSlipMenuViewController.m
//
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import "WGSlipMenuViewController.h"
#import "WGDropMenu.h"
#import "WGDropMenuModel.h"

@interface WGSlipMenuViewController ()<WGDropMenuDelegate>
@property (nonatomic , strong) WGDropMenu *dropMenu;
@property (nonatomic , strong) WGDropMenuModel *configuration;
@end

@implementation WGSlipMenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(clickItem)];
    
    WGDropMenuModel *configuration = [[WGDropMenuModel alloc]init];
    
    configuration.titles = [configuration creaFilterDropMenuData];
    /** 配置筛选菜单是否记录用户选中 默认NO */
    configuration.recordSeleted = NO;
    self.configuration = configuration;
}

- (void)clickItem {
  
    @WeakObj(self);
    WGDropMenu *dropMenu = [WGDropMenu creatDropFilterMenuWidthConfiguration:self.configuration dropMenuTagArrayBlock:^(NSArray * _Nonnull tagArray) {
        [selfWeak getStrWith:tagArray];
        
    }];
    dropMenu.titleSeletedImageName = @"up_normal";
    dropMenu.titleNormalImageName = @"down_normal";
    dropMenu.delegate = self;
    dropMenu.durationTime = 0.5;
    self.dropMenu = dropMenu;
    [dropMenu show];
}

#pragma mark - 代理方法
- (void)dropMenu:(WGDropMenu *)dropMenu dropMenuTitleModel:(WGDropMenuModel *)dropMenuTitleModel {
    self.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@",dropMenuTitleModel.title];
}

- (void)dropMenu:(WGDropMenu *)dropMenu tagArray:(NSArray *)tagArray {
    [self getStrWith:tagArray];
}

- (void)getStrWith: (NSArray *)tagArray {
    NSMutableString *string = [NSMutableString string];
    if (tagArray.count) {
        for (WGDropMenuModel *dropMenuTagModel in tagArray) {
            if (dropMenuTagModel.tagSeleted) {
                if (dropMenuTagModel.tagName.length) {
                    [string appendFormat:@"%@",dropMenuTagModel.tagName];
                }
            }
            if (dropMenuTagModel.maxPrice.length) {
                [string appendFormat:@"最大价格%@",dropMenuTagModel.maxPrice];
            }
            if (dropMenuTagModel.minPrice.length) {
                [string appendFormat:@"最小价格%@",dropMenuTagModel.minPrice];
            }
            if (dropMenuTagModel.singleInput.length) {
                [string appendFormat:@"%@",dropMenuTagModel.singleInput];
            }
        }
    }
    self.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@",string];
}

@end
