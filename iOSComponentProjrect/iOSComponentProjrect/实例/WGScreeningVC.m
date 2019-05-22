//
//  WGScreeningVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGScreeningVC.h"
#import "WGComplexMenuViewController.h"
#import "WGSlipMenuViewController.h"
#import "WGNormalMenuViewController.h"
#import "WGSuspendViewController.h"
#import "WGWaterFallViewController.h"

@interface WGScreeningVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSArray *dataArray;

@end

@implementation WGScreeningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = self.tableView;
    self.navigationItem.title = @"筛选菜单";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *navTitle = self.dataArray[indexPath.row];
    if (indexPath.row == 0) {
        WGComplexMenuViewController *vc = [[WGComplexMenuViewController alloc]init];
        vc.navTitle = navTitle;
         [self toTargetController:(UIViewController *)vc];
    } else if (indexPath.row == 1) {
        WGSlipMenuViewController *vc = [[WGSlipMenuViewController alloc]init];
        vc.navTitle = navTitle;
        
        [self toTargetController:(UIViewController *)vc];
    } else if (indexPath.row == 2) {
        WGNormalMenuViewController *vc = [[WGNormalMenuViewController alloc]init];
        vc.navTitle = navTitle;
        
         [self toTargetController:(UIViewController *)vc];
    } else if (indexPath.row == 3) {
        WGSuspendViewController *vc = [[WGSuspendViewController alloc]init];
        vc.navTitle = navTitle;
        
         [self toTargetController:(UIViewController *)vc];
        
    } else if (indexPath.row == 4) {
        WGWaterFallViewController *vc = [[WGWaterFallViewController alloc]init];
        vc.navTitle = navTitle;
        
        [self toTargetController:(UIViewController *)vc];
    }
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellID"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSArray arrayWithObjects:@"复杂筛选菜单",@"只有侧滑筛选菜单",@"普通筛选菜单",@"悬浮筛选菜单(tableView)",@"流水菜单",nil];
    }
    return _dataArray;
}


- (void)toTargetController:(UIViewController *)vc{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
