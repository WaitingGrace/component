//
//  WGWaterFallViewController.m
//
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import "WGWaterFallViewController.h"
#import "WGWaterFallCell.h"

@interface WGWaterFallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** 顶部菜单 */
@property (nonatomic , strong) UICollectionView *collectionView;
/** 顶部菜单布局 */
@property (nonatomic , strong) UICollectionViewFlowLayout *flowLayout;
@end

@implementation WGWaterFallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WGWaterFallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WGWaterFallCellID" forIndexPath:indexPath];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ScreenWidth,  ScreenHeight);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumLineSpacing = 0.01f;
        _flowLayout.minimumInteritemSpacing = 0.01f;
        _flowLayout.itemSize = CGSizeMake(ScreenWidth, 100);
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, ScreenHeight - SafeAreaTopHeight - SafeAreaBottomHeight) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.layer.borderColor = [UIColor clearColor].CGColor;
        [_collectionView registerClass:[WGWaterFallCell class] forCellWithReuseIdentifier:@"WGWaterFallCellID"];
    }
    return _collectionView;
}


@end
