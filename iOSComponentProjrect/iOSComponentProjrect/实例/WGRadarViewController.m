//
//  WGRadarViewController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/11/7.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGRadarViewController.h"
#import "WGCollectionViewCell.h"
#import "WGPolygonalRadarView.h"
@interface WGRadarViewController ()
<
WGPolygonalRadarViewDataSource,
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
> {
    BOOL _isVertexUp;
    NSInteger _edgeCount;
}

@property (nonatomic, strong) UICollectionView    *collectionView;
@property (nonatomic, strong) UITableView         *tableView;

@property (nonatomic, strong) WGPolygonalRadarView *viRadar;
@property (nonatomic, strong) NSMutableDictionary *randomDataSource;
@property (nonatomic, copy  ) NSArray             *arrRadarTitles;
@property (nonatomic, copy  ) NSArray             *arrDemoOperations;
@end

@implementation WGRadarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackColor;
    
    _randomDataSource = [NSMutableDictionary dictionary];
    _arrRadarTitles = @[@"急加速",@"急转弯",@"超速行驶",@"高峰行驶",@"夜间行驶",@"急减速",@"闯红灯",@"疲劳驾驶"];
    _arrDemoOperations = @[@"重绘",@"边数++",@"边数--",@"切换朝向"];
    _isVertexUp = YES;
    _edgeCount = 3;
    
    [self.view addSubview:self.viRadar];
    [self.view addSubview:self.collectionView];
}

- (WGPolygonalRadarView *)viRadar {
    if (!_viRadar) {
        WGPolygonalRadarBgStyleConfig *bgConfig = [WGPolygonalRadarBgStyleConfig new];
        WGPolygonalRadarStyleConfig *radarConfig0 = [WGPolygonalRadarStyleConfig new];
        //        WGPolygonalRadarStyleConfig *radarConfig1 = [WGPolygonalRadarStyleConfig new];
        radarConfig0.animationDuration = 3;
        
        _viRadar = [[WGPolygonalRadarView alloc] initWithCenter:CGPointMake(self.view.center.x, self.view.bounds.size.height/2)
                                                     dataSource:self
                                                     isVertexUp:_isVertexUp
                                                         radius:120
                                                      edgeCount:_edgeCount
                                                  bgStyleConfig:bgConfig
                                               radarStyleConfig:@[radarConfig0]];
    }
    return _viRadar;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(80, 30);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_viRadar.frame) + 100, self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(_viRadar.frame) - 100) collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[WGCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([WGCollectionViewCell class])];
    }
    return _collectionView;
}

#pragma mark - HPolygonalRadarViewDataSource
- (CGFloat)WGPolygonalRadarValueAtIndex:(NSInteger)index radarIndex:(NSInteger)radarIndex {
    NSString *key = [NSString stringWithFormat:@"%zd%zd", radarIndex, index];
    if ([_randomDataSource valueForKey:key]) {
        return [[_randomDataSource valueForKey:key] floatValue];
    } else {
        CGFloat value = (CGFloat)(arc4random() % 100 + 1) / 100;
        [_randomDataSource setValue:@(value) forKey:key];
        return value;
    }
}

- (UILabel *)WGPolygonalRadarTitleLabelAtIndex:(NSInteger)index {
    UILabel *lb = [UILabel new];
    lb.text = _arrRadarTitles[(index % _arrRadarTitles.count)];
    lb.font = [UIFont boldSystemFontOfSize:15];
    lb.textColor = [UIColor blackColor];
    return lb;
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrDemoOperations.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WGCollectionViewCell class]) forIndexPath:indexPath];
    cell.lbOperation.text = _arrDemoOperations[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *operation = _arrDemoOperations[indexPath.row];
    if ([operation isEqualToString:@"重绘"]) {
        [self resetRadar];
    } else if ([operation isEqualToString:@"边数++"]) {
        _edgeCount++;
        [self resetRadar];
    } else if ([operation isEqualToString:@"边数--"]) {
        if (3 < _edgeCount) {
            _edgeCount--;
            [self resetRadar];
        }
    } else if ([operation isEqualToString:@"切换朝向"]) {
        _isVertexUp = !_isVertexUp;
        [self resetRadar];
    }
}

#pragma mark - 自定义方法
- (void)resetRadar {
    [_viRadar removeFromSuperview];
    _viRadar = nil;
    [_randomDataSource removeAllObjects];
    [self.view addSubview:self.viRadar];
}


@end
