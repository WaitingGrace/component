//
//  WGDetailsNoPagingVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/27.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGDetailsNoPagingVC.h"
#import <WebKit/WebKit.h>
#import <MJRefresh.h>
#import "Config.h"

@interface WGDetailsNoPagingVC ()
{
    UIScrollView *detailScrollBaseView;
    UITableView *detailTableView;
    UIWebView *detailWebView;
    
}
@end

@implementation WGDetailsNoPagingVC


- (void)viewDidAppear:(BOOL)animated{
    [self creatDetailTableView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    self.title = @"不分页详情";
}

#pragma mark - creatDetailTableView
- (void)creatDetailTableView
{
    detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight) style:UITableViewStylePlain];
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    [self.view addSubview:detailTableView];
    
    [self creatWebViewForGoodsdetail];

}

#pragma mark - creatWebViewForGoodsdetail
- (void)creatWebViewForGoodsdetail
{
    detailWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight)];
    detailWebView.backgroundColor = [UIColor whiteColor];
    detailWebView.scrollView.contentInset = UIEdgeInsetsMake(detailTableView.bounds.size.height, 0, 0, 0);
    detailWebView.backgroundColor = [UIColor clearColor];
    detailWebView.opaque = NO;
    [self.view addSubview:detailWebView];
    
    
    detailTableView.frame = CGRectMake(0, -detailTableView.bounds.size.height,ScreenWidth, detailTableView.bounds.size.height);
    [detailWebView.scrollView addSubview:detailTableView];
    
    NSURLRequest *webRequest = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://wenku.baidu.com"]];
    [[NSURLSession sharedSession] dataTaskWithRequest:webRequest];
    [detailWebView loadRequest:webRequest];
    
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
            return 419;
            break;
        case 1:
            return 44;
            break;
        case 2:
            return 70;
            break;
        case 3:
        {
            return 52;
        }
            break;
        case 4:
            return 118;
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





@end
