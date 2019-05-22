//
//  WGNormalMenuViewController.m
//
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import "WGNormalMenuViewController.h"
#import "WGDropMenu.h"
#import "WGDropMenuModel.h"

@interface WGNormalMenuViewController ()<WGDropMenuDelegate,WGDropMenuDataSource>
@property (nonatomic , strong)WGDropMenu *dropMenu;

@end

@implementation WGNormalMenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self style1];
}
- (void)back {
    [super back];
    [self.dropMenu closeMenu];
}
#pragma mark - 样式1
- (void)style1 {
    
    @WeakObj(self);
    WGDropMenu *dropMenu = [WGDropMenu creatDropMenuWithConfiguration:nil frame:CGRectMake(0, SafeAreaTopHeight,ScreenWidth, 44) dropMenuTitleBlock:^(WGDropMenuModel * _Nonnull dropMenuModel) {
        selfWeak.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@",dropMenuModel.title];
    } dropMenuTagArrayBlock:^(NSArray * _Nonnull tagArray) {
        [selfWeak getStrWith:tagArray];
    }];
    dropMenu.durationTime = 0.5;
    dropMenu.delegate = self;
    dropMenu.dataSource = self;
    dropMenu.titleSeletedImageName = @"up_normal";
    dropMenu.titleNormalImageName = @"down_normal";
    self.dropMenu = dropMenu;
    [self.view addSubview:dropMenu];
}


#pragma mark - 代理回调
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
        }
    }
    self.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@",string];
}

- (NSArray *)columnTitlesInMeun:(WGDropMenu *)menu {
    return @[@"智能筛选",@"价格",@"品牌",@"时间"];
}
- (NSArray *)menu:(WGDropMenu *)menu numberOfColumns:(NSInteger)columns {
    if (columns == 0) {
        return @[@"价格从高到低",@"价格从低到高",@"距离从远到近",@"销量从低到高",@"信用从高到低"];
    } else if (columns == 1){
        return @[@"0 - 10 元",@"10-20 元",@"20-50 元",@"50-100 元",@"100 - 1000元",@"1000 - 10000 元",@"10000-100000 元",@"100000-500000 元",@"500000-1000000 元",@"1000000以上"];
    } else if (columns== 2){
        return @[@"psp",@"psv",@"nswitch",@"gba",@"gbc",@"gbp",@"ndsl",@"3ds"];
    } else {
        return @[@"上午",@"下午",@"早上",@"晚上",@"清晨",@"黄昏"];
    }
}
@end
