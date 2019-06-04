//
//  WGDetailsPagingVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/27.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGDetailsPagingVC.h"
#import <MJRefresh.h>
#import <WebKit/WebKit.h>
#import "Config.h"



@interface WGDetailsPagingVC ()
{
    UIScrollView *detailScrollBaseView;
    UITableView *detailTableView;
    WKWebView *detailWebView;

}
@end

@implementation WGDetailsPagingVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    self.title = @"分页详情";

    
    [self creatDetailScrollView];
}
#pragma mark - creatDetailScrollView
- (void)creatDetailScrollView
{
    detailScrollBaseView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight-NavHeight)];
    detailScrollBaseView.showsVerticalScrollIndicator = NO;
    detailScrollBaseView.showsHorizontalScrollIndicator = NO;
    detailScrollBaseView.bounces = NO;
    [detailScrollBaseView setContentSize:CGSizeMake(ScreenWidth, (ScreenHeight-NavHeight) * 2)];
    detailScrollBaseView.pagingEnabled = YES;
    detailScrollBaseView.scrollEnabled = NO;
    [self.view addSubview:detailScrollBaseView];
    [self creatDetailTableView];
    [self creatWebViewForGoodsdetail];
    
}
#pragma mark - creatDetailTableView
- (void)creatDetailTableView
{
    detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavHeight) style:UITableViewStylePlain];
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    [detailScrollBaseView addSubview:detailTableView];
    [self detail_addRefreshAndMore];
}

#pragma mark - creatWebViewForGoodsdetail
- (void)creatWebViewForGoodsdetail
{
    detailWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, ScreenHeight-NavHeight, ScreenWidth, ScreenHeight-NavHeight)];
    detailWebView.backgroundColor = [UIColor whiteColor];
    NSURLRequest *webRequest = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://wenku.baidu.com"]];
    [[NSURLSession sharedSession] dataTaskWithRequest:webRequest];
    [detailWebView loadRequest:webRequest];
    
    [detailScrollBaseView addSubview:detailWebView];
    [self webDetail_addRefreshAndMore];
    
    
}

#pragma mark - detail_addRefreshAndMore
- (void)detail_addRefreshAndMore
{
    @WeakObj(self)
    detailTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self->detailScrollBaseView setContentOffset:CGPointMake(0, ScreenHeight - NavHeight) animated:YES];

        [selfWeak detail_endRefresh];
    }];
    
    MJRefreshBackStateFooter *footer = (MJRefreshBackNormalFooter *)detailTableView.mj_footer;
    [footer setTitle:@"放开加载..." forState:MJRefreshStatePulling];
    [footer setTitle:@"上拉加载更多..." forState:MJRefreshStateIdle];
    [footer setTitle:@"放开加载..." forState:MJRefreshStateRefreshing];
}

- (void)detail_endRefresh
{
    [detailTableView.mj_footer endRefreshing];
}

#pragma mark - webDetail_addRefreshAndMore
- (void)webDetail_addRefreshAndMore
{
    @WeakObj(self)

    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self->detailScrollBaseView setContentOffset:CGPointMake(0, 0) animated:YES];

        [selfWeak webdetail_endRequestMore];
    }];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字
    [header setTitle:@"下拉返回..." forState:MJRefreshStateIdle];
    [header setTitle:@"放开返回..." forState:MJRefreshStatePulling];
    [header setTitle:@"放开返回..." forState:MJRefreshStateRefreshing];
    detailWebView.scrollView.mj_header = header;
}
- (void)webdetail_endRequestMore
{
    [detailWebView.scrollView.mj_header endRefreshing];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 450;
            break;
        case 1:
            return 44;
            break;
        case 2:
            return 70;
            break;
        case 3:
        {
            return 99;
        }
            break;
        case 4:
            return 150;
            break;
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"你的UI布局";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
