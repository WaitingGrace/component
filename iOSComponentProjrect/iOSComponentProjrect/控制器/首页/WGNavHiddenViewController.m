//
//  WGNavHiddenViewController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGNavHiddenViewController.h"
#import "Config.h"
#import "WGThrowLineAnimationTool.h"
#import "WGCellImage.h"
#import "WGUIAlertView.h"

#import "WGDetailsPagingVC.h"
#import "WGDetailsNoPagingVC.h"
#import "WGGIFLoadVC.h"
#import "WGDraggableVC.h"
#import "WGGreetingCardVC.h"
#import "WGTheSignatureView.h"

@interface WGNavHiddenViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic ,strong) NSArray * titlesArray;
@property (nonatomic ,strong) WGTheSignatureView * signatureView;
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
    
    self.titlesArray = @[@"gif加载",@"卡片选择",@"生日贺卡（三种样式随机显示",@"手写签名"];
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
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0) {
        cell.imageView.image = [WGCellImage tableViewCell:cell image:[UIImage imageNamed:@"watch"] imageW:40 imageH:40];
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"点击加入购物车"];
        }else{
            cell.textLabel.text = [NSString stringWithFormat:@"点击查看详情--%@",indexPath.row==1?@"分页":@"不分页"];
        }
        return cell;
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld---%@",(long)indexPath.row,self.titlesArray[indexPath.row]];
    }
    
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
        switch (indexPath.row) {
            case 0:
            {
                [[WGThrowLineAnimationTool shareTool]startAnimationandView:cell.imageView andRect:imageViewRect andFinisnRect:CGPointMake(ScreenWidth/4*3, ScreenHeight-49) andFinishBlock:^(BOOL finisn){
                    UIView *tabbarBtn = self.tabBarController.tabBar.subviews[3];
                    [WGThrowLineAnimationTool shakeAnimation:tabbarBtn];
                }];
            }
                break;
            case 1:
            {
                WGDetailsPagingVC *view1VC = [[WGDetailsPagingVC alloc]init];
                [self toTargetController:(UIViewController *)view1VC];

            }
                break;
                case 2:
            {
                WGDetailsNoPagingVC *view2VC = [[WGDetailsNoPagingVC alloc]init];
                [self toTargetController:(UIViewController *)view2VC];
            }
                break;
            default:
                break;
        }
        
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                WGGIFLoadVC * gifVC = [[WGGIFLoadVC alloc]init];
                [self toTargetController:(UIViewController *)gifVC];
            }
                break;
            case 1:
            {
                WGDraggableVC * draVC = [[WGDraggableVC alloc]init];
                [self toTargetController:(UIViewController *)draVC];
            }
                break;
            case 2:
            {
                WGGreetingCardVC * cardVc = [[WGGreetingCardVC alloc]init];
                cardVc.birthdayType = arc4random()%3;
                [self toTargetController:(UIViewController *)cardVc];
            }
                break;
            case 3:
            {
                [self handwrittenSignature];
            }
                break;
            case 4:
            {
                
            }
                break;
            case 5:
            {
               
            }
                break;
            case 6:
            {
                
            }
                break;
            case 7:
            {
                
            }
                break;
            case 8:
            {
                
            }
                break;
            case 9:
            {
                
            }
                break;
            case 10:
            {
               
            }
                break;
            default:
                break;
        }
    }
}

- (void)toTargetController:(UIViewController *)vc{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


/*! 手写签名 */
- (void)handwrittenSignature{
    self.signatureView = [[WGTheSignatureView alloc]init];
    [[UIApplication sharedApplication].keyWindow addSubview:self.signatureView];
    [self.signatureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.bottom.mas_equalTo(0);
    }];
    WeakSelf
    StrongSelf
    self.signatureView.signatureBlock = ^(UIImage *image) {
        
        WGUIAlertConfig *config = [[WGUIAlertConfig alloc] init];
        config.title.text       = @"这是你的签名图片";
        config.contentViewHeight = 480;
        config.title.bottomPadding = 400;
        
        WGUIAlertView *alertView = [[WGUIAlertView alloc] initWithConfig:config];
        
        [alertView addCustomView:^(WGUIAlertView *alertView, CGRect contentViewRect, CGRect titleLabelRect, CGRect contentLabelRect) {
            UIImageView * imageview = [[UIImageView alloc]initWithImage:image];
            imageview.frame = CGRectMake(10, CGRectGetMaxY(titleLabelRect)+10, contentViewRect.size.width-20, 300);
            [alertView.contentView addSubview:imageview];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(10, CGRectGetMaxY(imageview.frame)+10, contentViewRect.size.width-20, 40);
            button.backgroundColor = [UIColor lightGrayColor];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            [button setTitle:@"确定" forState:0];
            [button addTarget:strong_self action:@selector(buttonEvent:) forControlEvents:1<<6];
            [alertView.contentView addSubview:button];
            
        }];
        
        [weak_self.view addSubview:alertView];
    };
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
@end
