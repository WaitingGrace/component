//
//  WGWaterfallFlowVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/28.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGWaterfallFlowVC.h"
#import "Config.h"
#import "WGWaterFlowLayout.h"
#import "WGCollctionCell.h"
#import "ShopModel.h"
#import "MJRefresh.h"
#import "AFNetworking.h"

@interface WGWaterfallFlowVC ()<WGWaterflowLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSInteger _page;
}
@property (nonatomic ,strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) WGWaterFlowLayout *flowLayout;
@end

@implementation WGWaterfallFlowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"瀑布流";
    self.view.backgroundColor = BackColor;
    self.flowLayout = [[WGWaterFlowLayout alloc]init];
    //设置列数
    self.flowLayout.colCount = 2;
    self.flowLayout.delegate = self;
    _page = 1;
    
    [self.view addSubview:self.collectionView];
    [self loadData];
}

- (void)refreshData{
    _page = 1;
    [self loadData];
}
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WGCollctionCell class]) bundle:nil] forCellWithReuseIdentifier:@"Cell"];
        @WeakObj(self)
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [selfWeak refreshData];
        }];
        [header setTitle:@"Health" forState:MJRefreshStatePulling];
        [header beginRefreshing];
        _collectionView.mj_header = header;
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self->_page ++;
            [selfWeak loadData];
        }];
    }
    return _collectionView;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)loadData{
    NSString *url = @"http://www.xiaohongchun.com/api2/index/gvideo?release=2.0&udid=765879";
    NSDictionary * para = @{@"page":@(_page),@"cid":@(_page - 1)};
    @WeakObj(self);
    [WGAFttpTool GETWithPath:url params:para success:^(id responseObject) {
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (self->_page == 1) {
            [selfWeak.dataArray removeAllObjects];
        }
        NSArray *dataArr = dataDict[@"data"];
        NSLog(@"%@",dataArr);
        for (NSDictionary *dict in dataArr) {
            ShopModel *model = [ShopModel shopWithDict:dict];
            [selfWeak.dataArray addObject:model];
        }
        selfWeak.flowLayout.shops = selfWeak.dataArray;
        [selfWeak.collectionView reloadData];
        
        [selfWeak.collectionView.mj_header endRefreshing];
        [selfWeak.collectionView.mj_footer endRefreshing];
    } failure:nil];
}

#pragma mark ---<UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WGCollctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    ShopModel *model = self.dataArray[indexPath.row];
    cell.backgroundColor = [UIColor yellowColor];
    cell.model = model;
    return cell;
}

- (CGFloat)waterflowLayout:(WGWaterFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    ShopModel *shop = self.dataArray[indexPath.item];
    CGFloat height = [shop.desc heightWithFont:[UIFont systemFontOfSize:14] withinWidth:width - 16];
    CGFloat totalHeight = height + 154;
    return totalHeight;
}

//#pragma mark -
//#pragma mark - 设置cell即将出现的方法  做3D动画出场
//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    cell.layer.transform=CATransform3DMakeScale(0.8, 0.8, 0.8);
//    [UIView animateWithDuration:0.6 animations:^{
//        cell.layer.transform=CATransform3DMakeScale(1, 1, 1);
//    }];
//
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopModel * model = self.dataArray[indexPath.row];
    NSLog(@"%@",model.title);
}


@end
