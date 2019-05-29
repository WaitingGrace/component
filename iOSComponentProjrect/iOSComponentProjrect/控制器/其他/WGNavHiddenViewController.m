//
//  WGNavHiddenViewController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGNavHiddenViewController.h"
#import "WGThrowLineAnimationTool.h"

@interface WGNavHiddenViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView * tableView;

@end

@implementation WGNavHiddenViewController

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.rowHeight = 80;
    [self setKeyScrollView:self.tableView scrolOffsetY:60.f options:WGHidenControlOptionTitle];
    [self.view addSubview:self.tableView];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.imageView.image = [UIImage imageNamed:@"watch"];
    CGRect frame = cell.imageView.frame;
    frame.size = CGSizeMake(50, 50);
    cell.imageView.frame = frame;
    cell.textLabel.text = [NSString stringWithFormat:@"点击加入购物车%ld",(long)indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = TitleColor;
    [view addSubview:label];
    if (section == 0) {
        label.text = @"抛物线动画";
    }
    if (section == 1) {
        label.text = @"控件应用";
    }
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
        //获取当前cell 相对于self.view 当前的坐标
        rect.origin.y = rect.origin.y - [tableView contentOffset].y;
        CGRect imageViewRect = cell.imageView.frame;
        imageViewRect.origin.y = rect.origin.y+imageViewRect.origin.y;
        [[WGThrowLineAnimationTool shareTool]startAnimationandView:cell.imageView andRect:imageViewRect andFinisnRect:CGPointMake(ScreenWidth/4*3, ScreenHeight-49) andFinishBlock:^(BOOL finisn){
            UIView *tabbarBtn = self.tabBarController.tabBar.subviews[3];
            [WGThrowLineAnimationTool shakeAnimation:tabbarBtn];
        }];
    }
}

@end
